package com.snoy.apptoapp.android.ui

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import com.snoy.apptoapp.android.R
import com.snoy.apptoapp.android.databinding.ActivityNewsDetailBinding

class QuotDetailActivity : AppCompatActivity() {

    companion object {

        fun openActivity(context: Context, id: String, title: String) {
            val intent = Intent(context, QuotDetailActivity::class.java).apply {
                putExtra("id", id)
                putExtra("title", title)
            }
            context.startActivity(intent)
        }
    }

    private lateinit var binding: ActivityNewsDetailBinding
    private lateinit var content: TextView
    private lateinit var title: TextView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        binding = ActivityNewsDetailBinding.inflate(layoutInflater)
        setContentView(binding.root)

        val toolbar = binding.toolBar
        toolbar.setNavigationOnClickListener {
            finish()
        }

        content = binding.content
        title = binding.title

        val id: String = intent.getStringExtra("id") ?: ""
        content.text = getString(R.string.this_is_quot_detail_activity, id)
        val titleText: String = intent.getStringExtra("title") ?: ""
        title.text = titleText
    }
}