import 'package:ditonton/common/type_film_enum.dart';
import 'package:ditonton/presentation/pages/about/about_page.dart';
import 'package:ditonton/presentation/pages/movies/home_movie_page.dart';
import 'package:ditonton/presentation/pages/search/search_page.dart';
import 'package:ditonton/presentation/pages/tv_shows/home_tv_show_page.dart';
import 'package:ditonton/presentation/pages/watchlist/watchlist_page.dart';
import 'package:ditonton/presentation/provider/home/home_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                setFilmType(FilmType.Movies);
              },
            ),
            ListTile(
              leading: Icon(Icons.tv),
              title: Text('Tv Shows'),
              onTap: () {
                setFilmType(FilmType.TVshows);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: SafeArea(
        child: Consumer<HomeNotifier>(builder: (context, provider, _) {
          FilmType filmType = provider.filmType;
          late Widget widget;
          switch (filmType) {
            case FilmType.Movies:
              widget = HomeMoviePage();
              break;
            case FilmType.TVshows:
              widget = HomeTvShowPage();
              break;
            default:
              widget = Center(
                child: Text('Page not found 😞'),
              );
              break;
          }

          return widget;
        }),
      ),
    );
  }

  void setFilmType(FilmType type) {
    HomeNotifier provider = Provider.of<HomeNotifier>(context, listen: false);

    if (provider.checkType(type)) {
      Navigator.pop(context);
      return;
    }

    provider.changeFilmType(type);
    Navigator.pop(context);
  }
}
