import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zesta_1/constant/color.dart';

class TicketSelectionCard extends StatelessWidget {
  final RxInt ticketCount;
  final double price;

  const TicketSelectionCard({super.key, required this.ticketCount, required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Ticket Information",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.second)),
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
                        if (ticketCount.value < 10) ticketCount.value++;
                      },
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
