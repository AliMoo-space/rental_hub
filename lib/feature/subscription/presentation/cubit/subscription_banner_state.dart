import 'package:equatable/equatable.dart';

sealed class SubscriptionBannerState extends Equatable {
  const SubscriptionBannerState();

  @override
  List<Object?> get props => [];
}

final class SubscriptionBannerInitial extends SubscriptionBannerState {}

final class SubscriptionBannerLoading extends SubscriptionBannerState {}

final class SubscriptionBannerLoaded extends SubscriptionBannerState {
  final bool hasActive;

  const SubscriptionBannerLoaded(this.hasActive);

  @override
  List<Object?> get props => [hasActive];
}

final class SubscriptionBannerError extends SubscriptionBannerState {
  final String message;

  const SubscriptionBannerError(this.message);

  @override
  List<Object?> get props => [message];
}
