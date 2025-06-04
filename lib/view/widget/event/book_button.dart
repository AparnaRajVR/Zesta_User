import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zesta_1/model/event_model.dart';
import 'package:zesta_1/view/screen/payment_proceed.dart';
import 'package:zesta_1/constant/color.dart';

class BottomBookButton extends StatelessWidget {
  final EventModel event;
  const BottomBookButton({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, -2))
          ]),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '₹${event.ticketPrice?.toStringAsFixed(0) ?? '299'}',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
            onPressed: () => Get.to(() => BookingPage(event: event)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              elevation: 2,
            ),
            child: const Text('Book Now',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
