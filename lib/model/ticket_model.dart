class Ticket {
  final String eventName;
  final String eventDate;
  final String eventTime;
  final String eventLocation;
  final int ticketCount;
  final double amountPaid;
  final String barcode;

  Ticket({
    required this.eventName,
    required this.eventDate,
    required this.eventTime,
    required this.eventLocation,
    required this.ticketCount,
    required this.amountPaid,
    required this.barcode,
  });

  Map<String, dynamic> toMap() {
    return {
      'eventName': eventName,
      'eventDate': eventDate,
      'eventTime': eventTime,
      'eventLocation': eventLocation,
      'ticketCount': ticketCount,
      'amountPaid': amountPaid,
      'barcode': barcode,
    };
  }

  factory Ticket.fromMap(Map<String, dynamic> map) {
    return Ticket(
      eventName: map['eventName'],
      eventDate: map['eventDate'],
      eventTime: map['eventTime'],
      eventLocation: map['eventLocation'],
      ticketCount: map['ticketCount'],
      amountPaid: (map['amountPaid'] as num).toDouble(),
      barcode: map['barcode'] ?? '',
    );
  }
}
