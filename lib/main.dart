import 'package:about/about_page.dart';
import 'package:core/core.dart';
import 'package:core/presentation/pages/home/home_page.dart';
import 'package:core/presentation/pages/movies/movie_detail_page.dart';
import 'package:core/presentation/pages/movies/popular_movies_page.dart';
import 'package:core/presentation/pages/movies/top_rated_movies_page.dart';
import 'package:core/presentation/pages/tv_shows/popular_tv_show_page.dart';
import 'package:core/presentation/pages/tv_shows/top_rated_tv_show_page.dart';
import 'package:core/presentation/pages/tv_shows/tv_show_detail_page.dart';
import 'package:core/presentation/pages/watchlist/watchlist_page.dart';
import 'package:core/presentation/provider/home/home_notifier.dart';
import 'package:core/presentation/provider/movies/movie_detail_notifier.dart';
import 'package:core/presentation/provider/movies/movie_list_notifier.dart';
import 'package:core/presentation/provider/movies/popular_movies_notifier.dart';
import 'package:core/presentation/provider/movies/top_rated_movies_notifier.dart';
import 'package:core/presentation/provider/tv_shows/popular_tv_shows_notifier.dart';
import 'package:core/presentation/provider/tv_shows/top_rated_tv_shows_notifier.dart';
import 'package:core/presentation/provider/tv_shows/tv_show_detail_notifier.dart';
import 'package:core/presentation/provider/tv_shows/tv_show_list_notifier.dart';
import 'package:core/presentation/provider/watchlist/watchlist_notifier.dart';
import 'package:core/utils/routes.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search/presentation/pages/search_page.dart';
import 'package:search/presentation/provider/search_notifier.dart';

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<HomeNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistNotifier>(),
        ),
        // Search
        ChangeNotifierProvider(
          create: (_) => di.locator<SearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvShowListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvShowDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTvShowsNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTvShowsNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          accentColor: kMikadoYellow,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
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
            case AboutPage.ROUTE_NAME:
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
