import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rental_hub/feature/subscription/domain/entities/subscription_entity.dart';
import 'package:rental_hub/feature/subscription/domain/usecases/get_subscriptions_usecase.dart';

part 'subscription_state.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  final GetSubscriptionsUseCase _getSubscriptionsUseCase;

  SubscriptionCubit(this._getSubscriptionsUseCase)
    : super(SubscriptionInitial());

  Future<void> fetchSubscriptions() async {
    emit(SubscriptionLoading());

    final result = await _getSubscriptionsUseCase();

    result.fold(
      (failure) => emit(SubscriptionError(message: failure.errMessage)),
      (response) => emit(SubscriptionLoaded(response)),
    );
  }
}
