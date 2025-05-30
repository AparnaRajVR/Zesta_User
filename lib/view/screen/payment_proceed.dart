

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zesta_1/constant/color.dart';
import 'package:zesta_1/model/event_model.dart';
import 'package:zesta_1/services/stripe_controller.dart';
import 'package:zesta_1/view/widget/payment/ticket_dialog.dart';

class BookingPage extends StatelessWidget {
  final EventModel event;
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
          // Event Details Card
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.name ?? 'Event Name',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.second),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: AppColors.primary, size: 16),
                      SizedBox(width: 4),
                      Text(event.city ?? 'Location TBA', style: TextStyle(color: AppColors.textaddn)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: AppColors.primary, size: 16),
                      SizedBox(width: 4),
                      Text(formatEventDate(event.date), style: TextStyle(color: AppColors.textaddn)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.access_time, color: AppColors.primary, size: 16),
                      SizedBox(width: 4),
                      Text("${formatEventTime(event.startTime)}", style: TextStyle(color: AppColors.textaddn)),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 20),

          // Ticket Selection Card
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ticket Information",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.second),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Price per ticket:", style: TextStyle(color: AppColors.textaddn)),
                      Text("₹${price.toStringAsFixed(2)}", style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text("Number of Tickets", style: TextStyle(color: AppColors.textaddn)),
                  SizedBox(height: 8),
                  Obx(() => Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove_circle, color: AppColors.primary),
                            onPressed: () {
                              if (ticketCount.value > 1) ticketCount.value--;
                            },
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              ticketCount.value.toString(),
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.add_circle, color: AppColors.primary),
                            onPressed: () {
                              ticketCount.value++;
                            },
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),

          SizedBox(height: 20),

          // Order Summary Card
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order Summary",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.second),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Amount"),
                      Obx(() => Text(
                            "₹${(ticketCount.value * price).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: AppColors.primary,
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 24),

          // Payment Button
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
                Get.snackbar('Payment Failed', 'Something went wrong. Try again.');
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
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}