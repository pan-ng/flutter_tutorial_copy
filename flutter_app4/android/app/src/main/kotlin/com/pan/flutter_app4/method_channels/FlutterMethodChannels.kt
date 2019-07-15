package com.pan.flutter_app4.method_channels

import android.util.Log
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel
import java.util.*


object FlutterMethodChannels {

    private var registered = false;

    init {

    }

    fun registerWith(flutterActivity: FlutterActivity) {
        if(registered){
            return
        }
        try {


            val channel = MethodChannel(flutterActivity.flutterView, "pan.flutter.dev/default_method_channel");

            channel.setMethodCallHandler { call, result ->
                if(call.method == "getDebugMsg"){


                    val arguments = call.arguments as? Map<String, Any>
                    arguments?.forEach { (k, v) ->
                        Log.d("TAG", "entry = ${k}, ${v}")
                    }



                    channel.invokeMethod("getDartNumber", null, object : MethodChannel.Result {
                        override fun notImplemented() {

                        }

                        override fun error(p0: String?, p1: String?, p2: Any?) {
                            Log.d("TAG", "error = ${p1}, ${p2}")

                        }

                        override fun success(p0: Any?) {
                            Log.d("TAG", "success = ${p0}")

                        }
                    })


                    result.success("Msg from Android: received = ${Date()}, call arg = ${arguments}")
                }
            }

        } finally {
            registered = true
        }
    }

}