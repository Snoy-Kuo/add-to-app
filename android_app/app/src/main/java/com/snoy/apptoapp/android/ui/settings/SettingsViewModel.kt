package com.snoy.apptoapp.android.ui.settings

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.snoy.apptoapp.android.R

class SettingsViewModel : ViewModel() {

    private val _textRes = MutableLiveData<Int>().apply {
        value = R.string.this_is_settings_fragment
    }
    val textRes: LiveData<Int> = _textRes
}