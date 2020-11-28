package com.example.core.providers

interface DataPersister<T> : DataProvider<T> {
    fun persistData(data: T)
}
