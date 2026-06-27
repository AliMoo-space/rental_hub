import 'package:equatable/equatable.dart';
import 'package:rental_hub/feature/search/domain/entities/live_suggestion_entity.dart';
import 'package:rental_hub/feature/search/domain/entities/search_result_entity.dart';

abstract class SearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class LiveSearchLoading extends SearchState {}

class LiveSearchLoaded extends SearchState {
  final List<LiveSuggestionEntity> suggestions;
  LiveSearchLoaded(this.suggestions);
  @override
  List<Object?> get props => [suggestions];
}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final SearchResultEntity results;
  final bool hasMore;
  final Set<int> favoriteLoadingProductIds;

  SearchLoaded(this.results, this.hasMore, {this.favoriteLoadingProductIds = const {}});

  bool isFavoriteLoading(int productId) =>
      favoriteLoadingProductIds.contains(productId);

  @override
  List<Object?> get props => [results, hasMore, favoriteLoadingProductIds];
}

class SearchLoadingMore extends SearchState {}

class SearchEmpty extends SearchState {}

class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
  @override
  List<Object?> get props => [message];
}
