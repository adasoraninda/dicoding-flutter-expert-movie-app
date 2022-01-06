import 'package:equatable/equatable.dart';

class TriResultListState<T> extends Equatable {
  const TriResultListState({
    required this.topLoading,
    required this.topData,
    required this.topError,
    required this.nowLoading,
    required this.nowData,
    required this.nowError,
    required this.popularLoading,
    required this.popularData,
    required this.popularError,
  });

  final bool topLoading;
  final List<T> topData;
  final String? topError;

  final bool nowLoading;
  final List<T> nowData;
  final String? nowError;

  final bool popularLoading;
  final List<T> popularData;
  final String? popularError;

  factory TriResultListState.init() {
    return TriResultListState<T>(
      topLoading: false,
      topData: const [],
      topError: null,
      nowLoading: false,
      nowData: const [],
      nowError: null,
      popularLoading: false,
      popularData: const [],
      popularError: null,
    );
  }

  TriResultListState<T> copyWith({
    bool? topLoading,
    List<T>? topData,
    String? topError,
    bool? nowLoading,
    List<T>? nowData,
    String? nowError,
    bool? popularLoading,
    List<T>? popularData,
    String? popularError,
  }) {
    return TriResultListState<T>(
      topLoading: topLoading ?? this.topLoading,
      topData: topData ?? this.topData,
      topError: topError ?? this.topError,
      nowLoading: nowLoading ?? this.nowLoading,
      nowData: nowData ?? this.nowData,
      nowError: nowError ?? this.nowError,
      popularLoading: popularLoading ?? this.popularLoading,
      popularData: popularData ?? this.popularData,
      popularError: popularError ?? this.popularError,
    );
  }

  @override
  List<Object?> get props => [
        topLoading,
        topData,
        topError,
        nowLoading,
        nowData,
        nowError,
        popularLoading,
        popularData,
        popularError,
      ];
}
