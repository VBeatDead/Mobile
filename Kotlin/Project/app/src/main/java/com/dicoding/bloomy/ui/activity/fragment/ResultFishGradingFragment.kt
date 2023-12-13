package com.dicoding.bloomy.ui.activity.fragment

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import com.dicoding.bloomy.R
import androidx.fragment.app.FragmentTransaction
import com.google.android.material.button.MaterialButton

class ResultFishGradingFragment : Fragment() {

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val view = inflater.inflate(R.layout.result_fish_grading, container, false)
        val moreButton: MaterialButton = view.findViewById(R.id.morebuttongrading)

        moreButton.setOnClickListener {
            redirectToGradingFragment()
        }

        return view
    }

    private fun redirectToGradingFragment() {
        val gradingFragment = GradingFragment()
        val fragmentManager = requireActivity().supportFragmentManager
        val transaction: FragmentTransaction = fragmentManager.beginTransaction()

        transaction.replace(R.id.container, gradingFragment)
        transaction.addToBackStack(null)
        transaction.commit()
    }
}
