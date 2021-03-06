import 'package:equatable/equatable.dart';

class ResultState<T> extends Equatable {
  const ResultState({
    required this.loading,
    required this.data,
    required this.error,
  });

  final bool loading;
  final T? data;
  final String? error;

  factory ResultState.init() {
    return ResultState<T>(
      loading: false,
      data: null,
      error: null,
    );
  }

  ResultState<T> copyWith({
    bool? loading,
    T? data,
    String? error,
  }) {
    return ResultState<T>(
      loading: loading ?? this.loading,
      data: data,
      error: error,
    );
  }

  @override
  List<Object?> get props => [loading, data, error];
}
