package com.flutter.seewo.level_channel_example

import android.os.Bundle
import android.view.View
import androidx.annotation.Nullable
import com.flutter.seewo.level_channel.LevelChannelInterface
import com.flutter.seewo.level_channel.LevelChannelPlugin
import io.flutter.embedding.android.FlutterActivity
import org.json.JSONObject

class MainActivity: FlutterActivity() {
    private var channel: LevelChannelInterface? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        onCustomCreate()
    }
    override fun onFlutterUiDisplayed() {
        super.onFlutterUiDisplayed()
        postEvent()

    }



    fun onCustomCreate() {
        var m = flutterEngine?.plugins?.get(LevelChannelPlugin::class.java)
        if (m is LevelChannelPlugin) {
            channel = m.channel
        }
        channel?.addPostObserver("/navtive/show") { re ->
        }

        channel?.addGetObserver("/navtive/get") { re, result ->
            val lo = JSONObject()
            lo.put("key", "vale")
            result(lo)
        }
    }

    fun postEvent() {
        val lo = JSONObject()
        lo.put("what", 123)
        channel?.post("/flutter/show", lo)

        channel?.get("/flutter/get", parameters = lo) { re ->
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        channel?.removePostObserver("/flutter/show")
        channel?.removeGetObserver("/navtive/get")
    }
}
