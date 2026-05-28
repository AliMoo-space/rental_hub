import 'package:equatable/equatable.dart';

class WalletActionResultEntity extends Equatable {
  final String message;

  const WalletActionResultEntity({required this.message});

  @override
  List<Object> get props => [message];
}
