package com.example.topanimesrepos.view

import androidx.recyclerview.widget.GridLayoutManager

internal class GridPositionCalculator(var itemCount: Int) : GridLayoutManager.SpanSizeLookup() {

    companion object {

        private val doubleItems: IntRange = (1..10)
        const val fullSpanSize = 6
        private const val doubleSpanCount = 2
        private const val doubleSpanSize: Int = fullSpanSize / doubleSpanCount
    }

    override fun getSpanSize(position: Int): Int =
        when (position) {
            0 -> fullSpanSize
            else -> doubleSpanSize
        }

    fun getViewSize(position: Int): ViewSize =
        when (position) {
            0 -> ViewSize.FULL
            in doubleItems -> ViewSize.DOUBLE
            else -> ViewSize.TRIPLE
        }

    fun isEndItem(position: Int): Boolean =
        when (position) {
            0 -> true
            else -> (position - doubleItems.start).rem(doubleSpanCount) != 0
        }

    fun isInFinalBank(position: Int): Boolean =
        position >= itemCount - doubleSpanCount
}