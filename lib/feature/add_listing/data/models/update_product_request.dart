import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rental_hub/core/utils/image_upload_utils.dart';

class UpdateProductRequest {
  final int categoryId;
  final int subcategoryId;
  final String locationArea;
  final String condition;
  final String productType;
  final String brand;
  final String rentalGuarantee;
  final String name;
  final String description;
  final num basePricePerDay;
  final String termsConditions;
  final String city;
  final String governorate;
  final List<XFile> newImages;
  final List<int> deletedImageIds;
  final int? primaryImageId;

  const UpdateProductRequest({
    required this.categoryId,
    required this.subcategoryId,
    required this.locationArea,
    required this.condition,
    required this.productType,
    required this.brand,
    required this.rentalGuarantee,
    required this.name,
    required this.description,
    required this.basePricePerDay,
    required this.termsConditions,
    required this.city,
    required this.governorate,
    required this.newImages,
    required this.deletedImageIds,
    this.primaryImageId,
  });

  Future<FormData> toFormData() async {
    final formData = FormData();

    formData.fields.addAll([
      MapEntry('CategoryId', categoryId.toString()),
      MapEntry('SubcategoryId', subcategoryId.toString()),
      MapEntry('LocationArea', locationArea.trim()),
      MapEntry('Condition', condition.trim()),
      MapEntry('ProductType', productType.trim()),
      MapEntry('Brand', brand.trim()),
      MapEntry('RentalGuarantee', rentalGuarantee.trim()),
      MapEntry('Name', name.trim()),
      MapEntry('Description', description.trim()),
      MapEntry('BasePricePerDay', basePricePerDay.toString()),
      MapEntry('TermsConditions', termsConditions.trim()),
      MapEntry('City', city.trim()),
      MapEntry('governorate', governorate.trim()),
    ]);

    if (primaryImageId != null) {
      formData.fields.add(
        MapEntry('PrimaryImageId', primaryImageId.toString()),
      );
    }

    for (final id in deletedImageIds) {
      formData.fields.add(MapEntry('DeletedImageIds', id.toString()));
    }

    if (newImages.isNotEmpty) {
      const logTag = 'ProductUpload';

      await ImageUploadUtils.logImagesBeforeUpload(newImages, logTag: logTag);

      final compressedFiles =
          await ImageUploadUtils.compressImagesToMultipartFiles(
            newImages,
            logTag: logTag,
          );

      for (final file in compressedFiles) {
        formData.files.add(MapEntry('NewImages', file));
      }
    }

    await ImageUploadUtils.logFormDataPayload(
      formData,
      logTag: 'ProductUpload',
    );

    return formData;
  }
}
