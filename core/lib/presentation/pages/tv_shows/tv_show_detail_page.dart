import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/tv_shows/tv_show.dart';
import 'package:core/domain/entities/tv_shows/tv_show_detail.dart';
import 'package:core/presentation/bloc/result_state.dart';
import 'package:core/presentation/bloc/tv_shows/tv_show_detail_cubit.dart';
import 'package:core/presentation/bloc/tv_shows/tv_show_detail_recommendations_cubit.dart';
import 'package:core/presentation/bloc/tv_shows/tv_show_detail_status_cubit.dart';
import 'package:core/presentation/bloc/tv_shows/tv_show_detail_watchlist_cubit.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TvShowDetailPage extends StatefulWidget {
  final int id;

  const TvShowDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _TvShowDetailPageState createState() => _TvShowDetailPageState();
}

class _TvShowDetailPageState extends State<TvShowDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvShowDetailCubit>().fetchTvShowDetail(widget.id);
      context
          .read<TvShowDetailRecommendationsCubit>()
          .fetchTvShowDetailRecommendations(widget.id);
      context.read<TvShowDetailStatusCubit>().loadWatchlistStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        return true;
      },
      child: Scaffold(
        body: BlocListener<TvShowDetailWatchlistCubit, ResultState<String?>>(
          listener: (context, state) {
            if (state.data != null) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(content: Text(state.data!)));
            }

            if (state.error != null) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(state.error!),
                    );
                  });
            }
          },
          child: BlocBuilder<TvShowDetailCubit, ResultState<TvShowDetail>>(
              builder: (context, state) {
            if (state.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state.data != null) {
              final tvShow = state.data;

              return SafeArea(
                child: DetailContent(tvShow!),
              );
            }

            return Center(
              child: Text(state.error ?? ''),
            );
          }),
        ),
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvShowDetail tvShow;

  const DetailContent(this.tvShow, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvShow.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tvShow.name,
                              style: kHeading5,
                            ),
                            BlocBuilder<TvShowDetailStatusCubit, bool>(
                                builder: (context, state) {
                              return ElevatedButton(
                                onPressed: () async {
                                  if (!state) {
                                    await context
                                        .read<TvShowDetailWatchlistCubit>()
                                        .addWatchlist(tvShow);
                                  } else {
                                    await context
                                        .read<TvShowDetailWatchlistCubit>()
                                        .removeFromWatchlist(tvShow);
                                  }

                                  context
                                      .read<TvShowDetailStatusCubit>()
                                      .loadWatchlistStatus(tvShow.id);
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    state
                                        ? const Icon(Icons.check)
                                        : const Icon(Icons.add),
                                    const Text('Watchlist'),
                                  ],
                                ),
                              );
                            }),
                            Text(
                              _showGenres(tvShow.genres),
                            ),
                            Text(
                              _showDuration(tvShow.episodeRunTime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvShow.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvShow.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvShow.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<TvShowDetailRecommendationsCubit,
                                ResultState<List<TvShow>>>(
                              builder: (context, state) {
                                if (state.loading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                if (state.error != null) {
                                  return Text(state.error!);
                                }

                                if (state.data?.isNotEmpty == true) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: state.data!.length,
                                      itemBuilder: (context, index) {
                                        final tvShow = state.data![index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                tvShowDetailRoute,
                                                arguments: tvShow.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${tvShow.posterPath}',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }

                                return Container();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
