import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/primary_button_widget.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/product_reviews/presentation/widgets/star_selector_widget.dart';

class AddReviewWidget extends StatefulWidget {
  final bool isLoading;
  final ValueChanged<ReviewInput> onSubmit;

  const AddReviewWidget({
    super.key,
    required this.isLoading,
    required this.onSubmit,
  });

  @override
  State<AddReviewWidget> createState() => _AddReviewWidgetState();
}

class _AddReviewWidgetState extends State<AddReviewWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _commentController = TextEditingController();
  int _selectedScore = 0;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'أضف تقييمك',
              style: AppStyles.bodyLarge.copyWith(fontWeight: FontWeight.w700),
            ),
            verticalSpacing(12),
            StarSelectorWidget(
              rating: _selectedScore.toDouble(),
              onChanged: (value) => setState(() => _selectedScore = value),
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
                  borderSide: const BorderSide(color: AppColors.borderColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.r),
                  borderSide: const BorderSide(color: AppColors.borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.r),
                  borderSide: const BorderSide(color: AppColors.primaryColor),
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
              buttonText: 'إرسال التقييم',
              isLoading: widget.isLoading,
              onPress: _handleSubmit,
              width: double.infinity,
              height: 54.h,
              bordersRadius: 18.r,
            ),
          ],
        ),
      ),
    );
  }

  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    widget.onSubmit(
      ReviewInput(
        score: _selectedScore,
        comment: _commentController.text.trim().isEmpty
            ? null
            : _commentController.text.trim(),
      ),
    );
  }
}

class ReviewInput {
  final int score;
  final String? comment;

  const ReviewInput({required this.score, this.comment});
}
