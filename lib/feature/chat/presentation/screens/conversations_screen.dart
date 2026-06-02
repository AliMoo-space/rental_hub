import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/routing/app_routes.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/feature/chat/presentation/cubit/conversations_cubit.dart';
import 'package:rental_hub/feature/chat/presentation/cubit/conversations_state.dart';
import 'package:rental_hub/feature/chat/presentation/models/chat_route_args.dart';
import 'package:rental_hub/feature/chat/presentation/widgets/conversation_tile_widget.dart';

class ConversationsScreen extends StatelessWidget {
  const ConversationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.conversations, style: AppStyles.titleMedium),
        centerTitle: false,
      ),
      body: BlocConsumer<ConversationsCubit, ConversationsState>(
        listenWhen: (previous, current) =>
            previous.errorMessage != current.errorMessage,
        listener: (context, state) {
          if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        builder: (context, state) {
          if (state.status == ConversationsStatus.loading ||
              state.status == ConversationsStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == ConversationsStatus.empty) {
            return _EmptyConversationsView(
              title: context.l10n.noConversationsYet,
              subtitle: context.l10n.startConversationHint,
            );
          }

          if (state.status == ConversationsStatus.error &&
              state.conversations.isEmpty) {
            return _EmptyConversationsView(
              title: context.l10n.failedToLoadConversations,
              subtitle: context.l10n.startConversationHint,
            );
          }

          return RefreshIndicator(
            onRefresh: () => context.read<ConversationsCubit>().refresh(),
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              itemBuilder: (context, index) {
                final conversation = state.conversations[index];
                return ConversationTileWidget(
                  conversation: conversation,
                  onTap: () {
                    context.pushNamed(
                      AppRoutes.chatScreen,
                      extra: ChatRouteArgs(
                        conversationId: conversation.id,
                        sellerId: conversation.sellerId,
                        sellerName: conversation.sellerName,
                        sellerAvatar: conversation.sellerAvatar,
                        productId: conversation.productId,
                        productName: conversation.productName,
                      ),
                    );
                  },
                );
              },
              separatorBuilder: (_, __) => SizedBox(height: 12.h),
              itemCount: state.conversations.length,
            ),
          );
        },
      ),
    );
  }
}

class _EmptyConversationsView extends StatelessWidget {
  final String title;
  final String subtitle;

  const _EmptyConversationsView({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline_rounded,
              size: 56.w,
              color: AppColors.primaryColor,
            ),
            SizedBox(height: 16.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppStyles.titleMedium,
            ),
            SizedBox(height: 8.h),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: AppStyles.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
