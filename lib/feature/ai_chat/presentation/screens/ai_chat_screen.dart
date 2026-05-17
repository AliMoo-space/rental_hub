import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/utils/service_locator.dart';
import 'package:rental_hub/core/databases/cache/token_storage_helper.dart';
import 'package:rental_hub/core/styling/app_assets.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/feature/ai_chat/domain/entities/ai_chat_params.dart';
import 'package:rental_hub/feature/ai_chat/presentation/cubit/ai_chat_cubit.dart';
import 'package:rental_hub/feature/ai_chat/presentation/cubit/ai_chat_state.dart';
import 'package:rental_hub/feature/ai_chat/presentation/widgets/chat_input_field.dart';
import 'package:rental_hub/feature/ai_chat/presentation/widgets/chat_message_widget.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final messageController = TextEditingController();
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AiChatCubit>(),
      child: BlocConsumer<AiChatCubit, AiChatState>(
        listenWhen: (previous, current) =>
            previous.messages.length != current.messages.length ||
            previous.errorMessage != current.errorMessage,
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }

          if (state.messages.isNotEmpty) {
            _scrollToBottom();
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('RentalHub AI'),
              centerTitle: true,
            ),
            body: state.messages.isEmpty
                ? Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppAssets.bot,
                            width: 150.w,
                            height: 150.w,
                          ),
                          SizedBox(height: 24.h),
                          Text(
                            'أهلاً بك في RentalHub AI',
                            style: AppStyles.hendi500Size20.copyWith(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: const Text(
                              textAlign: TextAlign.center,
                              'أنا هنا لمساعدتك في رحلة التأجير الخاصة بك. اسألني عن أي شيء!',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.all(16.h),
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final message = state.messages[index];
                      return ChatMessageWidget(message: message);
                    },
                  ),
            bottomNavigationBar: ChatInputField(
              controller: messageController,
              onSend: () => _handleSendMessage(context),
              isLoading: state.isSending,
            ),
          );
        },
      ),
    );
  }

  Future<void> _handleSendMessage(BuildContext blocContext) async {
    final message = messageController.text.trim();
    if (message.isEmpty) return;

    final token = await getIt<TokenStorageHelper>().getAccessToken() ?? '';
    final params = AiChatParams(
      query: message,
      sessionId: '',
      userId: '',
      authToken: token,
    );

    if (mounted) {
      blocContext.read<AiChatCubit>().sendMessage(params);
    }
    messageController.clear();
  }
}
