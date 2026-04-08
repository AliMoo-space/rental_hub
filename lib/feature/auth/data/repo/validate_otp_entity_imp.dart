import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/error_handling.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/auth/data/datasource/validate_otp_remote_data_source.dart';
import 'package:rental_hub/feature/auth/domain/entities/validate_otp_entity.dart';
import 'package:rental_hub/feature/auth/domain/entities/validate_otp_params.dart';
import 'package:rental_hub/feature/auth/domain/repo/validate_otp_repo.dart';

class ValidateOtpEntityImp implements ValidateOtpRepo {
  final ValidateOtpRemoteDataSource validateOtpRemoteDataSource;

  ValidateOtpEntityImp(this.validateOtpRemoteDataSource);
  @override
  Future<Either<Failure, ValidateOtpEntity>> validateOtp(
    ValidateOtpParams params,
  ) async {
    try {
      final result = await validateOtpRemoteDataSource.validateOtp(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(
        Failure(
          errMessage: e.errorModel.firstErrorMessage,
          statusCode: e.errorModel.statusCode,
        ),
      );
    } catch (e) {
      return Left(Failure(errMessage: 'Failed to validate OTP'));
    }
  }
}
