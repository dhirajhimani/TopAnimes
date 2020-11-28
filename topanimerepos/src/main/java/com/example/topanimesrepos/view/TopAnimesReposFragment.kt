package com.example.topanimesrepos.view

import android.content.res.Configuration
import android.os.Bundle
import android.view.*
import android.widget.Button
import android.widget.TextView
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout
import com.example.core.connectivity.ConnectivityState
import com.example.topanimesrepos.R
import com.example.topanimesrepos.entity.Anime
import com.google.android.material.snackbar.Snackbar
import dagger.android.support.DaggerFragment
import javax.inject.Inject

class TopAnimesReposFragment : DaggerFragment() {

    @Inject
    lateinit var viewModelFactory: ViewModelProvider.Factory

    private lateinit var topAnimesReposViewModel: TopAnimesReposViewModel
    private lateinit var topAnimesReposAdapter: TopAnimesReposAdapter

    private lateinit var githubReposRecyclerView: RecyclerView
    private lateinit var githubReposSwipeContainer: SwipeRefreshLayout
    private lateinit var retryButton: Button
    private lateinit var noNetworkBanner: View
    private lateinit var whatWentWrong: TextView

    private var isButtonEnable: Boolean = true

    private val calculator = GridPositionCalculator(0)

    @RecyclerView.Orientation
    private var orientation = RecyclerView.VERTICAL

    private var itemSpacing: Int = 0
    private val spanCount: Int = GridPositionCalculator.fullSpanSize

    private val connectivitySnackbar: Snackbar by lazy {
        Snackbar.make(githubReposRecyclerView, "No Network", Snackbar.LENGTH_SHORT)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        topAnimesReposViewModel = ViewModelProvider(this, viewModelFactory)
            .get(TopAnimesReposViewModel::class.java)
        topAnimesReposAdapter = TopAnimesReposAdapter()
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? =
        inflater.inflate(R.layout.fragment_anime_repos, container, false).also { view ->
            githubReposRecyclerView = view.findViewById(R.id.repositories)
            githubReposSwipeContainer = view.findViewById(R.id.swipeContainer)
            retryButton = view.findViewById(R.id.retry)
            noNetworkBanner = view.findViewById(R.id.no_network_banner)
            whatWentWrong = view.findViewById(R.id.what_went_wrong)
            orientation = if (resources.configuration.orientation == Configuration.ORIENTATION_LANDSCAPE)
                RecyclerView.HORIZONTAL
            else
                RecyclerView.VERTICAL
            githubReposRecyclerView.apply {
                adapter = topAnimesReposAdapter
                layoutManager = GridLayoutManager(context, spanCount, orientation, false).apply {
                    spanSizeLookup = calculator
                }
                addItemDecoration(TopAnimesItemDecoration(orientation, itemSpacing, calculator))
            }
            retryButton.setOnClickListener {
                topAnimesReposViewModel.load()
            }
            githubReposSwipeContainer.setOnRefreshListener {
                topAnimesReposViewModel.load()
            }
            githubReposRecyclerView.addItemDecoration(
                DividerItemDecoration(
                    context,
                    LinearLayoutManager.VERTICAL
                )
            )
            setHasOptionsMenu(true)
        }

    override fun onResume() {
        super.onResume()
        topAnimesReposViewModel.topAnimesReposViewState.observe(
            viewLifecycleOwner,
            Observer { newState -> viewStateChanged(newState) })
        topAnimesReposViewModel.connectivityLiveData.observe(
            viewLifecycleOwner,
            Observer { connected ->
                connectivityChanged(connected)
            }
        )

        topAnimesReposViewModel.buttonState.observe(
            viewLifecycleOwner,
            Observer { enabled ->
                isButtonEnable = enabled
//                setMenuVisibility(enabled)
            })
    }

    private fun connectivityChanged(connected: ConnectivityState?) {
        if (connected == ConnectivityState.Connected) {
            connectivitySnackbar.dismiss()
        } else {
            connectivitySnackbar.show()
        }
    }

    private fun viewStateChanged(topAnimesReposViewState: TopAnimesReposViewState) {
        when (topAnimesReposViewState) {
            is TopAnimesReposViewState.InProgress -> setLoading()
            is TopAnimesReposViewState.ShowError -> setError(topAnimesReposViewState.message)
            is TopAnimesReposViewState.ShowRepositories -> updateRepositories(topAnimesReposViewState.animes)
        }
    }

    private fun setLoading() {
        githubReposSwipeContainer.isRefreshing = true
        noNetworkBanner.visibility = View.GONE
        whatWentWrong.visibility = View.GONE
        retryButton.visibility = View.GONE
        githubReposRecyclerView.visibility = View.GONE
    }

    private fun setError(message: String?) {
        githubReposSwipeContainer.isRefreshing = false
        noNetworkBanner.visibility = View.VISIBLE
        whatWentWrong.text = message
        retryButton.visibility = View.VISIBLE
        githubReposRecyclerView.visibility = View.GONE
    }

    private fun updateRepositories(animes: List<Anime>) {
        githubReposSwipeContainer.isRefreshing = false
        noNetworkBanner.visibility = View.GONE
        whatWentWrong.visibility = View.GONE
        retryButton.visibility = View.GONE
        githubReposRecyclerView.visibility = View.VISIBLE
        topAnimesReposAdapter.replace(animes)
    }

    override fun onCreateOptionsMenu(menu: Menu, inflater: MenuInflater) {
        super.onCreateOptionsMenu(menu, inflater)
        inflater.inflate(R.menu.overflow_menu, menu)
    }

    override fun onPrepareOptionsMenu(menu: Menu) {
        val item1 = menu.findItem(R.id.sort_by_rank)
        item1.isEnabled = isButtonEnable
        super.onPrepareOptionsMenu(menu)
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        when (item.itemId) {
            R.id.sort_by_members -> {
//                githubReposAdapter.apply {
//                    replace(this.getItems().sortedBy { it.stars })
//                }
                topAnimesReposViewModel.sortByMemebers()
                return true
            }
            R.id.sort_by_rank -> {
//                githubReposAdapter.apply {
//                    replace(this.getItems().sortedBy { it.name })
//                }
                topAnimesReposViewModel.sortByRank()
                return true
            }
        }
        return false
    }
}
