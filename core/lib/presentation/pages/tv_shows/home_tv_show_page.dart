import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv_shows/tv_show.dart';
import 'package:core/presentation/bloc/result_state.dart';
import 'package:core/presentation/bloc/tv_shows/on_the_air_tv_shows_cubit.dart';
import 'package:core/presentation/bloc/tv_shows/popular_tv_shows_cubit.dart';
import 'package:core/presentation/bloc/tv_shows/top_rated_tv_shows_cubit.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTvShowPage extends StatefulWidget {
  const HomeTvShowPage({Key? key}) : super(key: key);

  @override
  _HomeTvShowPageState createState() => _HomeTvShowPageState();
}

class _HomeTvShowPageState extends State<HomeTvShowPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TopRatedTvShowsCubit>().fetchTopRatedTvShows();
      context.read<OnTheAirTvShowsCubit>().fetchOnTheAirTvShows();
      context.read<PopularTvShowsCubit>().fetchPopularTvShows();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'On The Air',
              style: kHeading6,
            ),
            BlocBuilder<OnTheAirTvShowsCubit, ResultState<List<TvShow>>>(
                builder: (context, state) {
              if (state.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state.data?.isNotEmpty == true) {
                return TvShowList(state.data!);
              }

              return const Text('Failed');
            }),
            _buildSubHeading(
              title: 'Popular',
              onTap: () => Navigator.pushNamed(context, tvShowPopularRoute),
            ),
            BlocBuilder<PopularTvShowsCubit, ResultState<List<TvShow>>>(
                builder: (context, state) {
              if (state.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state.data?.isNotEmpty == true) {
                return TvShowList(state.data!);
              }

              return const Text('Failed');
            }),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () => Navigator.pushNamed(context, tvShowTopRatedRoute),
            ),
            BlocBuilder<TopRatedTvShowsCubit, ResultState<List<TvShow>>>(
                builder: (context, state) {
              if (state.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state.data?.isNotEmpty == true) {
                return TvShowList(state.data!);
              }

              return const Text('Failed');
            }),
          ],
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvShowList extends StatelessWidget {
  final List<TvShow> tvShows;

  const TvShowList(this.tvShows, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvShow = tvShows[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  tvShowDetailRoute,
                  arguments: tvShow.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${tvShow.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvShows.length,
      ),
    );
  }
}
