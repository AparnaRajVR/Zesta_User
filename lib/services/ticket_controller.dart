import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zesta_1/model/ticket_model.dart';

class TicketController extends GetxController {
  var tickets = <Ticket>[].obs;

  var remainingTickets = 0.obs;
  var isButtonEnabled = false.obs;
  var isLoading = true.obs;

  late String eventId;
  late DateTime eventDate;

  void listenEventAvailability(
      {required String eventId, required DateTime eventDate}) {
    this.eventId = eventId;
    this.eventDate = eventDate;

    isLoading.value = true;

    FirebaseFirestore.instance
        .collection('events')
        .doc(eventId)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        final ticketsCount = snapshot.data()?['totalTickets'] ?? 0;
        remainingTickets.value = ticketsCount;

        final now = DateTime.now();

        // Enable button only if tickets available and event not passed
        isButtonEnabled.value = ticketsCount > 0 && now.isBefore(eventDate);
      } else {
        remainingTickets.value = 0;
        isButtonEnabled.value = false;
      }

      isLoading.value = false;
    });
  }

  Future<void> saveTicket(Ticket ticket) async {
    await FirebaseFirestore.instance.collection('tickets').add(ticket.toMap());
    await fetchAllTickets();
  }

  Future<void> fetchAllTickets() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('tickets')
        .orderBy('eventDate', descending: true)
        .get();

    tickets.value =
        snapshot.docs.map((doc) => Ticket.fromMap(doc.data())).toList();
  }
}
