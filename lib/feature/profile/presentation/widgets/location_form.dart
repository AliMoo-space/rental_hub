import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/widgets/custom_text_field.dart';

class LocationForm extends StatelessWidget {
  final TextEditingController cityController;
  final TextEditingController governorateController;
  final TextEditingController countryController;

  const LocationForm({
    super.key,
    required this.cityController,
    required this.governorateController,
    required this.countryController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          title: 'المدينة',
          hintText: 'المدينة',
          controller: cityController,
          validator: (value) {
            if ((value ?? '').trim().isEmpty) {
              return 'المدينة مطلوبة';
            }
            return null;
          },
        ),
        SizedBox(height: 16.h),
        CustomTextField(
          title: 'المحافظة',
          hintText: 'المحافظة',
          controller: governorateController,
          validator: (value) {
            if ((value ?? '').trim().isEmpty) {
              return 'المحافظة مطلوبة';
            }
            return null;
          },
        ),
        SizedBox(height: 16.h),
        CustomTextField(
          title: 'الدولة',
          hintText: 'الدولة',
          controller: countryController,
          validator: (value) {
            if ((value ?? '').trim().isEmpty) {
              return 'الدولة مطلوبة';
            }
            return null;
          },
        ),
      ],
    );
  }
}
