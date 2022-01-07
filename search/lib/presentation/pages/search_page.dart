import 'package:core/core.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:core/presentation/widgets/tv_show_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/presentation/bloc/search/search_bloc.dart';
import 'package:search/presentation/bloc/search/search_event.dart';
import 'package:search/presentation/bloc/search/search_state.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  child: TextField(
                    onChanged: (query) {
                      context.read<SearchBloc>().add(OnQueryChanged(query));
                    },
                    onSubmitted: (query) {
                      context.read<SearchBloc>().add(OnQuerySubmit(query));
                    },
                    decoration: const InputDecoration(
                      hintText: 'Search title',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.search,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: BlocBuilder<SearchBloc, SearchState>(
                      builder: (context, state) {
                    return IconButton(
                      icon: state.type == FilmType.movies
                          ? const Icon(Icons.movie)
                          : const Icon(Icons.tv),
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        _buildDialog(context);
                      },
                    );
                  }),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state.tvLoading || state.movLoading) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final filmType = state.type;
                if (filmType == FilmType.movies && state.movies.isNotEmpty) {
                  final movies = state.movies;

                  return Expanded(
                    child: ListView.builder(
                      itemCount: movies.length,
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        return MovieCard(movies[index]);
                      },
                    ),
                  );
                } else if (filmType == FilmType.tvShows &&
                    state.tvShows.isNotEmpty) {
                  final tvShows = state.tvShows;

                  return Expanded(
                    child: ListView.builder(
                      itemCount: tvShows.length,
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        return TvShowCard(tvShows[index]);
                      },
                    ),
                  );
                } else {
                  if (state.tvError != null || state.movError != null) {
                    return Expanded(
                      child: Center(
                        child: Text(state.movError ?? state.tvError ?? ''),
                      ),
                    );
                  }

                  return const Expanded(
                    child: Center(
                      child: Text('No Result'),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _buildDialog(BuildContext context) {
    final bloc = context.read<SearchBloc>();
    final state = bloc.state;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Pilih Kategori Film"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile(
                value: FilmType.movies,
                groupValue: state.type,
                title: const Text('Movie'),
                selected: state.type == FilmType.movies,
                onChanged: (FilmType? value) {
                  bloc.add(SearchMovieTypeEvent());
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile(
                value: FilmType.tvShows,
                groupValue: state.type,
                title: const Text('TV'),
                selected: state.type == FilmType.tvShows,
                onChanged: (FilmType? value) {
                  bloc.add(SearchTvShowTypeEvent());
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
