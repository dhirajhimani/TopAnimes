package com.example.topanimes

import android.os.Bundle
import com.example.topanimesrepos.view.TopAnimesReposFragment
import dagger.android.support.DaggerAppCompatActivity

class TopAnimesActivity : DaggerAppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContentView(R.layout.main_activity)
        if (savedInstanceState == null) {
            supportFragmentManager.beginTransaction()
                .replace(R.id.container, TopAnimesReposFragment())
                .commitNow()
        }
    }
}