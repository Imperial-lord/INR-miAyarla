package com.example.health_bag

import android.content.Intent;
import android.os.Bundle;

import androidx.annotation.NonNull;

import io.flutter.plugin.common.MethodChannel;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;

class MainActivity: FlutterActivity() {
    private var sharedText: String? = null
    private val CHANNEL = "app.channel.shared.data"

    override protected fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val intent: Intent = getIntent()
        val action: String? = intent.getAction()
        val type: String? = intent.getType()
        if (Intent.ACTION_SEND.equals(action) && type != null) {
            if ("text/plain".equals(type)) {
                handleSendText(intent) // Handle text being sent
            }
        }
    }


    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler { call, result ->
                    if (call.method.contentEquals("getSharedText")) {
                        result.success(sharedText)
                        sharedText = null
                    }
                }
    }

    fun handleSendText(intent: Intent) {
        sharedText = intent.getStringExtra(Intent.EXTRA_TEXT)
    }
}
