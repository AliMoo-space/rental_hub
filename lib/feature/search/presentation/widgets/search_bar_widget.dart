import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/widgets/custom_text_field.dart';
import 'package:rental_hub/core/widgets/loading_widget.dart';
import 'package:rental_hub/feature/search/presentation/cubit/search_cubit.dart';
import 'package:rental_hub/feature/search/presentation/cubit/search_state.dart';

class SearchBarWidget extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSubmit;
  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onSubmit,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BlocBuilder<SearchCubit, SearchState>(
            builder: (context, searchState) {
              return ValueListenableBuilder<TextEditingValue>(
                valueListenable: widget.controller,
                builder: (context, value, _) {
                  final hasText = value.text.trim().isNotEmpty;
                  final isLoading = searchState is LiveSearchLoading;
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.surfaceColor,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: AppColors.borderColor),
                    ),
                    child: CustomTextField(
                      controller: widget.controller,
                      hintText: 'ابحث عن منتج...',
                      autofocus: true,
                      onChanged: (v) =>
                          context.read<SearchCubit>().onQueryChanged(v),
                      onFieldSubmitted: (v) => widget.onSubmit(),
                      suffixIcon: isLoading
                          ? SizedBox(
                              height: 20.w,
                              child: LoadingWidget(width: 12.w),
                            )
                          : hasText
                          ? IconButton(
                              icon: Icon(
                                Icons.clear_rounded,
                                color: AppColors.textSecondary,
                                size: 20.sp,
                              ),
                              onPressed: () {
                                widget.controller.clear();
                                context.read<SearchCubit>().onQueryChanged('');
                              },
                            )
                          : Icon(
                              Icons.search_rounded,
                              color: AppColors.primaryColor,
                              size: 22.sp,
                            ),
                    ),
                  );
                },
              );
            },
          ),
        ),

        // SizedBox(width: 10.w),
        // Material(
        //   color: AppColors.primaryColor,
        //   borderRadius: BorderRadius.circular(18.r),
        //   child: InkWell(
        //     borderRadius: BorderRadius.circular(18.r),
        //     onTap: widget.onSubmit,
        //     child: Container(
        //       width: 54.w,
        //       height: 54.w,
        //       alignment: Alignment.center,
        //       child: Icon(
        //         Icons.tune_rounded,
        //         color: Colors.white,
        //         size: 22.sp,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
