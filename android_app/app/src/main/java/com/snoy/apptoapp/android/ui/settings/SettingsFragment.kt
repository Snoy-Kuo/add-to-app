package com.snoy.apptoapp.android.ui.settings

import android.content.Context
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.*
import androidx.appcompat.app.AppCompatDelegate
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProvider
import com.snoy.apptoapp.android.App
import com.snoy.apptoapp.android.R
import com.snoy.apptoapp.android.databinding.FragmentSettingsBinding
import com.snoy.apptoapp.android.ui.MainActivity
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
        settingsViewModel.textRes.observe(viewLifecycleOwner, {
            textView.setText(it)
        })

        binding.spacer.setStatusViewHeight()

        initRadioGroupTheme()
        initSwitchRealtime()
        initSpinnerLanguage()
        initSwitchRookieUser()

        return root
    }

    private fun initRadioGroupTheme() {
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
    }

    private fun initSwitchRealtime() {
        val swRealtime = binding.switchRealtime
        swRealtime.setOnCheckedChangeListener { _, isChecked ->
            App.isRealtimeQuot = isChecked
        }
        swRealtime.isChecked = App.isRealtimeQuot
    }

    private fun initSpinnerLanguage() {
        val selectIndex = when (readLanguage()) {
            "English" -> 0
            "简体中文" -> 1
            "繁體中文" -> 2
            else -> 3
        }

        val spinner: Spinner = binding.spinnerLanguage
        // Create an ArrayAdapter using the string array and a default spinner layout
        ArrayAdapter.createFromResource(
            requireContext(),
            R.array.language_array,
            android.R.layout.simple_spinner_item
        ).also { adapter ->
            // Specify the layout to use when the list of choices appears
            adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
            // Apply the adapter to the spinner
            spinner.adapter = adapter
        }
        spinner.setSelection(selectIndex)

        spinner.onItemSelectedListener = object : AdapterView.OnItemSelectedListener {
            override fun onItemSelected(
                parent: AdapterView<*>?,
                view: View?,
                position: Int,
                id: Long
            ) {

                val selectedLanguage = when (position) {
                    0 -> "English"
                    1 -> "简体中文"
                    2 -> "繁體中文"
                    else -> "System"
                }

                MainActivity.openSettings(requireContext(), readMode(), selectedLanguage)
            }

            override fun onNothingSelected(parent: AdapterView<*>?) {
                //do nothing
            }
        }
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
            MainActivity.openSettings(view.context, mode, readLanguage())
        }
    }

    private fun readMode(): Int {
        val sharedPref = requireActivity().getPreferences(Context.MODE_PRIVATE)
        val defaultValue = AppCompatDelegate.MODE_NIGHT_FOLLOW_SYSTEM
        return sharedPref.getInt("ThemeMode", defaultValue)
    }

    private fun readLanguage(): String {
        val sharedPref = requireActivity().getPreferences(Context.MODE_PRIVATE)
        val defaultValue = "System"
        return sharedPref.getString("Language", defaultValue) ?: defaultValue
    }

    private fun initSwitchRookieUser() {
        val swRookie = binding.switchRookie
        swRookie.setOnCheckedChangeListener { _, isChecked ->
            App.isRookie = isChecked
        }
        swRookie.isChecked = App.isRookie
    }
}