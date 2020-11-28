package com.example.core.connectivity

import android.content.Context
import androidx.lifecycle.MutableLiveData
import javax.inject.Inject

class ConnectivityLiveData @Inject constructor(context: Context): MutableLiveData<ConnectivityState>() {

    private val connectionMonitor = ConnectivityMonitor.getInstance(context.applicationContext)

    override fun onActive() {
        super.onActive()
        connectionMonitor.startListening(::setConnected)
    }

    override fun onInactive() {
        super.onInactive()
        connectionMonitor.stopListening()
    }

    private fun setConnected(isConnected: Boolean) =
        postValue(if (isConnected) ConnectivityState.Connected else ConnectivityState.Disconnected)
}