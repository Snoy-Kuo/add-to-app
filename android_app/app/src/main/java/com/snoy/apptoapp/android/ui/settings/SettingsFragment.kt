package com.snoy.apptoapp.android.ui.settings

import android.content.Context
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.RadioButton
import android.widget.TextView
import androidx.appcompat.app.AppCompatDelegate
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProvider
import com.snoy.apptoapp.android.App
import com.snoy.apptoapp.android.R
import com.snoy.apptoapp.android.databinding.FragmentSettingsBinding
import com.snoy.apptoapp.android.ui.MainActivity
import com.snoy.apptoapp.android.ui.WebViewActivity
import com.snoy.apptoapp.android.util.setStatusViewHeight

class SettingsFragment : Fragment() {

    private lateinit var settingsViewModel: SettingsViewModel
    private var _binding: FragmentSettingsBinding? = null

    // This property is only valid between onCreateView and
    // onDestroyView.
    private val binding get() = _binding!!

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        settingsViewModel =
            ViewModelProvider(this).get(SettingsViewModel::class.java)

        _binding = FragmentSettingsBinding.inflate(inflater, container, false)
        val root: View = binding.root

        val textView: TextView = binding.textSettings
        settingsViewModel.text.observe(viewLifecycleOwner, {
            textView.text = it
        })
        textView.setOnClickListener {
//            startActivity(FlutterActivity.createDefaultIntent(requireActivity()))
            WebViewActivity.openActivity(context = requireContext(), url = "https://www.google.com")
        }

        binding.spacer.setStatusViewHeight()

        val currentMode = readMode()

        val rgThemeMode = binding.radioGroupTheme
        when (currentMode) {
            AppCompatDelegate.MODE_NIGHT_NO -> {
                rgThemeMode.check(R.id.radio_light)
            }
            AppCompatDelegate.MODE_NIGHT_YES -> {
                rgThemeMode.check(R.id.radio_dark)
            }
            else -> {
                rgThemeMode.check(R.id.radio_system)
            }
        }
        binding.radioLight.setOnClickListener { view -> onRadioButtonClicked(view) }
        binding.radioDark.setOnClickListener { view -> onRadioButtonClicked(view) }
        binding.radioSystem.setOnClickListener { view -> onRadioButtonClicked(view) }

        val swRealtime = binding.switchRealtime
        swRealtime.setOnCheckedChangeListener { _, isChecked ->
            App.isRealtimeQuot = isChecked
        }
        swRealtime.isChecked = App.isRealtimeQuot

        return root
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }

    private fun onRadioButtonClicked(view: View) {
        if (view is RadioButton) {
            // Is the button now checked?
            val checked = view.isChecked

            var mode: Int = AppCompatDelegate.MODE_NIGHT_FOLLOW_SYSTEM
            // Check which radio button was clicked
            when (view.id) {
                R.id.radio_light ->
                    if (checked) {
                        mode = AppCompatDelegate.MODE_NIGHT_NO
                    }
                R.id.radio_dark ->
                    if (checked) {
                        mode = AppCompatDelegate.MODE_NIGHT_YES
                    }
                else ->
                    if (checked) {
                        mode = AppCompatDelegate.MODE_NIGHT_FOLLOW_SYSTEM
                    }
            }//when
            MainActivity.openSettings(view.context, mode)
        }
    }

    private fun readMode(): Int {
        val sharedPref = requireActivity().getPreferences(Context.MODE_PRIVATE)
        val defaultValue = AppCompatDelegate.MODE_NIGHT_FOLLOW_SYSTEM
        return sharedPref.getInt("ThemeMode", defaultValue)
    }
}