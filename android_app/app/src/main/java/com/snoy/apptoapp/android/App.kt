package com.snoy.apptoapp.android

import android.app.Application
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor

class App : Application() {

    companion object {
        const val HOME_ENGINE_ID = "HOME_ENGINE_ID"
        var isRealtimeQuot = false
        var isRookie = true
    }

    private val homeEngine: FlutterEngine by lazy {
        FlutterEngine(this.applicationContext)
    }

    override fun onCreate() {
        super.onCreate()

        // Somewhere in your app, before your FlutterFragment is needed,
        // like in the Application class ...
        // Instantiate a FlutterEngine.

        // Start executing Dart code in the FlutterEngine.
        homeEngine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )

        // Cache the pre-warmed FlutterEngine to be used later by FlutterFragment.
        FlutterEngineCache
            .getInstance()
            .put(HOME_ENGINE_ID, homeEngine)
    }
}