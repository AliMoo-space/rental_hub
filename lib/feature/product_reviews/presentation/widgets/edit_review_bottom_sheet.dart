import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/primary_button_widget.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/product_reviews/domain/entities/product_review_entity.dart';
import 'package:rental_hub/feature/product_reviews/presentation/cubit/product_review_cubit.dart';
import 'package:rental_hub/feature/product_reviews/presentation/cubit/product_review_state.dart';
import 'package:rental_hub/feature/product_reviews/presentation/widgets/star_selector_widget.dart';

class EditReviewBottomSheet extends StatefulWidget {
  final ProductReviewEntity review;
  final ProductReviewCubit cubit;

  const EditReviewBottomSheet({
    super.key,
    required this.review,
    required this.cubit,
  });

  @override
  State<EditReviewBottomSheet> createState() => _EditReviewBottomSheetState();
}

class _EditReviewBottomSheetState extends State<EditReviewBottomSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _commentController;
  late int _selectedScore;

  @override
  void initState() {
    super.initState();
    _selectedScore = widget.review.score;
    _commentController = TextEditingController(
      text: widget.review.comment ?? '',
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductReviewCubit, ProductReviewState>(
      bloc: widget.cubit,
      listener: (context, state) {
        if (state is UpdateReviewSuccess) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        final isSaving =
            state is UpdateReviewLoading &&
            state.actionReviewId == widget.review.id;

        return SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
              top: 16.h,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 48.w,
                      height: 5.h,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariantColor,
                        borderRadius: BorderRadius.circular(999.r),
                      ),
                    ),
                  ),
                  verticalSpacing(20),
                  Text(
                    'تعديل التقييم',
                    style: AppStyles.titleMedium.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  verticalSpacing(12),
                  StarSelectorWidget(
                    rating: _selectedScore.toDouble(),
                    onChanged: (value) =>
                        setState(() => _selectedScore = value),
                  ),
                  verticalSpacing(16),
                  TextFormField(
                    controller: _commentController,
                    maxLines: 4,
                    maxLength: 500,
                    decoration: InputDecoration(
                      hintText: 'اكتب تعليقك...',
                      filled: true,
                      fillColor: AppColors.surfaceColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.r),
                        borderSide: const BorderSide(
                          color: AppColors.borderColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.r),
                        borderSide: const BorderSide(
                          color: AppColors.borderColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.r),
                        borderSide: const BorderSide(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (_selectedScore < 1) {
                        return 'يرجى اختيار التقييم';
                      }
                      if ((value ?? '').trim().length > 500) {
                        return 'التعليق يجب ألا يتجاوز 500 حرف';
                      }
                      return null;
                    },
                  ),
                  verticalSpacing(6),
                  PrimaryButtonWidget(
                    buttonText: 'حفظ التعديل',
                    isLoading: isSaving,
                    onPress: () => _handleSave(context),
                    width: double.infinity,
                    height: 54.h,
                    bordersRadius: 18.r,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleSave(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    widget.cubit.updateReview(
      reviewId: widget.review.id,
      score: _selectedScore,
      comment: _commentController.text.trim().isEmpty
          ? null
          : _commentController.text.trim(),
    );
  }
}
