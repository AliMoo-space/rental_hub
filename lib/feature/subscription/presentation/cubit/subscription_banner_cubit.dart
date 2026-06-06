import 'package:bloc/bloc.dart';
import 'dart:developer' as developer;
import 'package:rental_hub/feature/subscription/domain/usecases/get_subscription_active_use_case.dart';

import 'subscription_banner_state.dart';

class SubscriptionBannerCubit extends Cubit<SubscriptionBannerState> {
  final GetSubscriptionActiveUseCase _getActive;

  SubscriptionBannerCubit(this._getActive) : super(SubscriptionBannerInitial());

  Future<void> load() async {
    emit(SubscriptionBannerLoading());
    final result = await _getActive();
    result.fold((failure) {
      developer.log(
        'SubscriptionBannerCubit.load: failed to resolve active subscription\n'
        'status=${failure.statusCode}\n'
        'message=${failure.errMessage}\n'
        'Falling back to inactive so Home keeps rendering.',
        name: 'Subscription',
      );
      emit(const SubscriptionBannerLoaded(false));
    }, (value) => emit(SubscriptionBannerLoaded(value.hasActiveSubscription)));
  }
}
