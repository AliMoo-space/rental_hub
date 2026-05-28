part of 'subscription_cubit.dart';

const Object _subscriptionStateUnset = Object();

sealed class SubscriptionState extends Equatable {
  const SubscriptionState();

  @override
  List<Object?> get props => [];
}

final class SubscriptionInitial extends SubscriptionState {}

final class SubscriptionLoading extends SubscriptionState {}

final class SubscriptionLoaded extends SubscriptionState {
  final SubscriptionResponseEntity response;
  final bool isSubmitting;
  final String? actionMessage;
  final String? errorMessage;

  const SubscriptionLoaded(
    this.response, {
    this.isSubmitting = false,
    this.actionMessage,
    this.errorMessage,
  });

  List<SubscriptionPlanEntity> get plans => response.items;

  SubscriptionLoaded copyWith({
    SubscriptionResponseEntity? response,
    bool? isSubmitting,
    Object? actionMessage = _subscriptionStateUnset,
    Object? errorMessage = _subscriptionStateUnset,
  }) {
    return SubscriptionLoaded(
      response ?? this.response,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      actionMessage: identical(actionMessage, _subscriptionStateUnset)
          ? this.actionMessage
          : actionMessage as String?,
      errorMessage: identical(errorMessage, _subscriptionStateUnset)
          ? this.errorMessage
          : errorMessage as String?,
    );
  }

  @override
  List<Object?> get props => [
    response,
    isSubmitting,
    actionMessage,
    errorMessage,
  ];
}

final class SubscriptionError extends SubscriptionState {
  final String message;

  const SubscriptionError({required this.message});

  @override
  List<Object?> get props => [message];
}
