import 'package:equatable/equatable.dart';

class TriResultListState<T> extends Equatable {
  const TriResultListState(
    this.topLoading,
    this.topData,
    this.topError,
    this.nowLoading,
    this.nowData,
    this.nowError,
    this.popularLoading,
    this.popularData,
    this.popularError,
  );

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
      false,
      const [],
      null,
      false,
      const [],
      null,
      false,
      const [],
      null,
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
      topLoading ?? this.topLoading,
      topData ?? this.topData,
      topError ?? this.topError,
      nowLoading ?? this.nowLoading,
      nowData ?? this.nowData,
      nowError ?? this.nowError,
      popularLoading ?? this.popularLoading,
      popularData ?? this.popularData,
      popularError ?? this.popularError,
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
