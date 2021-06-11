package com.snoy.apptoapp.android.ui.home

import android.os.Bundle
import android.view.View
import androidx.lifecycle.LiveData
import androidx.lifecycle.asLiveData
import androidx.lifecycle.lifecycleScope
import com.snoy.apptoapp.android.App
import com.snoy.apptoapp.android.model.MockRealtimeQuotRepo
import com.snoy.apptoapp.android.model.QuotItem
import com.snoy.apptoapp.android.model.RealtimeQuotRepo
import com.snoy.apptoapp.android.ui.MainActivity
import com.snoy.apptoapp.android.ui.NewsDetailActivity
import com.snoy.apptoapp.android.ui.QuotDetailActivity
import com.snoy.apptoapp.android.ui.WebViewActivity
import io.flutter.embedding.android.FlutterFragment
import io.flutter.embedding.android.RenderMode
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.launch

class HomeFragment : FlutterFragment() {
    companion object {
        const val CHANNEL_NAME = "flutter_home_page"
        const val HOST_OPEN_URL = "HOST_OPEN_URL"
        const val HOST_OPEN_NEWS_TYPE = "HOST_OPEN_NEWS_TYPE"
        const val HOST_OPEN_NEWS_DETAIL = "HOST_OPEN_NEWS_DETAIL"
        const val HOST_OPEN_QUOT_DETAIL = "HOST_OPEN_QUOT_DETAIL"
        const val CLIENT_UPDATE_QUOT = "CLIENT_UPDATE_QUOT"
    }

    private var channel: MethodChannel? = null
    private val repo: RealtimeQuotRepo = MockRealtimeQuotRepo() //TODO: move to vm
    private val observableQuotIem: LiveData<QuotItem?> = repo.observeRealtimeQuote().asLiveData()

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

    private fun initQuotUpdate() {
        observableQuotIem.observe(viewLifecycleOwner, {
            it?.let {
                channel?.invokeMethod(CLIENT_UPDATE_QUOT, it.toJson())
            }
        })
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        initQuotUpdate()
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
                        result.error("OPEN NEWS DETAIL ERROR", e.message, null)
                    }
                }
                HOST_OPEN_QUOT_DETAIL -> {
                    try {
                        QuotDetailActivity.openActivity(
                            context,
                            call.argument("id") ?: "",
                            call.argument("name") ?: ""
                        )
                        result.success(null)
                    } catch (e: Exception) {
                        result.error("OPEN QUOT DETAIL ERROR", e.message, null)
                    }
                }
                else -> {
                    result.notImplemented()
                }
            }

        }
    }

    override fun onHiddenChanged(hidden: Boolean) {
        super.onHiddenChanged(hidden)
        if (!hidden) {
            this.onResume()
        } else {
            this.onPause()
        }
    }

    override fun onResume() {
        super.onResume()
        lifecycleScope.launch {
            repo.toggleRealtimeQuote(App.isRealtimeQuot)
        }
    }

    override fun onPause() {
        lifecycleScope.launch {
            repo.toggleRealtimeQuote(false)
        }
        super.onPause()
    }
}