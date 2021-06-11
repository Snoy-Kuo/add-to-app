package com.snoy.apptoapp.android.model

data class QuotItem(val id: String, val name: String, var price: Double = 0.0) {
    fun toJson(): Map<String, *> {
        return mapOf<String, Any>(
            "id" to id,
            "name" to name,
            "price" to price
        )
    }
}