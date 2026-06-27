import 'package:dio/dio.dart';
import 'package:rental_hub/feature/community/domain/entities/create_community_offer_params.dart';

class CreateCommunityOfferBody {
  final CreateCommunityOfferParams params;

  const CreateCommunityOfferBody(this.params);

  Future<FormData> toFormData() async {
    final formData = FormData();

    formData.fields.addAll([
      MapEntry('RequestId', params.requestId.toString()),
      MapEntry('ProposedPrice', params.proposedPrice.toString()),
      MapEntry('Message', params.message.trim()),
      MapEntry('Governorate', params.governorate.trim()),
      MapEntry('City', params.city.trim()),
      MapEntry('Address', params.address.trim()),
    ]);

    if (params.insuranceAmount != null) {
      formData.fields.add(
        MapEntry('InsuranceAmount', params.insuranceAmount.toString()),
      );
    }

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
