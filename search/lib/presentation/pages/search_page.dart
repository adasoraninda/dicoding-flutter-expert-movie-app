import 'package:core/core.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:core/presentation/widgets/tv_show_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search/presentation/provider/search_notifier.dart';

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
                    onSubmitted: (query) {
                      Provider.of<SearchNotifier>(context, listen: false)
                          .fetchFilmSearch(query);
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
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child:
                      Consumer<SearchNotifier>(builder: (context, provider, _) {
                    return IconButton(
                      icon: provider.filmType == FilmType.Movies
                          ? const Icon(Icons.movie)
                          : const Icon(Icons.tv),
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        _buildDialog(context, provider);
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
            Consumer<SearchNotifier>(
              builder: (context, data, child) {
                if (data.state == RequestState.loading) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (data.state == RequestState.error) {
                  return Expanded(
                    child: Center(
                      child: Text(data.message),
                    ),
                  );
                }

                if (data.state == RequestState.loaded) {
                  final isDataMovies = data.filmType == FilmType.Movies;
                  final movies = data.searchMoviesResult;
                  final tvShows = data.searchTvShowsResult;

                  if ((!isDataMovies && tvShows.isEmpty) ||
                      (isDataMovies && movies.isEmpty)) {
                    return const Expanded(
                      child: Center(
                        child: Text('No Result'),
                      ),
                    );
                  }

                  return Expanded(
                    child: ListView.builder(
                      itemCount: isDataMovies ? movies.length : tvShows.length,
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final card = isDataMovies
                            ? MovieCard(movies[index])
                            : TvShowCard(tvShows[index]);

                        return card;
                      },
                    ),
                  );
                }

                return const Expanded(
                  child: Center(
                    child: Text('No Result'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _buildDialog(BuildContext context, SearchNotifier provider) {
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
                value: FilmType.Movies,
                groupValue: provider.filmType,
                title: const Text('Movie'),
                selected: provider.filmType == FilmType.Movies,
                onChanged: (FilmType? value) {
                  Provider.of<SearchNotifier>(
                    context,
                    listen: false,
                  ).changeFilmType(value);
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile(
                value: FilmType.TVshows,
                groupValue: provider.filmType,
                title: const Text('TV'),
                selected: provider.filmType == FilmType.TVshows,
                onChanged: (FilmType? value) {
                  Provider.of<SearchNotifier>(
                    context,
                    listen: false,
                  ).changeFilmType(value);
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
