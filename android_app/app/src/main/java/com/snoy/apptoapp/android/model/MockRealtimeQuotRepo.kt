package com.snoy.apptoapp.android.model

import kotlinx.coroutines.*
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import java.math.RoundingMode
import kotlin.coroutines.CoroutineContext
import kotlin.random.Random

class MockRealtimeQuotRepo(
    private var fakeItem: QuotItem? = null,
    private var delay: Long = 0L,
    private var coroutineContext: CoroutineContext = Dispatchers.IO
) : RealtimeQuotRepo {

    private val random: Random = Random.Default
    private var isRealtime: Boolean = false
    private val _updateData = MutableStateFlow<QuotItem?>(null)
    private val updateData: StateFlow<QuotItem?> = _updateData
    private var job: Job? = null

    companion object {
        private val mapProd = mapOf(
            "A" to "Android",
            "B" to "Basic",
            "C" to "C++",
            "D" to "Dart",
            "E" to "ECMAScript",
            "F" to "Flutter",
            "G" to "Go",
            "H" to "Haskell",
            "I" to "iOS",
            "J" to "Java",
            "K" to "Kotlin",
            "L" to "Lua",
            "M" to "MATLAB",
            "N" to "Nim",
            "O" to "ObjectiveC",
            "P" to "Python",
            "Q" to "Qt",
            "R" to "Ruby",
            "S" to "Swift",
            "T" to "TypeScript",
            "U" to "UNITY",
            "V" to "Visual FoxPro",
            "W" to "WebAssembly",
            "X" to "XML",
            "Y" to "YAML",
            "Z" to "Zsh",
        )
    }

    override suspend fun updateQuot(): QuotItem {
        delay(if (delay >= 1) delay else randomDelay())
        return fakeItem ?: defaultFakeItem()
    }

    ///random duration from 100ms~500ms
    private fun randomDelay(): Long {
        return random.nextLong(400) + 100
    }

    ///random price from 100~999
    private fun randomPrice(): Double {
        return (random.nextDouble() * (999 - 100) + 100).toBigDecimal()
            .setScale(3, RoundingMode.HALF_UP).toDouble()
    }

    ///random product from _mapProd
    private fun randomItem(): QuotItem {
        val list: List<Map.Entry<String, String>> = mapProd.entries.toList()
        val index = random.nextInt(list.size)
        return QuotItem(id = list[index].key, name = list[index].value)
    }

    private fun defaultFakeItem(): QuotItem {
        return randomItem().apply { price = randomPrice() }
    }

    override fun observeRealtimeQuote(): Flow<QuotItem?> {
        return updateData
    }

    override suspend fun toggleRealtimeQuote(enable: Boolean) {
        isRealtime = enable
        if (isRealtime) {
            if (job == null) {
                job = CoroutineScope(coroutineContext).launch {
                    while (isRealtime) { // cancellable computation loop
                        _updateData.value = updateQuot()
                    }
                }
            }
        } else {
            job?.cancelAndJoin() // cancels the job and waits for its completion
            job = null
        }
    }
}