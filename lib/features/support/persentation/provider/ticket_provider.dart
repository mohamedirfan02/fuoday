import 'package:flutter/material.dart';
import 'package:fuoday/commons/widgets/k_snack_bar.dart';
import 'package:fuoday/features/support/domain/entities/ticket_entity.dart';
import 'package:fuoday/features/support/domain/usecase/create_ticket_usecase.dart';

class TicketProvider with ChangeNotifier {
  final CreateTicketUseCase useCase;
  TicketProvider(this.useCase);

  Future<void> submitTicket(Ticket ticket, BuildContext context) async {
    try {
      await useCase(ticket);
      KSnackBar.success(context, '✅ Ticket created successfully');

      Navigator.of(context).pop(); // Close bottom sheet
    } catch (e) {
      KSnackBar.failure(context, '❌ Failed to create ticket');
    }
  }
}
