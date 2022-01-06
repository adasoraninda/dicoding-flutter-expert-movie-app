import 'package:equatable/equatable.dart';

class DetailState<T1, T2> extends Equatable {
  const DetailState({
    required this.detailLoading,
    required this.detailData,
    required this.detailError,
    required this.recLoading,
    required this.recData,
    required this.recError,
    required this.watchlistLoading,
    required this.watchlistMessageSuccess,
    required this.watchlistMessageError,
    required this.status,
  });

  final bool detailLoading;
  final T1? detailData;
  final String? detailError;

  final bool recLoading;
  final List<T2> recData;
  final String? recError;

  final bool watchlistLoading;
  final String? watchlistMessageSuccess;
  final String? watchlistMessageError;

  final bool status;

  factory DetailState.init() {
    return DetailState<T1, T2>(
      detailLoading: false,
      detailData: null,
      detailError: null,
      recLoading: false,
      recData: const [],
      recError: null,
      watchlistLoading: false,
      watchlistMessageSuccess: null,
      watchlistMessageError: null,
      status: false,
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
    String? watchlistMessageSuccess,
    String? watchlistMessageError,
    bool? status,
  }) {
    return DetailState(
      detailLoading: detailLoading ?? this.detailLoading,
      detailData: detailData ?? this.detailData,
      detailError: detailError ?? this.detailError,
      recLoading: recLoading ?? this.recLoading,
      recData: recData ?? this.recData,
      recError: recError ?? this.recError,
      watchlistLoading: watchlistLoading ?? this.watchlistLoading,
      watchlistMessageSuccess: watchlistMessageSuccess,
      watchlistMessageError: watchlistMessageError,
      status: status ?? this.status,
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
        watchlistMessageSuccess,
        watchlistMessageError,
        status,
      ];
}
