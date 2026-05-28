import 'package:equatable/equatable.dart';
import 'package:rental_hub/feature/home/domain/entities/category_entity.dart';

class AddListingState extends Equatable {
  final bool isCategoriesLoading;
  final bool isSubcategoriesLoading;
  final bool isSubmitting;
  final List<SubCategoryEntity> categories;
  final List<SubCategoryEntity> subcategories;
  final String? successMessage;
  final String? errorMessage;

  const AddListingState({
    this.isCategoriesLoading = false,
    this.isSubcategoriesLoading = false,
    this.isSubmitting = false,
    this.categories = const [],
    this.subcategories = const [],
    this.successMessage,
    this.errorMessage,
  });

  AddListingState copyWith({
    bool? isCategoriesLoading,
    bool? isSubcategoriesLoading,
    bool? isSubmitting,
    List<SubCategoryEntity>? categories,
    List<SubCategoryEntity>? subcategories,
    String? successMessage,
    String? errorMessage,
  }) {
    return AddListingState(
      isCategoriesLoading: isCategoriesLoading ?? this.isCategoriesLoading,
      isSubcategoriesLoading:
          isSubcategoriesLoading ?? this.isSubcategoriesLoading,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      categories: categories ?? this.categories,
      subcategories: subcategories ?? this.subcategories,
      successMessage: successMessage,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    isCategoriesLoading,
    isSubcategoriesLoading,
    isSubmitting,
    categories,
    subcategories,
    successMessage,
    errorMessage,
  ];
}
