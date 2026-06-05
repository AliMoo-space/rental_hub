import 'package:dio/dio.dart';
import 'package:rental_hub/feature/community/domain/entities/create_community_request_params.dart';

class CreateCommunityRequestBody {
  final CreateCommunityRequestParams params;

  const CreateCommunityRequestBody(this.params);

  Future<FormData> toFormData() async {
    final formData = FormData();

    formData.fields.addAll([
      MapEntry('CategoryId', params.categoryId.toString()),
      MapEntry('SubcategoryId', params.subcategoryId.toString()),
      MapEntry('Governorate', params.governorate.trim()),
      MapEntry('City', params.city.trim()),
      MapEntry('Address', params.address.trim()),
      MapEntry('Title', params.title.trim()),
      MapEntry('Budget', params.budget.toString()),
      MapEntry('StartDate', params.startDate.toIso8601String()),
      MapEntry('EndDate', params.endDate.toIso8601String()),
      MapEntry('Description', params.description.trim()),
    ]);

    final image = params.image;
    if (image != null) {
      formData.files.add(
        MapEntry(
          'Image',
          await MultipartFile.fromFile(image.path, filename: image.name),
        ),
      );
    }

    return formData;
  }
}
