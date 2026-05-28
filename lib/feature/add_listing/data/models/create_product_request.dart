import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class CreateProductRequest {
  final String city;
  final String governorate;
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
  final List<XFile> images;

  const CreateProductRequest({
    required this.city,
    required this.governorate,
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
    required this.images,
  });

  Future<FormData> toFormData() async {
    final formData = FormData();

    formData.fields.addAll([
      MapEntry('City', city.trim()),
      MapEntry('governorate', governorate.trim()),
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
    ]);

    for (final image in images) {
      formData.files.add(
        MapEntry(
          'Images',
          await MultipartFile.fromFile(image.path, filename: image.name),
        ),
      );
    }

    return formData;
  }
}
