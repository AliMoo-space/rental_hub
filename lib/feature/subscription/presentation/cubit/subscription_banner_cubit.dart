import 'package:bloc/bloc.dart';
import 'package:rental_hub/feature/subscription/domain/usecases/get_subscription_active_use_case.dart';

import 'subscription_banner_state.dart';

class SubscriptionBannerCubit extends Cubit<SubscriptionBannerState> {
  final GetSubscriptionActiveUseCase _getActive;

  SubscriptionBannerCubit(this._getActive) : super(SubscriptionBannerInitial());

  Future<void> load() async {
    emit(SubscriptionBannerLoading());
    final result = await _getActive();
    result.fold(
      (failure) => emit(SubscriptionBannerError(failure.errMessage)),
      (value) => emit(SubscriptionBannerLoaded(value.hasActiveSubscription)),
    );
  }
}
