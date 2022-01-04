import 'package:core/domain/entities/tv_shows/tv_show.dart';
import 'package:core/presentation/bloc/result_state.dart';
import 'package:core/presentation/bloc/tv_shows/popular_tv_shows_cubit.dart';
import 'package:core/presentation/widgets/tv_show_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularTvShowsPage extends StatefulWidget {
  const PopularTvShowsPage({Key? key}) : super(key: key);

  @override
  _PopularTvShowsPageState createState() => _PopularTvShowsPageState();
}

class _PopularTvShowsPageState extends State<PopularTvShowsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<PopularTvShowsCubit>().fetchPopularTvShows(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Tv Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvShowsCubit, ResultState<List<TvShow>>>(
          builder: (context, state) {
            if (state.data.isEmpty) {
              return const Center(
                child: Text('No Data'),
              );
            }

            if (state.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state.data.isNotEmpty) {
              return ListView.builder(
                itemCount: state.data.length,
                itemBuilder: (context, index) {
                  final tvShow = state.data[index];
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
