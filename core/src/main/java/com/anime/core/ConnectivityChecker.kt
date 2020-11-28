package com.anime.core

import android.net.ConnectivityManager
import javax.inject.Inject

class ConnectivityChecker @Inject constructor(
    private val connectivityManager: ConnectivityManager): INetworkCheck {

    override val isConnected: Boolean
        get() = connectivityManager.activeNetworkInfo?.isConnected ?: false

}
