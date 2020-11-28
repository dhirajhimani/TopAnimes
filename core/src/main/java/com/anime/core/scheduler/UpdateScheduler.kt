package com.anime.core.scheduler

interface UpdateScheduler<T> {
    fun scheduleUpdate(items: List<T>)
}