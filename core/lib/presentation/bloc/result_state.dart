import 'package:equatable/equatable.dart';

class ResultState<T> extends Equatable {
  const ResultState(
    this.loading,
    this.data,
    this.error,
  );

  final bool loading;
  final T data;
  final String? error;

  factory ResultState.init(T data) {
    return ResultState<T>(false, data, null);
  }

  ResultState<T> copyWith({
    bool? loading,
    T? data,
    String? error,
  }) {
    return ResultState(
      loading ?? this.loading,
      data ?? this.data,
      error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [loading, data, error];
}
