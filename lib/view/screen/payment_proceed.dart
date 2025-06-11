import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zesta_1/constant/color.dart';
import 'package:zesta_1/model/event_model.dart';
import 'package:zesta_1/services/stripe_controller.dart';
import 'package:zesta_1/services/ticket_controller.dart';
import 'package:zesta_1/view/widget/payment/order_summary.dart';
import 'package:zesta_1/view/widget/payment/payment_event_details.dart';
import 'package:zesta_1/view/widget/payment/ticket_dialog.dart';
import 'package:zesta_1/view/widget/payment/ticket_selection.dart';

class BookingPage extends StatelessWidget {
  final EventModel event;
  final ticketController = Get.put(TicketController());
  BookingPage({super.key, required this.event});

  final RxInt ticketCount = 1.obs;

  String formatEventDate(String? dateStr) {
    if (dateStr == null) return 'Date TBA';
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('MMM d yyyy').format(date);
    } catch (e) {
      return dateStr;
    }
  }

  String formatEventTime(String? timeStr) {
    if (timeStr == null) return 'N/A';
    try {
      final time = DateTime.parse(timeStr);
      return DateFormat('h:mm a').format(time);
    } catch (e) {
      return timeStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double price = event.ticketPrice ?? 0.0;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Book Tickets'),
        backgroundColor: AppColors.second,
        foregroundColor: AppColors.textlight,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          EventDetailsCard(
            event: event,
            formatDate: formatEventDate,
            formatTime: formatEventTime,
          ),
          SizedBox(height: 20),
          TicketSelectionCard(ticketCount: ticketCount, price: price),
          SizedBox(height: 20),
          OrderSummaryCard(ticketCount: ticketCount, price: price),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () async {
              final controller = Get.find<PaymentController>();
              double totalAmount = ticketCount.value * price;

              try {
                final paymentIntent = await controller.makePayment(totalAmount);
                if (paymentIntent != null) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => TicketDialog(
                      eventName: event.name ?? '',
                      eventDate: formatEventDate(event.date),
                      eventTime: formatEventTime(event.startTime),
                      eventLocation: event.city ?? '',
                      ticketCount: ticketCount.value,
                      amountPaid: totalAmount,
                    ),
                  );
                }
              } catch (e) {
                Get.snackbar(
                    'Payment Failed', 'Something went wrong. Try again.');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'PROCEED TO PAYMENT',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: AppColors.textlight),
            ),
          ),
          SizedBox(height: 16),
         Text(
            "Note:\n- No refund will be provided after cancellation.\n- Each user can purchase a maximum of 10 tickets. Ticket quantity cannot be increased beyond 10 per user.",
            style: TextStyle(
              color: AppColors.textaddn,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
