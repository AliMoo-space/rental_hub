import 'package:rental_hub/feature/auth/domain/entities/sign_up_entity.dart';

class SignUpModel {
  final String message;
  final String userId;
  final String status;

  const SignUpModel({
    required this.message,
    required this.userId,
    required this.status,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    // Expected response shape:
    // {
    //   "message": "...",
    //   "userId": "...",
    //   "status": "..."
    // }

    final message = (json['message'] ?? '').toString();
    final userId = (json['userId'] ?? json['id'] ?? '').toString();
    final status = (json['status'] ?? '').toString();

    return SignUpModel(message: message, userId: userId, status: status);
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'userId': userId,
    'status': status,
  };

  SignUpEntity toEntity() =>
      SignUpEntity(message: message, email: '', fullName: '', userId: userId);
}
