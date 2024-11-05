package com.taebbong.chung_mo

import android.content.Intent
import android.os.Bundle
import android.net.Uri
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "com.taebbong.chungMo.share_intent"
    private var sharedData: String? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        handleIntent(intent)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getSharedData") {
                result.success(sharedData)
            } else {
                result.notImplemented()
            }
        }
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        handleIntent(intent)
    }

    private fun handleIntent(intent: Intent) {
        if (Intent.ACTION_SEND == intent.action && intent.type != null) {
            println("Intent Type: ${intent.type}")
            println("EXTRA_TEXT: ${intent.getStringExtra(Intent.EXTRA_TEXT)}")
            println("EXTRA_STREAM: ${intent.getParcelableExtra<Uri>(Intent.EXTRA_STREAM)?.toString()}")
            when (intent.type) {
                "text/plain" -> {
                    // Attempt to retrieve data from both possible fields
                    val textData = intent.getStringExtra(Intent.EXTRA_TEXT)
                    val uriData = intent.getParcelableExtra<Uri>(Intent.EXTRA_STREAM)?.toString()
                    
                    // Debug logging to verify which field has the data
                    println("Received data from EXTRA_TEXT: $textData")
                    println("Received data from EXTRA_STREAM: $uriData")

                    // Use the first non-null value
                    sharedData = textData ?: uriData
                }
                else -> {
                    sharedData = null
                }
            }
        }
    }
}

