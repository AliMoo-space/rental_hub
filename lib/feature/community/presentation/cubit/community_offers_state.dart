part of 'community_offers_cubit.dart';

const Object _communityOffersUnset = Object();

class CommunityOffersState extends Equatable {
  final List<CommunityOfferEntity> incomingOffers;
  final List<CommunityOfferEntity> myOffers;
  final List<CommunityOfferEntity> requestOffers;
  final bool isLoadingIncoming;
  final bool isLoadingMyOffers;
  final bool isLoadingRequestOffers;
  final bool isSubmitting;
  final String? errorMessage;
  final String? actionMessage;

  const CommunityOffersState({
    this.incomingOffers = const [],
    this.myOffers = const [],
    this.requestOffers = const [],
    this.isLoadingIncoming = false,
    this.isLoadingMyOffers = false,
    this.isLoadingRequestOffers = false,
    this.isSubmitting = false,
    this.errorMessage,
    this.actionMessage,
  });

  CommunityOffersState copyWith({
    List<CommunityOfferEntity>? incomingOffers,
    List<CommunityOfferEntity>? myOffers,
    List<CommunityOfferEntity>? requestOffers,
    bool? isLoadingIncoming,
    bool? isLoadingMyOffers,
    bool? isLoadingRequestOffers,
    bool? isSubmitting,
    Object? errorMessage = _communityOffersUnset,
    Object? actionMessage = _communityOffersUnset,
  }) {
    return CommunityOffersState(
      incomingOffers: incomingOffers ?? this.incomingOffers,
      myOffers: myOffers ?? this.myOffers,
      requestOffers: requestOffers ?? this.requestOffers,
      isLoadingIncoming: isLoadingIncoming ?? this.isLoadingIncoming,
      isLoadingMyOffers: isLoadingMyOffers ?? this.isLoadingMyOffers,
      isLoadingRequestOffers:
          isLoadingRequestOffers ?? this.isLoadingRequestOffers,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: identical(errorMessage, _communityOffersUnset)
          ? this.errorMessage
          : errorMessage as String?,
      actionMessage: identical(actionMessage, _communityOffersUnset)
          ? this.actionMessage
          : actionMessage as String?,
    );
  }

  @override
  List<Object?> get props => [
    incomingOffers,
    myOffers,
    requestOffers,
    isLoadingIncoming,
    isLoadingMyOffers,
    isLoadingRequestOffers,
    isSubmitting,
    errorMessage,
    actionMessage,
  ];
}
