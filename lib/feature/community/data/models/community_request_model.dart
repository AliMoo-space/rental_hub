import 'package:rental_hub/core/models/paginated_response_model.dart';
import 'package:rental_hub/feature/community/domain/entities/community_request_entity.dart';
import 'package:rental_hub/core/databases/api/end_points.dart';

class CommunityRequestModel extends CommunityRequestEntity {
  const CommunityRequestModel({
    required super.id,
    required super.categoryId,
    required super.categoryName,
    required super.subcategoryId,
    required super.subcategoryName,
    required super.governorate,
    required super.city,
    required super.address,
    required super.title,
    required super.budget,
    super.startDate,
    super.endDate,
    required super.description,
    super.imageUrl,
    required super.userId,
    required super.userFullName,
    super.userImageUrl,
    required super.status,
    super.createdAt,
    super.offersCount,
  });

  factory CommunityRequestModel.fromJson(Map<String, dynamic> json) {
    return CommunityRequestModel(
      id: _parseInt(json['id']),
      categoryId: _parseInt(json['categoryId'] ?? json['CategoryId']),
      categoryName:
          json['categoryName']?.toString() ?? json['CategoryName']?.toString() ?? '',
      subcategoryId: _parseInt(json['subcategoryId'] ?? json['SubcategoryId']),
      subcategoryName:
          json['subcategoryName']?.toString() ??
          json['SubcategoryName']?.toString() ??
          '',
      governorate:
          json['governorate']?.toString() ?? json['Governorate']?.toString() ?? '',
      city: json['city']?.toString() ?? json['City']?.toString() ?? '',
      address: json['address']?.toString() ?? json['Address']?.toString() ?? '',
      title: json['title']?.toString() ?? json['Title']?.toString() ?? '',
      budget: _parseDouble(json['budget'] ?? json['Budget']),
      startDate: _parseDate(json['startDate'] ?? json['StartDate']),
      endDate: _parseDate(json['endDate'] ?? json['EndDate']),
      description:
          json['description']?.toString() ?? json['Description']?.toString() ?? '',
      imageUrl: _parseImageUrl(
          json['imageUrl']?.toString() ??
          json['image']?.toString() ??
          json['Image']?.toString()),
      userId: json['userId']?.toString() ?? json['UserId']?.toString() ?? '',
      userFullName:
          json['userFullName']?.toString() ??
          json['UserFullName']?.toString() ??
          json['ownerName']?.toString() ??
          '',
      userImageUrl: _parseImageUrl(
          json['userImageUrl']?.toString() ??
          json['userImage']?.toString() ??
          json['UserImage']?.toString()),
      status: json['status']?.toString() ?? json['Status']?.toString() ?? '',
      createdAt: _parseDate(json['createdAt'] ?? json['CreatedAt']),
      offersCount: _parseInt(json['offersCount'] ?? json['OffersCount']),
    );
  }

  static int _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static double _parseDouble(dynamic value) {
    if (value is double) return value;
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    return DateTime.tryParse(value.toString());
  }

  static String? _parseImageUrl(dynamic imageObj) {
    if (imageObj == null) return null;
    String url = imageObj.toString();
    if (url.isEmpty || url.toLowerCase() == 'null') return null;
    if (url.startsWith('http://') || url.startsWith('https://')) return url;
    if (!url.startsWith('/')) url = '/$url';
    return '${EndPoints.baseUrl}$url';
  }
}

class CommunityRequestsPageModel extends CommunityRequestsPageEntity {
  const CommunityRequestsPageModel({
    required super.items,
    required super.totalCount,
    required super.pageNumber,
    required super.pageSize,
    required super.totalPages,
    required super.hasPrevious,
    required super.hasNext,
  });

  factory CommunityRequestsPageModel.fromJson(Map<String, dynamic> json) {
    final page = PaginatedResponseModel<CommunityRequestModel>.fromJson(
      json,
      CommunityRequestModel.fromJson,
    );

    return CommunityRequestsPageModel(
      items: page.items,
      totalCount: page.totalCount,
      pageNumber: page.pageNumber,
      pageSize: page.pageSize,
      totalPages: page.totalPages,
      hasPrevious: page.hasPrevious,
      hasNext: page.hasNext,
    );
  }

  factory CommunityRequestsPageModel.fromList(List<dynamic> raw) {
    final items = raw
        .whereType<Map>()
        .map((item) => CommunityRequestModel.fromJson(Map<String, dynamic>.from(item)))
        .toList();

    return CommunityRequestsPageModel(
      items: items,
      totalCount: items.length,
      pageNumber: 1,
      pageSize: items.length,
      totalPages: 1,
      hasPrevious: false,
      hasNext: false,
    );
  }
}
