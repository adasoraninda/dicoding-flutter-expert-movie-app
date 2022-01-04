import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<FilmType> {
  HomeCubit() : super(FilmType.movies);

  set type(FilmType type) => emit(type);

  bool checkType(FilmType type) => state == type;
}
