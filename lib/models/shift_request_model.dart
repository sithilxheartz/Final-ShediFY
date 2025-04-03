import 'package:cloud_firestore/cloud_firestore.dart';

class ShiftRequest {
  final String id;
  final String pumperName;
  final String description;
  final String shiftType;
  final DateTime date;

  ShiftRequest({
    required this.id,
    required this.pumperName,
    required this.description,
    required this.shiftType,
    required this.date,
  });

  // method to convert the firebase document in to a dart object
  factory ShiftRequest.fromJson(Map<String, dynamic> json) {
    return ShiftRequest(
      id: json['id'] ?? '',
      pumperName: json['pumperName'] ?? '',
      description: json['description'] ?? '',
      shiftType: json['shftType'] ?? '',
      date: (json['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  // convert the product model to a firebase document
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pumperName': pumperName,
      'description': description,
      'shftType': shiftType,
      'date': date,
    };
  }
}
