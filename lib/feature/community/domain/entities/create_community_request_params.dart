import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class CreateCommunityRequestParams extends Equatable {
  final int categoryId;
  final int subcategoryId;
  final String governorate;
  final String city;
  final String address;
  final String title;
  final double budget;
  final DateTime startDate;
  final DateTime endDate;
  final String description;
  final XFile? image;

  const CreateCommunityRequestParams({
    required this.categoryId,
    required this.subcategoryId,
    required this.governorate,
    required this.city,
    required this.address,
    required this.title,
    required this.budget,
    required this.startDate,
    required this.endDate,
    required this.description,
    this.image,
  });

  @override
  List<Object?> get props => [
    categoryId,
    subcategoryId,
    governorate,
    city,
    address,
    title,
    budget,
    startDate,
    endDate,
    description,
    image,
  ];
}
