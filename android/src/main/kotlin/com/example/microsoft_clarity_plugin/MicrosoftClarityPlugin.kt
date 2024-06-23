package com.example.microsoft_clarity_plugin

import android.annotation.SuppressLint
import android.content.Context
import com.microsoft.clarity.Clarity
import com.microsoft.clarity.ClarityConfig
import com.microsoft.clarity.models.ApplicationFramework
import com.microsoft.clarity.models.LogLevel

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** MicrosoftClarityPlugin */
class MicrosoftClarityPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel: MethodChannel
  private lateinit var context: Context

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "microsoft_clarity_plugin")
    channel.setMethodCallHandler(this)
  }

  @SuppressLint("DiscouragedApi")
  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "initializeMicrosoftClarity") {
      val resId = context.resources.getIdentifier("microsoft_clarity_project_id", "string", context.packageName)
      if (resId != 0) {
        val projectId = context.getString(resId)
        initializeMicrosoftClarity(context, projectId)
        result.success("Clarity Initialized")
      } else {
        result.error("NOT_FOUND", "Project ID not found", null)
      }
    } else if(call.method == "setCustomUserId") {
      val customUserId: String? = call.argument("customUserId");
      if (customUserId == null) {
        result.error("INVALID_ARGUMENT", "customUserId is required", null)
      } else {
        Clarity.setCustomUserId(customUserId)
        result.success("Custom User Id set successfully")
      }
    } else if(call.method == "getCurrentSessionId") {
      result.success(Clarity.getCurrentSessionId());
    } else {
      result.notImplemented()
    }
  }

  private fun initializeMicrosoftClarity(context: Context?, projectId: String) {
    context?.let {
      val config = ClarityConfig(
        projectId = projectId,
        userId = null, // Default user id
        logLevel = LogLevel.None,
        allowMeteredNetworkUsage = true, // Disallow metered network usage
        enableWebViewCapture = true, // Enable web view capturing
        allowedDomains = listOf("*"), // Allowed domains
        applicationFramework = ApplicationFramework.Native,
        allowedActivities = listOf(), // Allowed activities
        disallowedActivities = listOf(), // Disallowed activities (ignore activities)
        disableOnLowEndDevices = false,
        maximumDailyNetworkUsageInMB = null,// Disable on low-end devices
      )
      Clarity.initialize(it.applicationContext, config)
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
