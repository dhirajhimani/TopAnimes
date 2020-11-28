package com.example.core

import android.net.ConnectivityManager
import com.example.core.INetworkCheck
import javax.inject.Inject

class ConnectivityChecker @Inject constructor(
    private val connectivityManager: ConnectivityManager): INetworkCheck {

    override val isConnected: Boolean
        get() = connectivityManager.activeNetworkInfo?.isConnected ?: false

}
