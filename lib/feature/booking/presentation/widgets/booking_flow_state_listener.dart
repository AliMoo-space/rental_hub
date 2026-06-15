import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_hub/feature/booking/presentation/cubit/booking_action_cubit.dart';
import 'package:rental_hub/feature/booking/presentation/cubit/booking_action_state.dart';

/// Handles booking API side-effects outside the PageView.
class BookingFlowStateListener extends StatelessWidget {
  const BookingFlowStateListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookingActionCubit, BookingActionState>(
      listenWhen: (_, current) =>
          current is BookingActionSuccess || current is BookingActionFailure,
      listener: (context, state) {
        if (!context.mounted) return;

        final messenger = ScaffoldMessenger.of(context);

        if (state is BookingActionSuccess) {
          messenger.showSnackBar(
            SnackBar(content: Text(state.errMessage)),
          );
          Navigator.of(context).pop(true);
        } else if (state is BookingActionFailure) {
          messenger.showSnackBar(
            SnackBar(content: Text(state.errMessage)),
          );
        }
      },
      child: child,
    );
  }
}
