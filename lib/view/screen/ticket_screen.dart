import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:zesta_1/services/ticket_controller.dart';

class TicketScreen extends StatelessWidget {
  const TicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TicketController ticketController = Get.put(TicketController());

    return Scaffold(
      appBar: AppBar(title: Text('Your Tickets')),
      body: FutureBuilder(
        future: ticketController.fetchAllTickets(),
        builder: (context, snapshot) {
          return Obx(() {
  final tickets = ticketController.tickets;

  // Sort tickets by eventDate (latest first)
  final sortedTickets = List.of(tickets);
  sortedTickets.sort((a, b) {
    // If eventDate is a String in 'yyyy-MM-dd' or ISO format
    final aDate = DateTime.tryParse(a.eventDate) ?? DateTime(2000);
    final bDate = DateTime.tryParse(b.eventDate) ?? DateTime(2000);
    return bDate.compareTo(aDate); // Descending: latest first
  });

  if (sortedTickets.isEmpty) {
    return Center(child: Text('Ticket Loading'));
  }
  return ListView.builder(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
    itemCount: sortedTickets.length,
    itemBuilder: (context, index) {
      final ticket = sortedTickets[index];
      return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Align(
          alignment: Alignment.topLeft,
          child: TicketWidget(
            width: MediaQuery.of(context).size.width * 0.95,
            height: 220,
            isCornerRounded: true,
            padding: EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ticket.eventName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "${ticket.eventDate} | ${ticket.eventTime}",
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                Text(
                  ticket.eventLocation,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.confirmation_number, size: 18, color: Colors.blueGrey),
                    SizedBox(width: 6),
                    Text("Tickets: ${ticket.ticketCount}", style: TextStyle(fontSize: 15)),
                    SizedBox(width: 16),
                    Icon(Icons.attach_money, size: 18, color: Colors.green),
                    SizedBox(width: 4),
                    Text("Paid: ₹${ticket.amountPaid.toStringAsFixed(2)}", style: TextStyle(fontSize: 15)),
                  ],
                ),
                Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: BarcodeWidget(
                    barcode: Barcode.qrCode(),
                    data: ticket.barcode,
                    width: 80,
                    height: 80,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
});
        }
      ),
    );
  }
}
