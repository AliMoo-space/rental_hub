import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final String accessToken;
  final DateTime expiresAtUtc;
  final String refreshToken;

  const LoginEntity({
    required this.accessToken,
    required this.expiresAtUtc,
    required this.refreshToken,
  });

  @override
  List<Object?> get props => [
    accessToken,
    expiresAtUtc,
    refreshToken,
  ];
}
