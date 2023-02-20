package com.flutter.seewo.level_channel

import android.os.Handler
import android.os.Looper
import androidx.annotation.UiThread
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.JSONMessageCodec
import org.json.JSONObject
import java.util.*
import java.util.concurrent.Executors
import kotlin.collections.HashMap

interface LevelChannelInterface {
    fun get(path: String, parameters: JSONObject? = null, callback: (JSONObject?) -> Unit)

    fun post(path: String, parameters: JSONObject? = null )

    fun addGetObserver(path: String, callback:(JSONObject?,  (JSONObject) -> Unit) -> Unit)

    fun removeGetObserver(path: String)

    fun addPostObserver(path: String, callback: (JSONObject?) -> Unit)

    fun removePostObserver(path: String)

    fun deInit()
}

class LevelChannelManager(binaryMessenger: BinaryMessenger) : LevelChannelInterface {

    class GetObserver(path: String, callback: (JSONObject?, ((JSONObject)->Unit))->Unit) {
        val mPath: String = path
        val mCallback: ((JSONObject?, ((JSONObject)->Unit))->Unit) = callback
    }

    class PostObserver(path: String, callback: (JSONObject?) -> Unit) {
        val mPath: String = path
        val mCallback: ((JSONObject?) -> Unit) = callback
    }

    class Response(path: String, identify: String, callback: (JSONObject?) -> Unit) {
        val mPath: String = path
        val mIdentify: String = identify
        val mCallback: ((JSONObject?) -> Unit) = callback
    }

    private val writerChannel = BasicMessageChannel(binaryMessenger,
        "com.flutter.seewo.plugins/level_channel/reader",
        JSONMessageCodec.INSTANCE,
        binaryMessenger.makeBackgroundTaskQueue())

    private val readerChannel = BasicMessageChannel(binaryMessenger,
        "com.flutter.seewo.plugins/level_channel/writer",
        JSONMessageCodec.INSTANCE,
        binaryMessenger.makeBackgroundTaskQueue())

    private val responsesMap: HashMap<String, Response> = HashMap()
    private val getObserversMap: HashMap<String, GetObserver> = HashMap()
    private val postObserversMap: HashMap<String, PostObserver> = HashMap()

    private val dispatcher = Executors.newFixedThreadPool(3)

    init {
        readerChannel.setMessageHandler { message, reply ->
            try {
                if (message != null && message is JSONObject) {
                    dispatcher.submit {
                        didReadData(message)
                    }
                }
            } catch (e: Exception) {
                e.printStackTrace()
            }finally {
                reply.reply(null)
            }
        }
    }

    private fun didReadData(message: JSONObject) {
        val method = message.optString("method")
        val path = message.optString("path")
        val identify = message.optString("id")
        val data = message.optJSONObject("data")
        when (method) {
            "request" -> {
                val observer = getObserversMap[path]
                observer?.mCallback?.let {
                    it(data) { re ->
                        Handler(Looper.getMainLooper()).post {
                            // Call the desired channel message here.
                            send(path, "response", identify = identify, parameters = re)
                        }
                    }
                }
            }
            "response" -> {
                val key = "${path}request${identify}"
                val response = responsesMap.remove(key)
                response?.mCallback?.invoke(data)
            }
            "observer" -> {
                val observer = postObserversMap[path]
                observer?.mCallback?.invoke(data)
            }
            else -> {

            }
        }
    }

    @UiThread
    private fun send(path: String, method: String, identify: String? = null, parameters: JSONObject? = null) {
        val request = JSONObject()
        request.put("path", path)
        request.put("method", method)
        if (parameters != null) {
            request.put("data", parameters)
        }
        if (identify != null) {
            request.put("id", identify)
        }
        writerChannel.send(request)
    }

    @UiThread
    override fun get(path: String, parameters: JSONObject?, callback: (JSONObject?) -> Unit) {
        val identify = UUID.randomUUID().toString()
        val key =  "${path}request${identify}"
        val response = Response(path, identify, callback)
        responsesMap[key] = response
        send(path, "request", identify = identify, parameters = parameters)
    }

    @UiThread
    override fun post(path: String, parameters: JSONObject?) {
        send(path, "observer", parameters = parameters)
    }

    override fun addGetObserver(path: String, callback:(JSONObject?,  (JSONObject) -> Unit) -> Unit) {
        val observer = GetObserver(path, callback)
        getObserversMap[path] = observer
    }

    override fun removeGetObserver(path: String) {
        getObserversMap.remove(path)
    }

    override fun addPostObserver(path: String, callback: (JSONObject?) -> Unit) {
        val observer =  PostObserver(path, callback)
        postObserversMap[path] = observer
    }

    override fun removePostObserver(path: String) {
        postObserversMap.remove(path)
    }

    override fun deInit() {
        getObserversMap.clear()
        postObserversMap.clear()
        responsesMap.clear()
        readerChannel.setMessageHandler(null)
    }
}

