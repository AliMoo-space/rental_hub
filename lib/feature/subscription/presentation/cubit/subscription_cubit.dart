import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rental_hub/feature/subscription/domain/entities/subscription_entity.dart';
import 'package:rental_hub/feature/subscription/domain/usecases/get_subscriptions_usecase.dart';
import 'package:rental_hub/feature/subscription/domain/usecases/subscribe_to_plan_use_case.dart';

part 'subscription_state.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  final GetSubscriptionsUseCase _getSubscriptionsUseCase;
  final SubscribeToPlanUseCase _subscribeToPlanUseCase;

  SubscriptionCubit(this._getSubscriptionsUseCase, this._subscribeToPlanUseCase)
    : super(SubscriptionInitial());

  Future<void> fetchSubscriptions() async {
    emit(SubscriptionLoading());

    final result = await _getSubscriptionsUseCase();

    result.fold(
      (failure) => emit(SubscriptionError(message: failure.errMessage)),
      (response) => emit(SubscriptionLoaded(response)),
    );
  }

  Future<void> subscribeToPlan(int subscriptionId) async {
    final currentState = state;
    if (currentState is! SubscriptionLoaded || currentState.isSubmitting) {
      return;
    }

    emit(
      currentState.copyWith(
        isSubmitting: true,
        actionMessage: null,
        errorMessage: null,
      ),
    );

    final result = await _subscribeToPlanUseCase(
      subscriptionId: subscriptionId,
    );

    result.fold(
      (failure) => emit(
        currentState.copyWith(
          isSubmitting: false,
          errorMessage: failure.errMessage,
        ),
      ),
      (value) => emit(
        currentState.copyWith(
          isSubmitting: false,
          actionMessage: value.message,
        ),
      ),
    );
  }

  void clearFeedback() {
    final currentState = state;
    if (currentState is! SubscriptionLoaded) {
      return;
    }

    emit(currentState.copyWith(actionMessage: null, errorMessage: null));
  }
}
