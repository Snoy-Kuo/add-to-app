package com.snoy.apptoapp.android.ui

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentTransaction
import com.google.android.material.bottomnavigation.BottomNavigationView
import com.snoy.apptoapp.android.R
import com.snoy.apptoapp.android.databinding.ActivityMainBinding
import com.snoy.apptoapp.android.ui.home.HomeFragment
import com.snoy.apptoapp.android.ui.settings.SettingsFragment
import com.snoy.apptoapp.android.util.hideSystemUI

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding

    private var fragmentFlutter: HomeFragment? = null
    private lateinit var fragment2: SettingsFragment
    private lateinit var fragments: ArrayList<Fragment>
    private var lastShowFragment: Int = 0

    private val mOnNavigationItemSelectedListener =
        BottomNavigationView.OnNavigationItemSelectedListener { item ->
            when (item.itemId) {
                R.id.navigation_home -> {
                    if (lastShowFragment != 0) {
                        switchFragment(lastShowFragment, 0)
                        lastShowFragment = 0
                        return@OnNavigationItemSelectedListener true
                    }
                }
                R.id.navigation_settings -> {
                    if (lastShowFragment != 2) {
                        switchFragment(lastShowFragment, 2)
                        lastShowFragment = 2
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

    /**
     * 切换Fragment
     *
     * @param lastIndex 上个显示Fragment的索引
     * @param index     需要显示的Fragment的索引
     */
    private fun switchFragment(lastIndex: Int, index: Int) {
        val transaction: FragmentTransaction = supportFragmentManager.beginTransaction()
        transaction.hide(fragments[lastIndex])
        if (!fragments[index].isAdded) {
            transaction.add(R.id.fragment_container, fragments[index])
        }
        transaction.show(fragments[index]).commitNowAllowingStateLoss() //commitAllowingStateLoss()
    }

    private fun initFragments() {
        fragmentFlutter = HomeFragment()
        fragment2 = SettingsFragment()

        val initFrg: Fragment = fragmentFlutter!!

        fragments = arrayListOf(initFrg, fragmentFlutter!!, fragment2)
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