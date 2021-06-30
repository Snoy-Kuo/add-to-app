package com.snoy.apptoapp.android.ui

import android.content.Context
import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.app.AppCompatDelegate
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentTransaction
import com.google.android.material.bottomnavigation.BottomNavigationView
import com.snoy.apptoapp.android.R
import com.snoy.apptoapp.android.databinding.ActivityMainBinding
import com.snoy.apptoapp.android.ui.home.HomeFragment
import com.snoy.apptoapp.android.ui.info.InfoFragment
import com.snoy.apptoapp.android.ui.settings.SettingsFragment
import com.snoy.apptoapp.android.util.hideSystemUI
import java.util.*

class MainActivity : AppCompatActivity() {

    companion object {
        fun openTab(context: Context, index: Int, subIndex: Int = 0) {
            val intent = Intent(context, MainActivity::class.java).apply {
                putExtra("index", index)
                putExtra("subIndex", subIndex)
            }
            context.startActivity(intent)
        }

        fun openSettings(context: Context, themeMode: Int, language: String) {
            val intent = Intent(context, MainActivity::class.java).apply {
                putExtra("index", 2)
                putExtra("subIndex", 0)
                putExtra("themeMode", themeMode)
                putExtra("language", language)
            }
            context.startActivity(intent)
        }

        private val FRG_TAGS = listOf("TAG_HOME_FRG", "TAG_INFO_FRG", "TAG_SETTINGS_FRG")
    }

    private lateinit var binding: ActivityMainBinding
    private lateinit var fragments: ArrayList<Fragment>
    private var flutterFragment: HomeFragment? = null
    private var lastIndex: Int = 0
    private var index: Int = 0
    private var subIndex: Int = 0
    private var themeMode: Int = AppCompatDelegate.MODE_NIGHT_FOLLOW_SYSTEM
    private var language: String = "System"

    private val mOnNavigationItemSelectedListener =
        BottomNavigationView.OnNavigationItemSelectedListener { item ->
            when (item.itemId) {
                R.id.navigation_home -> {
                    if (lastIndex != 0) {
                        switchFragment(lastIndex, 0)
                        lastIndex = 0
                        index = 0
                        subIndex = 0

                        return@OnNavigationItemSelectedListener true
                    }
                }
                R.id.navigation_info -> {
                    if (lastIndex != 1) {
                        switchFragment(lastIndex, 1, subIndex)
                        lastIndex = 1
                        index = 1
                        return@OnNavigationItemSelectedListener true
                    }
                }
                R.id.navigation_app_settings -> {
                    if (lastIndex != 2) {
                        switchFragment(lastIndex, 2)
                        lastIndex = 2
                        index = 2
                        subIndex = 0
                        return@OnNavigationItemSelectedListener true
                    }
                }
            }
            return@OnNavigationItemSelectedListener false
        }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        val navView: BottomNavigationView = binding.navView

        navView.setOnNavigationItemSelectedListener(mOnNavigationItemSelectedListener)
        initFragments()

        hideSystemUI()

        processInitData()
    }

    override fun onNewIntent(intent: Intent?) {
        super.onNewIntent(intent)
        setIntent(intent)//must store the new intent unless getIntent() will return the old one
        processExtraData()
    }

    private fun readMode(): Int {
        val sharedPref = getPreferences(Context.MODE_PRIVATE)
        val defaultValue = AppCompatDelegate.MODE_NIGHT_FOLLOW_SYSTEM
        return sharedPref.getInt("ThemeMode", defaultValue)
    }

    private fun saveMode(mode: Int) {
        val sharedPref = getPreferences(Context.MODE_PRIVATE) ?: return
        with(sharedPref.edit()) {
            putInt("ThemeMode", mode)
            apply()
        }
    }

    private fun readLanguage(): String {
        val defaultValue = "System"
        val sharedPref = getPreferences(Context.MODE_PRIVATE)
        return sharedPref.getString("Language", defaultValue) ?: defaultValue
    }

    private fun saveLanguage(language: String) {
        val sharedPref = getPreferences(Context.MODE_PRIVATE) ?: return
        with(sharedPref.edit()) {
            putString("Language", language)
            apply()
        }
    }

    private fun processExtraData() {
        //use the data received here
        index = intent.getIntExtra("index", 0)
        subIndex = intent.getIntExtra("subIndex", 0)
        themeMode = intent.getIntExtra("themeMode", readMode())
        language = intent.getStringExtra("language") ?: "System"

        if (index == 2) {
            val currentMode = readMode()
            val currentLanguage = readLanguage()
            if (currentMode != themeMode || currentLanguage != language) {
                if (currentLanguage != language) {
                    saveLanguage(language)
                    setAppLocale(this, language)
                }
                finish()
                startActivity(intent.apply { addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION) })
                return
            }
        }

        val navView: BottomNavigationView = binding.navView

        navView.selectedItemId = when (index) {
            0 -> R.id.navigation_home
            1 -> R.id.navigation_info
            2 -> R.id.navigation_app_settings
            else -> R.id.navigation_home
        }
    }

    private fun processInitData() {
        //use the data received here
        index = intent.getIntExtra("index", 0)
        subIndex = intent.getIntExtra("subIndex", 0)
        themeMode = intent.getIntExtra("themeMode", readMode())
        language = intent.getStringExtra("language") ?: "System"

        val currentMode = readMode()
        if (currentMode != themeMode) {
            saveMode(themeMode)
            AppCompatDelegate.setDefaultNightMode(themeMode)
        }

        val currentLanguage = readLanguage()
        if (currentLanguage != language) {
            saveLanguage(language)
            setAppLocale(this, language)
        }

        val navView: BottomNavigationView = binding.navView
        navView.selectedItemId = when (index) {
            0 -> R.id.navigation_home
            1 -> R.id.navigation_info
            2 -> R.id.navigation_app_settings
            else -> R.id.navigation_home
        }
    }

    private fun setAppLocale(context: Context, language: String) {

        val locale = when (language) {
            "English" -> Locale.US
            "简体中文" -> Locale.CHINA
            "繁體中文" -> Locale.TAIWAN
            else -> {
                val currentSysLocale: Locale = Locale.getDefault()
                if (currentSysLocale.language == "zh") {
                    if (currentSysLocale.country == "HK" || currentSysLocale.country == "TW") {
                        Locale.TAIWAN
                    } else {
                        Locale.CHINA
                    }
                } else {
                    Locale.US
                }
            }
        }
        Locale.setDefault(locale)
        val config = context.resources.configuration
        config.setLocale(locale)
        context.createConfigurationContext(config)
        context.resources.updateConfiguration(config, context.resources.displayMetrics)
    }

    /**
     * 切换Fragment
     *
     * @param lastIndex 上个显示Fragment的索引
     * @param index     需要显示的Fragment的索引
     */
    private fun switchFragment(lastIndex: Int, index: Int, subIndex: Int = 0) {
        val transaction: FragmentTransaction = supportFragmentManager.beginTransaction()
        val hideFrg = getFragCheckTag(lastIndex)
        transaction.hide(hideFrg)

        val showFrg = getFragCheckTag(index)
        if (!showFrg.isAdded) {
            transaction.add(R.id.fragment_container, showFrg, FRG_TAGS[index])
        }
        if (index == 1) { //info
            (showFrg as InfoFragment).switchSubIndex(subIndex)
        }

        transaction.show(showFrg).commit()
    }

    private fun initFragments() {
        fragments = arrayListOf(HomeFragment(), InfoFragment.newInstance(0), SettingsFragment())
        lastIndex = 0
        val initFrg = getFragCheckTag(0)
        flutterFragment = initFrg as HomeFragment
        val transaction = supportFragmentManager.beginTransaction()
        if (!initFrg.isAdded) {
            transaction.add(R.id.fragment_container, initFrg, FRG_TAGS[0])
        }
        transaction.show(initFrg).commit()
    }

    private fun getFragCheckTag(index: Int): Fragment {
        var targetFrg = supportFragmentManager
            .findFragmentByTag(FRG_TAGS[index])

        if (targetFrg == null) {
            targetFrg = fragments[index]
        }
        return targetFrg
    }

    override fun onBackPressed() {
        finish()
    }

    override fun onPause() {
        super.onPause()
        flutterFragment?.onPause()

        with(intent) {
            putExtra("index", index)
            putExtra("subIndex", subIndex)
            putExtra("themeMode", themeMode)
        }
    }

    override fun onResume() {
        super.onResume()
        if (lastIndex == 0) {
            flutterFragment?.onResume()
        }
    }
}