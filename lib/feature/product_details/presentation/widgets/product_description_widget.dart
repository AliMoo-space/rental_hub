import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/home/domain/entities/product_entity.dart';

/// Product description section with expand/collapse
class ProductDescriptionWidget extends StatefulWidget {
  final ProductEntity product;
  final int maxLines;

  const ProductDescriptionWidget({
    super.key,
    this.maxLines = 3,
    required this.product,
  });

  @override
  State<ProductDescriptionWidget> createState() =>
      _ProductDescriptionWidgetState();
}

class _ProductDescriptionWidgetState extends State<ProductDescriptionWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'الوصف',
            style: AppStyles.bodyLarge.copyWith(fontWeight: FontWeight.w700),
          ),
          verticalSpacing(12),
          Text(
            ' ${widget.product.description}',
            maxLines: _isExpanded ? null : widget.maxLines,
            overflow: _isExpanded
                ? TextOverflow.visible
                : TextOverflow.ellipsis,
            style: AppStyles.bodyMedium.copyWith(
              color: AppColors.textSecondaryColor,
              height: 1.6,
            ),
          ),
          if (widget.product.description.split('\n').length >
              widget.maxLines) ...[
            verticalSpacing(8),
            GestureDetector(
              onTap: () => setState(() => _isExpanded = !_isExpanded),
              child: Text(
                _isExpanded ? 'اخفاء' : 'عرض المزيد',
                style: AppStyles.bodyMedium.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
