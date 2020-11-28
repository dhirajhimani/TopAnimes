package com.example.core.di

import androidx.lifecycle.ViewModelProvider
import com.example.core.view.ViewModelFactory
import dagger.Binds
import dagger.Module
import javax.inject.Singleton

@Module
@Suppress("unused")
abstract class BaseViewModule {

    @Singleton
    @Binds
    abstract fun bindViewModelFactory(factory: ViewModelFactory) : ViewModelProvider.Factory
}
