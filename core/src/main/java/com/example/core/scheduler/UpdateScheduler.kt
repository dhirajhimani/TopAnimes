package com.example.core.scheduler

interface UpdateScheduler<T> {
    fun scheduleUpdate(items: List<T>)
}