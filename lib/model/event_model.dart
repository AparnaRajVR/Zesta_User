import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  final String id; 
  final String? address;
  final List<String>? ageLimit;
  final String? categoryId;
  final String? city;
  final DateTime? createdAt;
  final String? date;
  final String? description;
  final String? duration;
  final String? endTime;
  final List<String>? images;
  final List<String>? languages;
  final String? name;
  final String? startTime;
  final double? ticketPrice;
  final String organizerName;
  final DateTime eventDate;
  bool notificationSent;

  EventModel({
    required this.id, 
    this.address,
    this.ageLimit,
    this.categoryId,
    this.city,
    this.createdAt,
    this.date,
    this.description,
    this.duration,
    this.endTime,
    this.images,
    this.languages,
    this.name,
    this.startTime,
    this.ticketPrice,
    required this.organizerName,
    required this.eventDate,
    this.notificationSent = false,
  });

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      id: map['id'] ?? '', // Read id from map
      address: map['address'] as String?,
      ageLimit: map['ageLimit'] != null
          ? List<String>.from(map['ageLimit'])
          : null,
      categoryId: map['categoryId'] as String?,
      city: map['city'] as String?,
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as Timestamp).toDate()
          : null,
      date: map['date'] as String?,
      description: map['description'] as String?,
      duration: map['duration'] as String?,
      endTime: map['endTime'] as String?,
      images: map['images'] != null
          ? List<String>.from(map['images'])
          : null,
      languages: map['languages'] != null
          ? List<String>.from(map['languages'])
          : null,
      name: map['name'] as String?,
      startTime: map['startTime'] as String?,
      ticketPrice: map['ticketPrice'] != null
          ? (map['ticketPrice'] as num).toDouble()
          : null,
      organizerName: map['organizerName'] as String? ?? '',
      eventDate: map['eventDate'] != null
          ? (map['eventDate'] is Timestamp
              ? (map['eventDate'] as Timestamp).toDate()
              : DateTime.parse(map['eventDate'].toString()))
          : DateTime.now(),
      notificationSent: map['notificationSent'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'address': address,
      'ageLimit': ageLimit,
      'categoryId': categoryId,
      'city': city,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'date': date,
      'description': description,
      'duration': duration,
      'endTime': endTime,
      'images': images,
      'languages': languages,
      'name': name,
      'startTime': startTime,
      'ticketPrice': ticketPrice,
      'organizerName': organizerName,
      'eventDate': Timestamp.fromDate(eventDate),
      'notificationSent': notificationSent,
    };
  }
}
