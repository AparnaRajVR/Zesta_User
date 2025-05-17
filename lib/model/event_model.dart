import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
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

  EventModel({
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
  });

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      address: map['address'],
      ageLimit: List<String>.from(map['ageLimit'] ?? []),
      categoryId: map['categoryId'],
      city: map['city'],
      createdAt: (map['createdAt'] as Timestamp?)?.toDate(),
      date: map['date'],
      description: map['description'],
      duration: map['duration'],
      endTime: map['endTime'],
      images: List<String>.from(map['images'] ?? []),
      languages: List<String>.from(map['languages'] ?? []),
      name: map['name'],
      startTime: map['startTime'],
      ticketPrice: map['ticketPrice'],
      organizerName: map['organizerName'] ?? '',
    );
  }
}
