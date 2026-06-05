import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rental_hub/feature/community/domain/entities/community_request_entity.dart';
import 'package:rental_hub/feature/community/domain/entities/community_requests_query.dart';
import 'package:rental_hub/feature/community/domain/entities/create_community_request_params.dart';
import 'package:rental_hub/feature/community/domain/usecases/create_community_request_use_case.dart';
import 'package:rental_hub/feature/community/domain/usecases/get_community_request_details_use_case.dart';
import 'package:rental_hub/feature/community/domain/usecases/get_community_requests_use_case.dart';
import 'package:rental_hub/feature/community/domain/usecases/get_my_requests_use_case.dart';

part 'community_requests_state.dart';

class CommunityRequestsCubit extends Cubit<CommunityRequestsState> {
  final GetCommunityRequestsUseCase getCommunityRequestsUseCase;
  final GetCommunityRequestDetailsUseCase getCommunityRequestDetailsUseCase;
  final CreateCommunityRequestUseCase createCommunityRequestUseCase;
  final GetMyRequestsUseCase getMyRequestsUseCase;

  CommunityRequestsCubit(
    this.getCommunityRequestsUseCase,
    this.getCommunityRequestDetailsUseCase,
    this.createCommunityRequestUseCase,
    this.getMyRequestsUseCase,
  ) : super(const CommunityRequestsState());

  Future<void> loadRequests({
    bool refresh = false,
    CommunityRequestsQuery? query,
  }) async {
    if (state.isLoading && !refresh) return;

    final nextQuery = query ?? state.query;
    emit(
      state.copyWith(
        isLoading: true,
        errorMessage: null,
        query: nextQuery,
      ),
    );

    final result = await getCommunityRequestsUseCase(nextQuery);
    result.fold(
      (failure) => emit(
        state.copyWith(isLoading: false, errorMessage: failure.errMessage),
      ),
      (page) => emit(
        state.copyWith(
          isLoading: false,
          requests: page.items,
          hasNextPage: page.hasNext,
          pageNumber: page.pageNumber,
        ),
      ),
    );
  }

  Future<void> loadMoreRequests() async {
    if (state.isLoadingMore || !state.hasNextPage) return;

    emit(state.copyWith(isLoadingMore: true, errorMessage: null));

    final nextQuery = state.query.copyWith(pageNumber: state.pageNumber + 1);
    final result = await getCommunityRequestsUseCase(nextQuery);

    result.fold(
      (failure) => emit(
        state.copyWith(isLoadingMore: false, errorMessage: failure.errMessage),
      ),
      (page) => emit(
        state.copyWith(
          isLoadingMore: false,
          requests: [...state.requests, ...page.items],
          hasNextPage: page.hasNext,
          pageNumber: page.pageNumber,
          query: nextQuery,
        ),
      ),
    );
  }

  Future<void> searchRequests(String search) async {
    await loadRequests(
      refresh: true,
      query: state.query.copyWith(search: search.trim(), pageNumber: 1),
    );
  }

  Future<void> loadMyRequests({String? status}) async {
    emit(state.copyWith(isLoadingMyRequests: true, errorMessage: null));

    final result = await getMyRequestsUseCase(
      MyCommunityRequestsQuery(status: status),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          isLoadingMyRequests: false,
          errorMessage: failure.errMessage,
        ),
      ),
      (page) => emit(
        state.copyWith(
          isLoadingMyRequests: false,
          myRequests: page.items,
        ),
      ),
    );
  }

  Future<CommunityRequestEntity?> loadRequestDetails(int id) async {
    emit(state.copyWith(isLoadingDetails: true, errorMessage: null));

    final result = await getCommunityRequestDetailsUseCase(id);
    return result.fold(
      (failure) {
        emit(state.copyWith(isLoadingDetails: false, errorMessage: failure.errMessage));
        return null;
      },
      (request) {
        emit(
          state.copyWith(
            isLoadingDetails: false,
            selectedRequest: request,
          ),
        );
        return request;
      },
    );
  }

  Future<bool> createRequest(CreateCommunityRequestParams params) async {
    emit(state.copyWith(isSubmitting: true, errorMessage: null, actionMessage: null));

    final result = await createCommunityRequestUseCase(params);

    return result.fold(
      (failure) {
        emit(
          state.copyWith(
            isSubmitting: false,
            errorMessage: failure.errMessage,
          ),
        );
        return false;
      },
      (message) {
        emit(
          state.copyWith(
            isSubmitting: false,
            actionMessage: message,
          ),
        );
        loadRequests(refresh: true);
        loadMyRequests();
        return true;
      },
    );
  }

  void clearMessages() {
    emit(state.copyWith(errorMessage: null, actionMessage: null));
  }
}
