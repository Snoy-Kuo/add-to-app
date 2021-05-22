package com.snoy.apptoapp.android.ui.info

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProvider
import com.snoy.apptoapp.android.databinding.FragmentInfoBinding

class InfoFragment : Fragment() {

    companion object {
        fun newInstance(subIndex: Int): InfoFragment {
            val frg = InfoFragment()
            frg.arguments = Bundle().apply { putInt("subIndex", subIndex) }
            return frg
        }
    }

    private lateinit var viewModel: InfoViewModel
    private var _binding: FragmentInfoBinding? = null
    private var subIndex = 0

    // This property is only valid between onCreateView and
    // onDestroyView.
    private val binding get() = _binding!!

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _binding = FragmentInfoBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        viewModel = ViewModelProvider(this).get(InfoViewModel::class.java)

        val textView: TextView = binding.textInfo
        viewModel.text.observe(viewLifecycleOwner, {
            textView.text = it
        })

        switchSubIndex(arguments?.getInt("subIndex") ?: subIndex)
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }

    fun switchSubIndex(subIndex: Int) {
        this.subIndex = subIndex
        if (::viewModel.isInitialized) {
            viewModel.setText(this.subIndex)
        }
    }
}