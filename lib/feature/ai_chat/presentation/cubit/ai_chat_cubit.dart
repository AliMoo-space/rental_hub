import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_hub/feature/ai_chat/domain/entities/ai_chat_params.dart';
import 'package:rental_hub/feature/ai_chat/domain/usecases/send_message_use_case.dart';
import 'package:rental_hub/feature/ai_chat/presentation/models/chat_message_model.dart';
import 'package:rental_hub/feature/ai_chat/presentation/models/product_preview.dart';

import 'ai_chat_state.dart';

class AiChatCubit extends Cubit<AiChatState> {
  final SendMessageUseCase sendMessageUseCase;

  AiChatCubit(this.sendMessageUseCase) : super(const AiChatState());

  Future<void> sendMessage(AiChatParams params) async {
    if (state.isSending) return;

    final userMessage = ChatMessageModel(
      text: params.query,
      isUser: true,
      timestamp: DateTime.now(),
    );

    emit(
      state.copyWith(
        messages: [...state.messages, userMessage],
        isSending: true,
        errorMessage: null,
      ),
    );

    final result = await sendMessageUseCase(params);

    result.fold(
      (failure) {
        emit(
          state.copyWith(isSending: false, errorMessage: failure.errMessage),
        );
      },
      (entity) {
        final imageUrls = (entity.products)
            .map((p) => p.imageUrl)
            .whereType<String>()
            .toList();

        final productPreviews = entity.products
            .map(
              (p) => ProductPreview(
                id: p.id,
                name: p.name,
                pricePerDay: p.pricePerDay,
                imageUrl: p.imageUrl,
                location: p.location,
                rentalGuarantee: p.rentalGuarantee,
                condition: p.condition,
              ),
            )
            .toList();

        final botMessage = ChatMessageModel(
          text: entity.answer.isNotEmpty
              ? entity.answer
              : 'لم أتمكن من توليد رد الآن، حاول مرة أخرى.',
          isUser: false,
          timestamp: DateTime.now(),
          imageUrls: imageUrls,
          products: productPreviews,
        );

        emit(
          state.copyWith(
            messages: [...state.messages, botMessage],
            isSending: false,
            errorMessage: null,
          ),
        );
      },
    );
  }
}
