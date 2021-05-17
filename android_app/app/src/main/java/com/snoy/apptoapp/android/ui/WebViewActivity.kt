package com.snoy.apptoapp.android.ui

import android.annotation.SuppressLint
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.view.View
import android.webkit.*
import androidx.appcompat.app.AppCompatActivity
import com.snoy.apptoapp.android.databinding.ActivityWebViewBinding

class WebViewActivity : AppCompatActivity() {

    companion object {

        fun openActivity(context: Context, url: String) {
            val intent = Intent(context, WebViewActivity::class.java).apply {
                putExtra("url", url)
            }
            context.startActivity(intent)
        }
    }

    private lateinit var binding: ActivityWebViewBinding
    private lateinit var webview: WebView
    private var url: String? = null
    private val myWebChromeClient by lazy {
        object : WebChromeClient() {
            override fun onProgressChanged(view: WebView?, newProgress: Int) {
                binding.progressBar.progress = newProgress
                binding.progressBar.visibility =
                    if (newProgress < 100) View.VISIBLE else View.GONE

                super.onProgressChanged(view, newProgress)
            }
        }
    }
    private val myWebClient by lazy {
        object : WebViewClient() {

            override fun onReceivedError(
                view: WebView?, request: WebResourceRequest?, error: WebResourceError?
            ) {
                super.onReceivedError(view, request, error)
                Log.d("RDTest", "onReceivedError, error=$error")
                //TODO: show custom error page
            }
        }
    }

    @SuppressLint("SetJavaScriptEnabled")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        binding = ActivityWebViewBinding.inflate(layoutInflater)
        setContentView(binding.root)

        val toolbar = binding.toolBar
        toolbar.setNavigationOnClickListener {
            finish()
        }

        webview = binding.webview
        webview.settings.domStorageEnabled = true
        webview.settings.javaScriptEnabled = true
        webview.webChromeClient = myWebChromeClient //progress handling
        webview.webViewClient = myWebClient //error handling
        url = intent.getStringExtra("url")
        url?.let { webview.loadUrl(it) }
    }
}