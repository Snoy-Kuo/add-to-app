package com.snoy.apptoapp.android.util

import android.app.Activity
import android.content.Context
import android.graphics.Color
import android.os.Build
import android.view.View
import android.view.WindowInsets
import android.view.WindowInsetsController
import android.view.WindowManager

fun Activity.hideSystemUI() {
    when {
        Build.VERSION.SDK_INT >= Build.VERSION_CODES.R -> {
            window.setDecorFitsSystemWindows(false)
            window.insetsController?.let {
                it.hide(WindowInsets.Type.statusBars())
                it.systemBarsBehavior = WindowInsetsController.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
            }
        }
        Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP -> {
            this.window.statusBarColor = Color.TRANSPARENT
            @Suppress("DEPRECATION")
            this.window.decorView.systemUiVisibility =
                View.SYSTEM_UI_FLAG_LAYOUT_STABLE or View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
        }
        else ->
            @Suppress("DEPRECATION")
            this.window
                .setFlags(
                    WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS,
                    WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS
                )
    }
}

fun View.setStatusViewHeight() {
    val params = this.layoutParams
    params.height = context.getStatusBarHeight()
    this.layoutParams = params
}

private fun Context.getStatusBarHeight(): Int {
    val resourceId = this.resources.getIdentifier("status_bar_height", "dimen", "android")
    return this.resources.getDimensionPixelSize(resourceId)
}