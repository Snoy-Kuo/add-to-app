package com.snoy.apptoapp.android.ui.info

import android.content.Context
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.snoy.apptoapp.android.R

class InfoViewModel : ViewModel() {
    private val _text = MutableLiveData<String>().apply {
        value = "This is info Fragment"
    }
    val text: LiveData<String> = _text

    fun setText(context: Context, subIndex: Int) {
        val subIndexText = when (subIndex) {
            0 -> context.getString(R.string.all_news)
            1 -> context.getString(R.string.good_news)
            2 -> context.getString(R.string.bad_news)
            3 -> context.getString(R.string.flash_news)
            4 -> context.getString(R.string.calendar_news)
            else -> "What News"
        }
        _text.value = context.getString(R.string.this_is_info_widget, subIndexText)
    }
}