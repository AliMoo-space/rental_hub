import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/error_handling.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/ai_chat/data/datasource/ai_remote_data_source.dart';
import 'package:rental_hub/feature/ai_chat/domain/entities/ai_chat_entity.dart';
import 'package:rental_hub/feature/ai_chat/domain/entities/ai_chat_params.dart';
import 'package:rental_hub/feature/ai_chat/domain/repo/ai_chat_repo.dart';

class AiChatRepoImpl implements AiChatRepo {
  final AiRemoteDataSource remoteDataSource;

  AiChatRepoImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, AiChatEntity>> sendMessage(AiChatParams params) async {
    try {
      final result = await remoteDataSource.sendMessage(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(
        Failure(
          statusCode: e.errorModel.statusCode,
          errMessage: e.errorModel.firstErrorMessage,
        ),
      );
    } catch (e) {
      return Left(Failure(errMessage: 'فشل إرسال الرسالة: ${e.toString()}'));
    }
  }
}
