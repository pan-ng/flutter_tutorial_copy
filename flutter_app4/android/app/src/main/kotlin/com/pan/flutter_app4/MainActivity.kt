package com.pan.flutter_app4

import android.os.Bundle
import com.pan.flutter_app4.method_channels.FlutterMethodChannels

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
        FlutterMethodChannels.registerWith(this);
    }
}
