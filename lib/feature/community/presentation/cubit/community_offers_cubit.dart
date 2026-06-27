import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/community/domain/entities/community_offer_entity.dart';
import 'package:rental_hub/feature/community/domain/entities/create_community_offer_params.dart';
import 'package:rental_hub/feature/community/domain/usecases/accept_offer_use_case.dart';
import 'package:rental_hub/feature/community/domain/usecases/create_community_offer_use_case.dart';
import 'package:rental_hub/feature/community/domain/usecases/get_my_offers_use_case.dart';
import 'package:rental_hub/feature/community/domain/usecases/get_my_requests_offers_use_case.dart';
import 'package:rental_hub/feature/community/domain/usecases/get_request_offers_use_case.dart';
import 'package:rental_hub/feature/community/domain/usecases/reject_offer_use_case.dart';

part 'community_offers_state.dart';

class CommunityOffersCubit extends Cubit<CommunityOffersState> {
  final CreateCommunityOfferUseCase createCommunityOfferUseCase;
  final GetMyRequestsOffersUseCase getMyRequestsOffersUseCase;
  final GetMyOffersUseCase getMyOffersUseCase;
  final GetRequestOffersUseCase getRequestOffersUseCase;
  final AcceptOfferUseCase acceptOfferUseCase;
  final RejectOfferUseCase rejectOfferUseCase;

  CommunityOffersCubit(
    this.createCommunityOfferUseCase,
    this.getMyRequestsOffersUseCase,
    this.getMyOffersUseCase,
    this.getRequestOffersUseCase,
    this.acceptOfferUseCase,
    this.rejectOfferUseCase,
  ) : super(const CommunityOffersState());

  Future<void> loadIncomingOffers() async {
    if (isClosed) return;
    emit(state.copyWith(isLoadingIncoming: true, errorMessage: null));

    final result = await getMyRequestsOffersUseCase();
    if (isClosed) return;
    result.fold(
      (failure) => emit(
        state.copyWith(
          isLoadingIncoming: false,
          errorMessage: failure.errMessage,
        ),
      ),
      (offers) => emit(
        state.copyWith(isLoadingIncoming: false, incomingOffers: offers),
      ),
    );
  }

  Future<void> loadMyOffers() async {
    if (isClosed) return;
    emit(state.copyWith(isLoadingMyOffers: true, errorMessage: null));

    final result = await getMyOffersUseCase();
    if (isClosed) return;
    result.fold(
      (failure) => emit(
        state.copyWith(
          isLoadingMyOffers: false,
          errorMessage: failure.errMessage,
        ),
      ),
      (offers) =>
          emit(state.copyWith(isLoadingMyOffers: false, myOffers: offers)),
    );
  }

  Future<void> loadRequestOffers(int requestId) async {
    if (isClosed) return;
    emit(state.copyWith(isLoadingRequestOffers: true, errorMessage: null));

    final result = await getRequestOffersUseCase(requestId);
    if (isClosed) return;
    result.fold(
      (failure) => emit(
        state.copyWith(
          isLoadingRequestOffers: false,
          errorMessage: failure.errMessage,
        ),
      ),
      (offers) => emit(
        state.copyWith(isLoadingRequestOffers: false, requestOffers: offers),
      ),
    );
  }

  Future<bool> submitOffer(CreateCommunityOfferParams params) async {
    if (isClosed) return false;
    emit(
      state.copyWith(
        isSubmitting: true,
        errorMessage: null,
        actionMessage: null,
      ),
    );

    final result = await createCommunityOfferUseCase(params);
    if (isClosed) return false;

    return result.fold(
      (failure) {
        emit(
          state.copyWith(isSubmitting: false, errorMessage: failure.errMessage),
        );
        return false;
      },
      (message) {
        emit(state.copyWith(isSubmitting: false, actionMessage: message));
        loadMyOffers();
        return true;
      },
    );
  }

  Future<bool> acceptOffer(int offerId) async {
    if (isClosed) return false;
    emit(
      state.copyWith(
        isSubmitting: true,
        errorMessage: null,
        actionMessage: null,
      ),
    );

    final result = await acceptOfferUseCase(offerId);
    if (isClosed) return false;
    return _handleOfferActionResult(result);
  }

  Future<bool> rejectOffer(int offerId) async {
    if (isClosed) return false;
    emit(
      state.copyWith(
        isSubmitting: true,
        errorMessage: null,
        actionMessage: null,
      ),
    );

    final result = await rejectOfferUseCase(offerId);
    if (isClosed) return false;
    return _handleOfferActionResult(result);
  }

  bool _handleOfferActionResult(Either<Failure, String> result) {
    return result.fold(
      (failure) {
        emit(
          state.copyWith(isSubmitting: false, errorMessage: failure.errMessage),
        );
        return false;
      },
      (message) {
        emit(state.copyWith(isSubmitting: false, actionMessage: message));
        loadIncomingOffers();
        return true;
      },
    );
  }

  void clearMessages() {
    if (!isClosed) {
      emit(state.copyWith(errorMessage: null, actionMessage: null));
    }
  }
}
