import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zesta_1/model/ticket_model.dart';

class TicketController extends GetxController {
  var tickets = <Ticket>[].obs;

  Future<void> saveTicket(Ticket ticket) async {
    await FirebaseFirestore.instance.collection('tickets').add(ticket.toMap());
   
    await fetchAllTickets();
  }

  Future<void> fetchAllTickets() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('tickets')
        .orderBy('eventDate', descending: true)
        .get();

    tickets.value = snapshot.docs
        .map((doc) => Ticket.fromMap(doc.data()))
        .toList();
  }
}
