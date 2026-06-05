part of 'community_requests_cubit.dart';

const Object _communityRequestsUnset = Object();

class CommunityRequestsState extends Equatable {
  final List<CommunityRequestEntity> requests;
  final List<CommunityRequestEntity> myRequests;
  final CommunityRequestEntity? selectedRequest;
  final CommunityRequestsQuery query;
  final int pageNumber;
  final bool hasNextPage;
  final bool isLoading;
  final bool isLoadingMore;
  final bool isLoadingMyRequests;
  final bool isLoadingDetails;
  final bool isSubmitting;
  final String? errorMessage;
  final String? actionMessage;

  const CommunityRequestsState({
    this.requests = const [],
    this.myRequests = const [],
    this.selectedRequest,
    this.query = const CommunityRequestsQuery(),
    this.pageNumber = 1,
    this.hasNextPage = false,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.isLoadingMyRequests = false,
    this.isLoadingDetails = false,
    this.isSubmitting = false,
    this.errorMessage,
    this.actionMessage,
  });

  CommunityRequestsState copyWith({
    List<CommunityRequestEntity>? requests,
    List<CommunityRequestEntity>? myRequests,
    CommunityRequestEntity? selectedRequest,
    CommunityRequestsQuery? query,
    int? pageNumber,
    bool? hasNextPage,
    bool? isLoading,
    bool? isLoadingMore,
    bool? isLoadingMyRequests,
    bool? isLoadingDetails,
    bool? isSubmitting,
    Object? errorMessage = _communityRequestsUnset,
    Object? actionMessage = _communityRequestsUnset,
  }) {
    return CommunityRequestsState(
      requests: requests ?? this.requests,
      myRequests: myRequests ?? this.myRequests,
      selectedRequest: selectedRequest ?? this.selectedRequest,
      query: query ?? this.query,
      pageNumber: pageNumber ?? this.pageNumber,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isLoadingMyRequests: isLoadingMyRequests ?? this.isLoadingMyRequests,
      isLoadingDetails: isLoadingDetails ?? this.isLoadingDetails,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: identical(errorMessage, _communityRequestsUnset)
          ? this.errorMessage
          : errorMessage as String?,
      actionMessage: identical(actionMessage, _communityRequestsUnset)
          ? this.actionMessage
          : actionMessage as String?,
    );
  }

  @override
  List<Object?> get props => [
    requests,
    myRequests,
    selectedRequest,
    query,
    pageNumber,
    hasNextPage,
    isLoading,
    isLoadingMore,
    isLoadingMyRequests,
    isLoadingDetails,
    isSubmitting,
    errorMessage,
    actionMessage,
  ];
}

extension CommunityRequestsQueryCopy on CommunityRequestsQuery {
  CommunityRequestsQuery copyWith({
    int? categoryId,
    int? subcategoryId,
    String? governorate,
    String? city,
    String? search,
    int? pageNumber,
    int? pageSize,
  }) {
    return CommunityRequestsQuery(
      categoryId: categoryId ?? this.categoryId,
      subcategoryId: subcategoryId ?? this.subcategoryId,
      governorate: governorate ?? this.governorate,
      city: city ?? this.city,
      search: search ?? this.search,
      pageNumber: pageNumber ?? this.pageNumber,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}
