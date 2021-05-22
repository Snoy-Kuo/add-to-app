package com.snoy.apptoapp.android.ui.info

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel

class InfoViewModel : ViewModel() {
    private val _text = MutableLiveData<String>().apply {
        value = "This is info Fragment"
    }
    val text: LiveData<String> = _text

    fun setText(subIndex: Int) {
        val subIndexText = when (subIndex) {
            0 -> "All News"
            1 -> "Good News"
            else -> "Bad News"
        }
        _text.value = "This is info Fragment,\nType=$subIndexText"
    }
}