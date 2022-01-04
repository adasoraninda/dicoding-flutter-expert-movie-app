import 'package:equatable/equatable.dart';

class DetailState<T1, T2> extends Equatable {
  const DetailState(
    this.detailLoading,
    this.detailData,
    this.detailError,
    this.recLoading,
    this.recData,
    this.recError,
    this.watchlistLoading,
    this.watchlistMessage,
    this.status,
  );

  final bool detailLoading;
  final T1? detailData;
  final String? detailError;

  final bool recLoading;
  final List<T2> recData;
  final String? recError;

  final bool watchlistLoading;
  final String? watchlistMessage;

  final bool status;

  factory DetailState.init() {
    return DetailState<T1, T2>(
      false,
      null,
      null,
      false,
      [],
      null,
      false,
      null,
      false,
    );
  }

  DetailState<T1, T2> copyWith({
    bool? detailLoading,
    T1? detailData,
    String? detailError,
    bool? recLoading,
    List<T2>? recData,
    String? recError,
    bool? watchlistLoading,
    String? watchlistMessage,
    bool? status,
  }) {
    return DetailState(
      detailLoading ?? this.detailLoading,
      detailData ?? this.detailData,
      detailError ?? this.detailError,
      recLoading ?? this.recLoading,
      recData ?? this.recData,
      recError ?? this.recError,
      watchlistLoading ?? this.watchlistLoading,
      watchlistMessage ?? this.watchlistMessage,
      status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        detailLoading,
        detailData,
        detailError,
        recLoading,
        recData,
        recError,
        watchlistLoading,
        watchlistMessage,
        status,
      ];
}
