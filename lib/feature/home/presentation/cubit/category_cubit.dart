import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:rental_hub/feature/home/domain/entities/category_entity.dart';
import 'package:rental_hub/feature/home/domain/repo/category_repo.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepo _repo;

  CategoryCubit(this._repo) : super(CategoryInitial());

  Future<void> fetchCategories() async {
    emit(CategoryLoading());
    final result = await _repo.getCategories();
    result.fold(
      (failure) {
        final errorMsg = failure.errMessage;
        print('Cubit Error: $errorMsg');
        emit(CategoryError(message: errorMsg));
      },
      (categories) {
        print('Cubit Loaded: ${categories.length} categories');
        emit(CategoryLoaded(categories));
      },
    );
  }
}
