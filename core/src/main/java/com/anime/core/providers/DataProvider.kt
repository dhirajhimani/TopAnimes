package com.anime.core.providers

interface DataProvider<T> {

    fun requestData(callback: (item: T) -> Unit)

    fun requestData(): T = throw NotImplementedError()
}
