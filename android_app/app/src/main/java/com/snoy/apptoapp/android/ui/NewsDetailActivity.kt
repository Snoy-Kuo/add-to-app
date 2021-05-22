package com.snoy.apptoapp.android.ui

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import com.snoy.apptoapp.android.databinding.ActivityNewsDetailBinding

class NewsDetailActivity : AppCompatActivity() {

    companion object {

        fun openActivity(context: Context, id: Int, title: String) {
            val intent = Intent(context, NewsDetailActivity::class.java).apply {
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

        val id: Int = intent.getIntExtra("id", -1)
        content.text = "This is NewsDetailActivity\nid=$id"
        val titleText: String = intent.getStringExtra("title") ?: ""
        title.text = titleText
    }
}