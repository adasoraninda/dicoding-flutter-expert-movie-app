import 'package:core/core.dart';
import 'package:core/presentation/bloc/home/home_cubit.dart';
import 'package:core/presentation/pages/movies/home_movie_page.dart';
import 'package:core/presentation/pages/tv_shows/home_tv_show_page.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Movies'),
              onTap: () {
                setFilmType(FilmType.movies);
              },
            ),
            ListTile(
              leading: const Icon(Icons.tv),
              title: const Text('Tv Shows'),
              onTap: () {
                setFilmType(FilmType.tvShows);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, watchlistRoute);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, aboutRoute);
              },
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, searchRoute);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<HomeCubit, FilmType>(builder: (context, state) {
          late Widget widget;
          switch (state) {
            case FilmType.movies:
              widget = const HomeMoviePage();
              break;
            case FilmType.tvShows:
              widget = const HomeTvShowPage();
              break;
            default:
              widget = const Center(
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
    HomeCubit cubit = context.read<HomeCubit>();

    if (cubit.checkType(type)) {
      Navigator.pop(context);
      return;
    }

    cubit.type = type;
    Navigator.pop(context);
  }
}
