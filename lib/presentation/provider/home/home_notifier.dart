import 'package:ditonton/common/type_film_enum.dart';
import 'package:flutter/cupertino.dart';

class HomeNotifier extends ChangeNotifier {
  FilmType _filmType = FilmType.Movies;

  FilmType get filmType => _filmType;

  bool checkType(FilmType type) => _filmType == type;

  void changeFilmType(FilmType type) {
    _filmType = type;
    notifyListeners();
  }
}
