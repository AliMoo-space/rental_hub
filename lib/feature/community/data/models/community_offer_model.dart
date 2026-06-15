import 'package:rental_hub/feature/community/domain/entities/community_offer_entity.dart';
import 'package:rental_hub/core/databases/api/end_points.dart';

class CommunityOfferModel extends CommunityOfferEntity {
  const CommunityOfferModel({
    required super.id,
    required super.requestId,
    super.requestTitle,
    required super.proposedPrice,
    required super.message,
    super.imageUrl,
    required super.governorate,
    required super.city,
    required super.address,
    required super.offererId,
    required super.offererName,
    super.offererImageUrl,
    required super.status,
    super.createdAt,
  });

  factory CommunityOfferModel.fromJson(Map<String, dynamic> json) {
    return CommunityOfferModel(
      id: _parseInt(json['id']),
      requestId: _parseInt(json['requestId'] ?? json['RequestId']),
      requestTitle:
          json['requestTitle']?.toString() ?? json['RequestTitle']?.toString(),
      proposedPrice: _parseDouble(json['proposedPrice'] ?? json['ProposedPrice']),
      message: json['message']?.toString() ?? json['Message']?.toString() ?? '',
      imageUrl: _parseImageUrl(
          json['imageUrl']?.toString() ??
          json['image']?.toString() ??
          json['Image']?.toString()),
      governorate:
          json['governorate']?.toString() ?? json['Governorate']?.toString() ?? '',
      city: json['city']?.toString() ?? json['City']?.toString() ?? '',
      address: json['address']?.toString() ?? json['Address']?.toString() ?? '',
      offererId:
          json['offererId']?.toString() ??
          json['userId']?.toString() ??
          json['UserId']?.toString() ??
          '',
      offererName:
          json['offererName']?.toString() ??
          json['userFullName']?.toString() ??
          json['UserFullName']?.toString() ??
          '',
      offererImageUrl: _parseImageUrl(
          json['offererImageUrl']?.toString() ??
          json['userImageUrl']?.toString() ??
          json['UserImage']?.toString()),
      status: json['status']?.toString() ?? json['Status']?.toString() ?? '',
      createdAt: _parseDate(json['createdAt'] ?? json['CreatedAt']),
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

class CommunityOffersPageModel extends CommunityOffersPageEntity {
  const CommunityOffersPageModel({required super.items});

  factory CommunityOffersPageModel.fromJson(dynamic raw) {
    if (raw is List) {
      final items = raw
          .whereType<Map>()
          .map((item) => CommunityOfferModel.fromJson(Map<String, dynamic>.from(item)))
          .toList();
      return CommunityOffersPageModel(items: items);
    }

    if (raw is Map<String, dynamic>) {
      final itemsValue = raw['items'] as List? ?? const [];
      final items = itemsValue
          .whereType<Map>()
          .map((item) => CommunityOfferModel.fromJson(Map<String, dynamic>.from(item)))
          .toList();
      return CommunityOffersPageModel(items: items);
    }

    return const CommunityOffersPageModel(items: []);
  }
}
