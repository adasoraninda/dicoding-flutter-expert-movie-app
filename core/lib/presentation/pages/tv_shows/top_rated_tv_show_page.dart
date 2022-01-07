import 'package:core/domain/entities/tv_shows/tv_show.dart';
import 'package:core/presentation/bloc/result_state.dart';
import 'package:core/presentation/bloc/tv_shows/top_rated_tv_shows_cubit.dart';
import 'package:core/presentation/widgets/tv_show_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedTvShowsPage extends StatefulWidget {
  const TopRatedTvShowsPage({Key? key}) : super(key: key);

  @override
  _TopRatedTvShowsPageState createState() => _TopRatedTvShowsPageState();
}

class _TopRatedTvShowsPageState extends State<TopRatedTvShowsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<TopRatedTvShowsCubit>().fetchTopRatedTvShows(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Tv Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvShowsCubit, ResultState<List<TvShow>>>(
          builder: (context, state) {
            if (state.data?.isEmpty == true) {
              return const Center(
                key: Key('empty_message'),
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
      ),
    );
  }
}
