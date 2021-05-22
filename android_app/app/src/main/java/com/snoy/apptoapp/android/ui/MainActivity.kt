package com.snoy.apptoapp.android.ui

import android.content.Context
import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentTransaction
import com.google.android.material.bottomnavigation.BottomNavigationView
import com.snoy.apptoapp.android.R
import com.snoy.apptoapp.android.databinding.ActivityMainBinding
import com.snoy.apptoapp.android.ui.home.HomeFragment
import com.snoy.apptoapp.android.ui.info.InfoFragment
import com.snoy.apptoapp.android.ui.settings.SettingsFragment
import com.snoy.apptoapp.android.util.hideSystemUI

class MainActivity : AppCompatActivity() {

    companion object {
        fun openTab(context: Context, index: Int, subIndex: Int) {
            val intent = Intent(context, MainActivity::class.java).apply {
                putExtra("index", index)
                putExtra("subIndex", subIndex)
            }
            context.startActivity(intent)
        }
    }

    private lateinit var binding: ActivityMainBinding

    private var homeFragment: HomeFragment? = null
    private lateinit var infoFragment: InfoFragment
    private lateinit var settingsFragment: SettingsFragment
    private lateinit var fragments: ArrayList<Fragment>
    private var lastShowFragment: Int = 0
    private var index: Int = 0
    private var subIndex: Int = 0

    private val mOnNavigationItemSelectedListener =
        BottomNavigationView.OnNavigationItemSelectedListener { item ->
            when (item.itemId) {
                R.id.navigation_home -> {
                    if (lastShowFragment != 0) {
                        switchFragment(lastShowFragment, 0)
                        lastShowFragment = 0
                        subIndex = 0
                        return@OnNavigationItemSelectedListener true
                    }
                }
                R.id.navigation_info -> {
                    if (lastShowFragment != 1) {
                        switchFragment(lastShowFragment, 1, subIndex)
                        lastShowFragment = 1
                        return@OnNavigationItemSelectedListener true
                    }
                }
                R.id.navigation_settings -> {
                    if (lastShowFragment != 2) {
                        switchFragment(lastShowFragment, 2)
                        lastShowFragment = 2
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
    }

    override fun onNewIntent(intent: Intent?) {
        super.onNewIntent(intent)
        setIntent(intent)//must store the new intent unless getIntent() will return the old one
        processExtraData()
    }

    private fun processExtraData() {
        //use the data received here
        index = intent.getIntExtra("index", 0)
        subIndex = intent.getIntExtra("subIndex", 0)

        val navView: BottomNavigationView = binding.navView
        navView.selectedItemId = when (index) {
            0 -> R.id.navigation_home
            1 -> R.id.navigation_info
            else -> R.id.navigation_settings
        }
    }

    /**
     * 切换Fragment
     *
     * @param lastIndex 上个显示Fragment的索引
     * @param index     需要显示的Fragment的索引
     */
    private fun switchFragment(lastIndex: Int, index: Int, subIndex: Int = 0) {
        val transaction: FragmentTransaction = supportFragmentManager.beginTransaction()
        transaction.hide(fragments[lastIndex])
        if (!fragments[index].isAdded) {
            transaction.add(R.id.fragment_container, fragments[index])
        }

        if (index == 1) { //info
            (fragments[index] as InfoFragment).switchSubIndex(subIndex)
        }

        transaction.show(fragments[index]).commitAllowingStateLoss()
    }

    private fun initFragments() {
        homeFragment = HomeFragment()
        infoFragment = InfoFragment.newInstance(0)
        settingsFragment = SettingsFragment()

        val initFrg: Fragment = homeFragment!!

        fragments = arrayListOf(initFrg, infoFragment, settingsFragment)
        lastShowFragment = 0
        supportFragmentManager
            .beginTransaction()
            .add(R.id.fragment_container, initFrg)
            .show(initFrg)
            .commit()
    }

    override fun onBackPressed() {
        finish()
    }
}