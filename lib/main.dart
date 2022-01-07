import 'package:about/about_page.dart';
import 'package:core/core.dart';
import 'package:core/presentation/bloc/home/home_cubit.dart';
import 'package:core/presentation/bloc/movies/movie_detail_cubit.dart';
import 'package:core/presentation/bloc/movies/popular_movies_cubit.dart';
import 'package:core/presentation/bloc/movies/top_rated_movies_cubit.dart';
import 'package:core/presentation/bloc/tv_shows/popular_tv_shows_cubit.dart';
import 'package:core/presentation/bloc/tv_shows/top_rated_tv_shows_cubit.dart';
import 'package:core/presentation/bloc/tv_shows/tv_show_detail_cubit.dart';
import 'package:core/presentation/pages/home/home_page.dart';
import 'package:core/presentation/pages/movies/movie_detail_page.dart';
import 'package:core/presentation/pages/movies/popular_movies_page.dart';
import 'package:core/presentation/pages/movies/top_rated_movies_page.dart';
import 'package:core/presentation/pages/tv_shows/popular_tv_show_page.dart';
import 'package:core/presentation/pages/tv_shows/top_rated_tv_show_page.dart';
import 'package:core/presentation/pages/tv_shows/tv_show_detail_page.dart';
import 'package:core/presentation/pages/watchlist/watchlist_page.dart';
import 'package:core/utils/routes.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:search/presentation/bloc/search/search_bloc.dart';
import 'package:search/presentation/pages/search_page.dart';
import 'package:core/presentation/bloc/movies/now_playing_movies_cubit.dart';
import 'package:core/presentation/bloc/movies/movie_detail_recommendations_cubit.dart';
import 'package:core/presentation/bloc/movies/movie_detail_watchlist_cubit.dart';
import 'package:core/presentation/bloc/movies/movie_detail_status_cubit.dart';
import 'package:core/presentation/bloc/watchlist/movie_watchlist_cubit.dart';
import 'package:core/presentation/bloc/tv_shows/on_the_air_tv_shows_cubit.dart';
import 'package:core/presentation/bloc/watchlist/tv_show_watchlist_cubit.dart';
import 'package:core/presentation/bloc/tv_shows/tv_show_detail_watchlist_cubit.dart';
import 'package:core/presentation/bloc/tv_shows/tv_show_detail_status_cubit.dart';
import 'package:core/presentation/bloc/tv_shows/tv_show_detail_recommendations_cubit.dart';

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<HomeCubit>(),
        ),
        // Search
        BlocProvider(
          create: (_) => di.locator<SearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailRecommendationsCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailStatusCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailWatchlistCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieWatchlistCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMoviesCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<NowPlayingMoviesCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMoviesCubit>(),
        ),

        BlocProvider(
          create: (_) => di.locator<TvShowDetailCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvShowDetailRecommendationsCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvShowDetailStatusCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvShowDetailWatchlistCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvShowWatchlistCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTvShowsCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTvShowsCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<OnTheAirTvShowsCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
          colorScheme: kColorScheme.copyWith(secondary: kMikadoYellow),
        ),
        home: HomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            // Movie Routes
            case moviePopularRoute:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case movieTopRatedRoute:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case movieDetailRoute:
              final id = settings.arguments as int;
              return CupertinoPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            // TV Routes
            case tvShowPopularRoute:
              return CupertinoPageRoute(builder: (_) => PopularTvShowsPage());
            case tvShowTopRatedRoute:
              return CupertinoPageRoute(builder: (_) => TopRatedTvShowsPage());
            case tvShowDetailRoute:
              final id = settings.arguments as int;
              return CupertinoPageRoute(
                builder: (_) => TvShowDetailPage(id: id),
                settings: settings,
              );
            // Search Routes
            case searchRoute:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            // Watchlist Routes
            case watchlistRoute:
              return CupertinoPageRoute(builder: (_) => WatchlistPage());
            // About Routes
            case AboutPage.routeName:
              return CupertinoPageRoute(builder: (_) => AboutPage());
            // Else Routes
            default:
              return CupertinoPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found 😞'),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
