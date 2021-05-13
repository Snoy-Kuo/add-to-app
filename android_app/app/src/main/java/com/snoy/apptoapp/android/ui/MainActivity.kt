package com.snoy.apptoapp.android.ui

import android.content.Intent
import android.os.Bundle
import androidx.annotation.NonNull
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentTransaction
import com.google.android.material.bottomnavigation.BottomNavigationView
import com.snoy.apptoapp.android.R
import com.snoy.apptoapp.android.databinding.ActivityMainBinding
import com.snoy.apptoapp.android.ui.settings.SettingsFragment
import io.flutter.embedding.android.FlutterFragment

class MainActivity : AppCompatActivity() {


    private lateinit var binding: ActivityMainBinding
    private var fragmentFlutter: FlutterFragment? = null
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
                    if (lastShowFragment != 1) {
                        switchFragment(lastShowFragment, 1)
                        lastShowFragment = 1
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
        transaction.show(fragments[index]).commitAllowingStateLoss()
    }

    private fun initFragments() {
        fragmentFlutter = FlutterFragment.createDefault()
        val initFrg: Fragment = fragmentFlutter!!
        fragment2 = SettingsFragment()
        fragments = arrayListOf(initFrg, fragment2)
        lastShowFragment = 0
        supportFragmentManager
            .beginTransaction()
            .add(R.id.fragment_container, initFrg)
            .show(initFrg)
            .commit()
    }

    override fun onPostResume() {
        super.onPostResume()
        fragmentFlutter?.onPostResume()
    }

    override fun onNewIntent(@NonNull intent: Intent) {
        super.onNewIntent(intent)
        fragmentFlutter?.onNewIntent(intent)
    }

    override fun onBackPressed() {
        fragmentFlutter?.onBackPressed()
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<String?>,
        grantResults: IntArray
    ) {
        fragmentFlutter?.onRequestPermissionsResult(
            requestCode,
            permissions,
            grantResults
        )
    }

    override fun onUserLeaveHint() {
        fragmentFlutter?.onUserLeaveHint()
    }

    override fun onTrimMemory(level: Int) {
        super.onTrimMemory(level)
        fragmentFlutter?.onTrimMemory(level)
    }
}