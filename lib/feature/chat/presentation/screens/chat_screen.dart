import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/feature/chat/presentation/cubit/chat_cubit.dart';
import 'package:rental_hub/feature/chat/presentation/cubit/chat_state.dart';
import 'package:rental_hub/feature/chat/presentation/models/chat_route_args.dart';
import 'package:rental_hub/feature/chat/presentation/widgets/chat_bubble_widget.dart';
import 'package:rental_hub/feature/chat/presentation/widgets/chat_input_bar_widget.dart';
import 'package:rental_hub/feature/chat/presentation/widgets/typing_indicator_widget.dart';

class ChatScreen extends StatefulWidget {
  final ChatRouteArgs routeArgs;

  const ChatScreen({super.key, required this.routeArgs});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<ChatCubit>().initialize(widget.routeArgs);
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (!_scrollController.hasClients) {
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listenWhen: (previous, current) =>
          previous.messages.length != current.messages.length ||
          previous.errorMessage != current.errorMessage ||
          previous.isTyping != current.isTyping ||
          previous.status != current.status,
      listener: (context, state) {
        if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }

        if (state.messages.isNotEmpty) {
          _scrollToBottom();
        }
      },
      builder: (context, state) {
        final conversation = state.conversation;
        final hasSellerName =
            conversation != null && conversation.sellerName.isNotEmpty;
        final fallbackSellerName = widget.routeArgs.sellerName.isNotEmpty
            ? widget.routeArgs.sellerName
            : context.l10n.chat;
        final title = hasSellerName
            ? conversation!.sellerName
            : fallbackSellerName;

        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: Row(
              children: [
                CircleAvatar(
                  radius: 18.r,
                  backgroundColor: AppColors.primarySoftColor,
                  backgroundImage:
                      ((conversation?.sellerAvatar.isNotEmpty ?? false))
                      ? NetworkImage(conversation!.sellerAvatar)
                      : null,
                  child: ((conversation?.sellerAvatar.isNotEmpty ?? false))
                      ? null
                      : Text(
                          title.isNotEmpty ? title[0].toUpperCase() : '?',
                          style: AppStyles.bodyMedium.copyWith(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(title, style: AppStyles.bodyLarge),
                      Text(
                        conversation?.isDraft == true
                            ? context.l10n.startConversation
                            : context.l10n.online,
                        style: AppStyles.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: state.status == ChatStatus.loading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Expanded(
                      child: state.messages.isEmpty
                          ? _EmptyMessagesView(
                              title: context.l10n.noMessagesYet,
                              subtitle: context.l10n.startConversationHint,
                            )
                          : ListView.builder(
                              controller: _scrollController,
                              padding: EdgeInsets.fromLTRB(
                                16.w,
                                16.h,
                                16.w,
                                8.h,
                              ),
                              itemCount: state.messages.length,
                              itemBuilder: (context, index) {
                                return ChatBubbleWidget(
                                  message: state.messages[index],
                                );
                              },
                            ),
                    ),
                    if (state.isTyping)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: TypingIndicatorWidget(
                          text: state.typingUserName?.isNotEmpty == true
                              ? '${state.typingUserName} ${context.l10n.typingIndicator}'
                              : context.l10n.typingIndicator,
                        ),
                      ),
                    ChatInputBarWidget(
                      controller: _messageController,
                      onChanged: (value) =>
                          context.read<ChatCubit>().handleTextChanged(value),
                      onSend: () {
                        final text = _messageController.text.trim();
                        if (text.isEmpty) {
                          return;
                        }
                        context.read<ChatCubit>().sendMessage(text);
                        _messageController.clear();
                      },
                      sendLabel: context.l10n.send,
                      hintText: context.l10n.typeMessage,
                      isSending: state.isSending,
                    ),
                  ],
                ),
        );
      },
    );
  }
}

class _EmptyMessagesView extends StatelessWidget {
  final String title;
  final String subtitle;

  const _EmptyMessagesView({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.message_outlined,
              size: 56.w,
              color: AppColors.primaryColor,
            ),
            SizedBox(height: 16.h),
            Text(
              title,
              style: AppStyles.titleMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              subtitle,
              style: AppStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
