import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/error_handling.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/auth/data/datasource/validate_otp_remote_data_source.dart';
import 'package:rental_hub/feature/auth/domain/entities/validate_otp_entity.dart';
import 'package:rental_hub/feature/auth/domain/entities/validate_otp_params.dart';
import 'package:rental_hub/feature/auth/domain/repo/validate_otp_repo.dart';

class OtpRepositoryImpl implements OtpRepository {
  final OtpRemoteDataSource otpRemoteDataSource;

  OtpRepositoryImpl(this.otpRemoteDataSource);
  @override
  Future<Either<Failure, OtpEntity>> verifyOtp(OtpParams params) async {
    try {
      final result = await otpRemoteDataSource.verifyOtp(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(
        Failure(
          errMessage: e.errorModel.firstErrorMessage,
          statusCode: e.errorModel.statusCode,
        ),
      );
    } catch (e) {
      return Left(Failure(errMessage: 'Failed to verify OTP'));
    }
  }

  @override
  Future<Either<Failure, OtpEntity>> resendOtp(String email) async {
    try {
      final result = await otpRemoteDataSource.resendOtp(email);
      return Right(result);
    } on ServerException catch (e) {
      return Left(
        Failure(
          errMessage: e.errorModel.firstErrorMessage,
          statusCode: e.errorModel.statusCode,
        ),
      );
    } catch (e) {
      return Left(Failure(errMessage: 'Failed to resend OTP'));
    }
  }
}
