import 'package:core/core.dart';
import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/domain/entities/tv_shows/tv_show.dart';
import 'package:core/presentation/bloc/result_state.dart';
import 'package:core/presentation/bloc/watchlist/movie_watchlist_cubit.dart';
import 'package:core/presentation/bloc/watchlist/tv_show_watchlist_cubit.dart';
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
    Future.microtask(() {
      context.read<MovieWatchlistCubit>().fetchWatchlistMovies();
      context.read<TvShowWatchlistCubit>().fetchWatchlistTvShows();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<MovieWatchlistCubit>().fetchWatchlistMovies();
    context.read<TvShowWatchlistCubit>().fetchWatchlistTvShows();
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
      child: BlocBuilder<MovieWatchlistCubit, ResultState<List<Movie>>>(
        builder: (context, state) {
          if (state.data?.isEmpty == true) {
            return const Center(
              child: Text('No Data'),
            );
          }

          if (state.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.data?.isNotEmpty == true) {
            return ListView.builder(
              itemCount: state.data!.length,
              itemBuilder: (context, index) {
                final movie = state.data![index];
                return MovieCard(movie);
              },
            );
          }

          return Center(
            key: const Key('error_message'),
            child: Text(state.error ?? ''),
          );
        },
      ),
    );
  }

  Widget _buildWatchlistTvShowPage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<TvShowWatchlistCubit, ResultState<List<TvShow>>>(
        builder: (context, state) {
          if (state.data?.isEmpty == true) {
            return const Center(
              child: Text('No Data'),
            );
          }

          if (state.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.data?.isNotEmpty == true) {
            return ListView.builder(
              itemCount: state.data!.length,
              itemBuilder: (context, index) {
                final tvShow = state.data![index];
                return TvShowCard(tvShow);
              },
            );
          }

          return Center(
            key: const Key('error_message'),
            child: Text(state.error ?? ''),
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
