part of 'favorite_cubit.dart';

sealed class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object?> get props => [];
}

final class FavoriteInitial extends FavoriteState {}

final class GetFavoritesLoading extends FavoriteState {}

final class GetFavoritesSuccess extends FavoriteState {}

final class GetFavoritesError extends FavoriteState {
  final String message;

  const GetFavoritesError({required this.message});

  @override
  List<Object?> get props => [message];
}
