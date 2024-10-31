package com.taebbong.chung_mo

import android.content.Intent
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "com.taebbong.share_intent"
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
            when (intent.type) {
                "text/plain" -> {
                    // Handle plain text
                    sharedData = intent.getStringExtra(Intent.EXTRA_TEXT)
                }
                "text/uri-list" -> {
                    // Handle URL
                    sharedData = intent.getParcelableExtra<Uri>(Intent.EXTRA_STREAM)?.toString()
                }
            }
        }
    }
}

