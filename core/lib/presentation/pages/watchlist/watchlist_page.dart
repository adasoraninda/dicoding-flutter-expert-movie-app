import 'package:core/core.dart';
import 'package:core/presentation/provider/watchlist/watchlist_notifier.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:core/presentation/widgets/tv_show_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({Key? key}) : super(key: key);

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<WatchlistNotifier>(context, listen: false)
          ..fetchWatchlistMovies()
          ..fetchWatchlistTvShows());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<WatchlistNotifier>(context, listen: false)
      ..fetchWatchlistMovies()
      ..fetchWatchlistTvShows();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Watchlist'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Movie'),
              Tab(text: 'Tv Show'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildWatchlistMoviePage(),
            _buildWatchlistTvShowPage(),
          ],
        ),
      ),
    );
  }

  Widget _buildWatchlistMoviePage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<WatchlistNotifier>(
        builder: (context, data, child) {
          if (data.watchlistMovieState == RequestState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (data.watchlistMovieState == RequestState.loaded) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final movie = data.watchlistMovies[index];
                return MovieCard(movie);
              },
              itemCount: data.watchlistMovies.length,
            );
          } else {
            return Center(
              key: const Key('error_message'),
              child: Text(data.message),
            );
          }
        },
      ),
    );
  }

  Widget _buildWatchlistTvShowPage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<WatchlistNotifier>(
        builder: (context, data, child) {
          if (data.watchlistTvShowState == RequestState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (data.watchlistTvShowState == RequestState.loaded) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tvShow = data.watchlistTvShows[index];
                return TvShowCard(tvShow);
              },
              itemCount: data.watchlistTvShows.length,
            );
          } else {
            return Center(
              key: const Key('error_message'),
              child: Text(data.message),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
