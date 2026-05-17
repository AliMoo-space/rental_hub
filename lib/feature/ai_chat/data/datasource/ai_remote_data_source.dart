import 'package:rental_hub/core/databases/api/api_consumer.dart';
import 'package:rental_hub/core/databases/api/end_points.dart';
import 'package:rental_hub/core/utils/response_parser.dart';
import 'package:rental_hub/feature/ai_chat/data/models/ai_chat_model.dart';
import 'package:rental_hub/feature/ai_chat/domain/entities/ai_chat_params.dart';

abstract class AiRemoteDataSource {
  Future<AiChatModel> sendMessage(AiChatParams params);
}

class AiRemoteDataSourceImpl implements AiRemoteDataSource {
  final ApiConsumer apiConsumer;

  AiRemoteDataSourceImpl(this.apiConsumer);
  @override
  Future<AiChatModel> sendMessage(AiChatParams params) async {
    final response = await apiConsumer.post(
      '${EndPoints.aiBaseUrl}${EndPoints.chatEndpoint}',
      data: {
        "query": params.query,
        "session_id": params.sessionId,
        "user_id": params.userId,
        "auth_token": params.authToken,
      },
    );
    final payload = ResponseParser.extractDataPayload(response.data);
    return AiChatModel.fromJson(payload);
  }
}
