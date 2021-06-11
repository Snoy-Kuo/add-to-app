package com.snoy.apptoapp.android.model

import kotlinx.coroutines.flow.Flow

interface RealtimeQuotRepo {
    fun observeRealtimeQuote(): Flow<QuotItem?>
    suspend fun updateQuot(): QuotItem?
    suspend fun toggleRealtimeQuote(enable: Boolean)
}