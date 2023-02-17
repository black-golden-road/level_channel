package com.flutter.seewo.level_channel_example

import android.os.Bundle
import android.os.PersistableBundle
import com.flutter.seewo.level_channel.LevelChannelInterface
import com.flutter.seewo.level_channel.LevelChannelPlugin
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {
    private var channel: LevelChannelInterface? = null
    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)
        var m = flutterEngine?.plugins?.get(LevelChannelPlugin::class.java)
        if (m is LevelChannelPlugin) {
            channel = m.channel
        }
        channel?.addPostObserver("test") { re ->
            println(re.toString())
        }
    }
}
