import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
	final String token;
	final String refreshToken;
	final DateTime expiration;
	final String userId;
	final String email;
	final String fullName;
	final String role;

	const LoginEntity({
		required this.token,
		required this.refreshToken,
		required this.expiration,
		required this.userId,
		required this.email,
		required this.fullName,
		required this.role,
	});

	@override
	List<Object?> get props => [
				token,
				refreshToken,
				expiration,
				userId,
				email,
				fullName,
				role,
			];
}



