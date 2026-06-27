import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:rental_hub/feature/add_listing/data/models/create_product_request.dart';
import 'package:rental_hub/feature/add_listing/data/models/update_product_request.dart';
import 'package:rental_hub/feature/add_listing/domain/usecases/add_listing_use_case.dart';
import 'package:rental_hub/feature/add_listing/domain/usecases/update_listing_use_case.dart';
import 'package:rental_hub/feature/home/domain/entities/category_entity.dart';
import 'package:rental_hub/feature/home/domain/usecases/get_category.dart';
import 'package:rental_hub/feature/home/domain/usecases/get_subcategories_usecase.dart';

import 'add_listing_state.dart';

class AddListingCubit extends Cubit<AddListingState> {
  final AddListingUseCase addListingUseCase;
  final UpdateListingUseCase updateListingUseCase;
  final GetCategory getCategoryUseCase;
  final GetSubcategoriesUseCase getSubcategoriesUseCase;

  AddListingCubit(
    this.addListingUseCase,
    this.updateListingUseCase,
    this.getCategoryUseCase,
    this.getSubcategoriesUseCase,
  ) : super(const AddListingState());

  Future<void> loadCategories() async {
    emit(
      state.copyWith(
        isCategoriesLoading: true,
        errorMessage: null,
        successMessage: null,
      ),
    );

    final result = await getCategoryUseCase();
    result.fold(
      (failure) => emit(
        state.copyWith(
          isCategoriesLoading: false,
          errorMessage: failure.errMessage,
        ),
      ),
      (categories) {
        final flattenedCategories = categories
            .expand<SubCategoryEntity>((category) => category.items)
            .toList();

        emit(
          state.copyWith(
            isCategoriesLoading: false,
            categories: flattenedCategories,
          ),
        );
      },
    );
  }

  Future<void> loadSubcategories(int categoryId) async {
    emit(
      state.copyWith(
        isSubcategoriesLoading: true,
        subcategories: const [],
        errorMessage: null,
        successMessage: null,
      ),
    );

    final result = await getSubcategoriesUseCase(categoryId);
    result.fold(
      (failure) => emit(
        state.copyWith(
          isSubcategoriesLoading: false,
          errorMessage: failure.errMessage,
        ),
      ),
      (subcategories) {
        emit(
          state.copyWith(
            isSubcategoriesLoading: false,
            subcategories: subcategories,
          ),
        );
      },
    );
  }

  Future<void> submitListing(CreateProductRequest request) async {
    if (state.isSubmitting) return;

    emit(
      state.copyWith(
        isSubmitting: true,
        successMessage: null,
        errorMessage: null,
      ),
    );

    final result = await addListingUseCase(request);

    result.fold(
      (failure) {
        developer.log(
          'submitListing failed\n'
          'statusCode=${failure.statusCode}\n'
          'message=${failure.errMessage}',
          name: 'AddListing',
        );
        emit(
          state.copyWith(isSubmitting: false, errorMessage: failure.errMessage),
        );
      },
      (message) =>
          emit(state.copyWith(isSubmitting: false, successMessage: message)),
    );
  }

  Future<void> updateListing(int id, UpdateProductRequest request) async {
    if (state.isSubmitting) return;

    emit(
      state.copyWith(
        isSubmitting: true,
        successMessage: null,
        errorMessage: null,
      ),
    );

    final result = await updateListingUseCase(id, request);

    result.fold(
      (failure) {
        developer.log(
          'updateListing failed\n'
          'statusCode=${failure.statusCode}\n'
          'message=${failure.errMessage}',
          name: 'AddListing',
        );
        emit(
          state.copyWith(isSubmitting: false, errorMessage: failure.errMessage),
        );
      },
      (message) =>
          emit(state.copyWith(isSubmitting: false, successMessage: message)),
    );
  }

  void clearFeedback() {
    emit(
      state.copyWith(
        isSubmitting: state.isSubmitting,
        successMessage: null,
        errorMessage: null,
      ),
    );
  }
}
