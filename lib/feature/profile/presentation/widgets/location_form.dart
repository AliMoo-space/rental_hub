import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
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
          title: context.l10n.city,
          hintText: context.l10n.city,
          controller: cityController,
          validator: (value) {
            if ((value ?? '').trim().isEmpty) {
              return context.l10n.cityRequired;
            }
            return null;
          },
        ),
        SizedBox(height: 16.h),
        CustomTextField(
          title: context.l10n.governorate,
          hintText: context.l10n.governorate,
          controller: governorateController,
          validator: (value) {
            if ((value ?? '').trim().isEmpty) {
              return context.l10n.governorateRequired;
            }
            return null;
          },
        ),
        SizedBox(height: 16.h),
        CustomTextField(
          title: context.l10n.country,
          hintText: context.l10n.country,
          controller: countryController,
          validator: (value) {
            if ((value ?? '').trim().isEmpty) {
              return context.l10n.countryRequired;
            }
            return null;
          },
        ),
      ],
    );
  }
}
