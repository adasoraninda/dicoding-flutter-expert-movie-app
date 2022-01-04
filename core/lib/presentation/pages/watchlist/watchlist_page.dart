import 'package:core/core.dart';
import 'package:core/presentation/bloc/watchlist/watchlist_cubit.dart';
import 'package:core/presentation/bloc/watchlist_state.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:core/presentation/widgets/tv_show_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({Key? key}) : super(key: key);

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<WatchlistCubit>()
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
    context.read<WatchlistCubit>()
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
      child: BlocBuilder<WatchlistCubit, WatchlistState>(
        builder: (context, state) {
          if (state.movieData.isEmpty) {
            return const Center(
              child: Text('No Data'),
            );
          }

          if (state.movieLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.movieData.isNotEmpty) {
            return ListView.builder(
              itemCount: state.movieData.length,
              itemBuilder: (context, index) {
                final movie = state.movieData[index];
                return MovieCard(movie);
              },
            );
          }

          return Center(
            key: const Key('error_message'),
            child: Text(state.movieError ?? ''),
          );
        },
      ),
    );
  }

  Widget _buildWatchlistTvShowPage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistCubit, WatchlistState>(
        builder: (context, state) {
          if (state.tvShowData.isEmpty) {
            return const Center(
              child: Text('No Data'),
            );
          }

          if (state.tvShowLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.tvShowData.isNotEmpty) {
            return ListView.builder(
              itemCount: state.tvShowData.length,
              itemBuilder: (context, index) {
                final tvShow = state.tvShowData[index];
                return TvShowCard(tvShow);
              },
            );
          }

          return Center(
            key: const Key('error_message'),
            child: Text(state.tvShowError ?? ''),
          );
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
