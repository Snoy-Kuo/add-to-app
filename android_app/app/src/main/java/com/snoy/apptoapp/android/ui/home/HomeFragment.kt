package com.snoy.apptoapp.android.ui.home

import com.snoy.apptoapp.android.App
import com.snoy.apptoapp.android.ui.MainActivity
import com.snoy.apptoapp.android.ui.NewsDetailActivity
import com.snoy.apptoapp.android.ui.WebViewActivity
import io.flutter.embedding.android.FlutterFragment
import io.flutter.embedding.android.RenderMode
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class HomeFragment : FlutterFragment() {
    companion object {
        const val CHANNEL_NAME = "flutter_home_page"
        const val HOST_OPEN_URL = "HOST_OPEN_URL"
        const val HOST_OPEN_NEWS_TYPE = "HOST_OPEN_NEWS_TYPE"
        const val HOST_OPEN_NEWS_DETAIL = "HOST_OPEN_NEWS_DETAIL"
    }

    private var channel: MethodChannel? = null

    override fun shouldAttachEngineToActivity(): Boolean {
        return false
    }

    override fun getRenderMode(): RenderMode {
        return RenderMode.texture
    }

    override fun getCachedEngineId(): String {
        return App.HOME_ENGINE_ID
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        initChannel(flutterEngine)
    }

    private fun initChannel(engine: FlutterEngine) {
        channel = MethodChannel(engine.dartExecutor.binaryMessenger, CHANNEL_NAME)
        channel!!.setMethodCallHandler { call, result ->
            when (call.method) {
                HOST_OPEN_URL -> {
                    try {
                        WebViewActivity.openActivity(
                            context = context,
                            url = call.arguments.toString()
                        )
                        result.success(null)
                    } catch (e: Exception) {
                        result.error("OPEN URL ERROR", e.message, null)
                    }
                }
                HOST_OPEN_NEWS_TYPE -> {
                    try {
                        MainActivity.openTab(context, 1, call.arguments as Int + 1)
                        result.success(null)
                    } catch (e: Exception) {
                        result.error("OPEN NEWS TYPE ERROR", e.message, null)
                    }
                }
                HOST_OPEN_NEWS_DETAIL -> {
                    try {
                        NewsDetailActivity.openActivity(
                            context,
                            call.argument("id") ?: -1,
                            call.argument("title") ?: ""
                        )
                        result.success(null)
                    } catch (e: Exception) {
                        result.error("OPEN NEWS TYPE ERROR", e.message, null)
                    }
                }
                else -> {
                    result.notImplemented()
                }
            }

        }
    }
}