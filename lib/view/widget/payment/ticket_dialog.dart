

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zesta_1/model/ticket_model.dart';
import 'package:zesta_1/services/ticket_controller.dart';
import 'package:zesta_1/view/screen/ticket_screen.dart';


class TicketDialog extends StatelessWidget {
  final String eventName;
  final String eventDate;
  final String eventTime;
  final String eventLocation;
  final int ticketCount;
  final double amountPaid;

  const TicketDialog({
    super.key,
    required this.eventName,
    required this.eventDate,
    required this.eventTime,
    required this.eventLocation,
    required this.ticketCount,
    required this.amountPaid,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(" Ticket Confirmed", textAlign: TextAlign.center),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(),
          Text(eventName, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text("$eventDate | $eventTime"),
          Text(eventLocation),
          SizedBox(height: 12),
          Text("Tickets: $ticketCount"),
          Text("Paid: ₹${amountPaid.toStringAsFixed(2)}"),
          SizedBox(height: 16),
          BarcodeWidget(
            barcode: Barcode.qrCode(),
            data:
                '$eventName-$ticketCount-${DateTime.now().millisecondsSinceEpoch}',
            width: 70,
            height: 70,
          ),
          SizedBox(height: 20),
          ElevatedButton(
  onPressed: () async {
    final ticket = Ticket(
      eventName: eventName,
      eventDate: eventDate,
      eventTime: eventTime,
      eventLocation: eventLocation,
      ticketCount: ticketCount,
      amountPaid: amountPaid,
      barcode: '$eventName-$ticketCount-${DateTime.now().millisecondsSinceEpoch}',
    );
    final ticketController = Get.put(TicketController());
    await ticketController.saveTicket(ticket);
    Get.back();
    Get.off(() => TicketScreen());
  },
  child: Text('Save Tickets'),
)

        ],
      ),
    );
  }
}
