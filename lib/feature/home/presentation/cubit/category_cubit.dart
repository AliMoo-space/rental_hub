import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:rental_hub/feature/home/domain/entities/category_entity.dart';
import 'package:rental_hub/feature/home/domain/usecases/get_category.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final GetCategory _getCategory;

  CategoryCubit(this._getCategory) : super(CategoryInitial());

  Future<void> fetchCategories() async {
    emit(CategoryLoading());
    final result = await _getCategory();
    result.fold(
      (failure) => emit(CategoryError(message: failure.errMessage)),
      (categories) => emit(CategoryLoaded(categories)),
    );
  }
}
