import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zesta_1/constant/color.dart';

class OrderSummaryCard extends StatelessWidget {
  final RxInt ticketCount;
  final double price;

  const OrderSummaryCard({super.key, required this.ticketCount, required this.price});

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
            Text("Order Summary",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.second)),
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
    );
  }
}
