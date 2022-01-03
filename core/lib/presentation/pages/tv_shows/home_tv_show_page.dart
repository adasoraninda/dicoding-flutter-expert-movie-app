import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv_shows/tv_show.dart';
import 'package:core/presentation/provider/tv_shows/tv_show_list_notifier.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTvShowPage extends StatefulWidget {
  const HomeTvShowPage({Key? key}) : super(key: key);

  @override
  _HomeTvShowPageState createState() => _HomeTvShowPageState();
}

class _HomeTvShowPageState extends State<HomeTvShowPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<TvShowListNotifier>(context, listen: false)
          ..fetchOnTheAirTvShows()
          ..fetchPopularTvShows()
          ..fetchTopRatedTvShows());
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
            Consumer<TvShowListNotifier>(builder: (context, data, child) {
              final state = data.onTheAirState;
              if (state == RequestState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.loaded) {
                return TvShowList(data.onTheAirTvShows);
              } else {
                return const Text('Failed');
              }
            }),
            _buildSubHeading(
              title: 'Popular',
              onTap: () => Navigator.pushNamed(context, tvShowPopularRoute),
            ),
            Consumer<TvShowListNotifier>(builder: (context, data, child) {
              final state = data.popularTvShowsState;
              if (state == RequestState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.loaded) {
                return TvShowList(data.popularTvShows);
              } else {
                return const Text('Failed');
              }
            }),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () => Navigator.pushNamed(context, tvShowTopRatedRoute),
            ),
            Consumer<TvShowListNotifier>(builder: (context, data, child) {
              final state = data.topRatedTvShowsState;
              if (state == RequestState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.loaded) {
                return TvShowList(data.topRatedTvShows);
              } else {
                return const Text('Failed');
              }
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
                  imageUrl: '$BASE_IMAGE_URL${tvShow.posterPath}',
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
