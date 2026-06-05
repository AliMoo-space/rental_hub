part of 'community_offers_cubit.dart';

const Object _communityOffersUnset = Object();

class CommunityOffersState extends Equatable {
  final List<CommunityOfferEntity> incomingOffers;
  final List<CommunityOfferEntity> myOffers;
  final bool isLoadingIncoming;
  final bool isLoadingMyOffers;
  final bool isSubmitting;
  final String? errorMessage;
  final String? actionMessage;

  const CommunityOffersState({
    this.incomingOffers = const [],
    this.myOffers = const [],
    this.isLoadingIncoming = false,
    this.isLoadingMyOffers = false,
    this.isSubmitting = false,
    this.errorMessage,
    this.actionMessage,
  });

  CommunityOffersState copyWith({
    List<CommunityOfferEntity>? incomingOffers,
    List<CommunityOfferEntity>? myOffers,
    bool? isLoadingIncoming,
    bool? isLoadingMyOffers,
    bool? isSubmitting,
    Object? errorMessage = _communityOffersUnset,
    Object? actionMessage = _communityOffersUnset,
  }) {
    return CommunityOffersState(
      incomingOffers: incomingOffers ?? this.incomingOffers,
      myOffers: myOffers ?? this.myOffers,
      isLoadingIncoming: isLoadingIncoming ?? this.isLoadingIncoming,
      isLoadingMyOffers: isLoadingMyOffers ?? this.isLoadingMyOffers,
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
    isLoadingIncoming,
    isLoadingMyOffers,
    isSubmitting,
    errorMessage,
    actionMessage,
  ];
}
