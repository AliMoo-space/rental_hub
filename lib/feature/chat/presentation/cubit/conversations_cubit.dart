import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rental_hub/feature/chat/domain/entities/conversation_entity.dart';
import 'package:rental_hub/feature/chat/domain/usecases/get_conversations_usecase.dart';

part 'conversations_state.dart';

class ConversationsCubit extends Cubit<ConversationsState> {
  final GetConversationsUseCase getConversationsUseCase;

  ConversationsCubit(this.getConversationsUseCase)
      : super(const ConversationsState());

  Future<void> loadConversations() async {
    emit(state.copyWith(status: ConversationsStatus.loading, errorMessage: null));

    final result = await getConversationsUseCase();

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: ConversationsStatus.error,
            errorMessage: failure.errMessage,
          ),
        );
      },
      (conversations) {
        emit(
          state.copyWith(
            status: conversations.isEmpty
                ? ConversationsStatus.empty
                : ConversationsStatus.loaded,
            conversations: conversations,
            errorMessage: null,
          ),
        );
      },
    );
  }

  Future<void> refresh() => loadConversations();
}import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rental_hub/feature/chat/domain/entities/conversation_entity.dart';
import 'package:rental_hub/feature/chat/domain/usecases/get_conversations_usecase.dart';

part 'conversations_state.dart';

class ConversationsCubit extends Cubit<ConversationsState> {
  final GetConversationsUseCase getConversationsUseCase;

  ConversationsCubit(this.getConversationsUseCase)
      : super(const ConversationsState());

  Future<void> loadConversations() async {
    emit(state.copyWith(status: ConversationsStatus.loading, errorMessage: null));

    final result = await getConversationsUseCase();

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: ConversationsStatus.error,
            errorMessage: failure.errMessage,
          ),
        );
      },
      (conversations) {
        emit(
          state.copyWith(
            status: conversations.isEmpty
                ? ConversationsStatus.empty
                : ConversationsStatus.loaded,
            conversations: conversations,
            errorMessage: null,
          ),
        );
      },
    );
  }

  Future<void> refresh() => loadConversations();
}