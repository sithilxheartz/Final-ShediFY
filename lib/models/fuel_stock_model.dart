import 'package:cloud_firestore/cloud_firestore.dart';

class FuelStock {
  final String id;
  final double autoDieselReading;
  final double superDieselReading;
  final double xtraDieselReading;
  final double petrol92Reading;
  final double petrol95Reading;
  final double petrol100Reading;
  final DateTime date;

  FuelStock({
    required this.id,
    required this.autoDieselReading,
    required this.superDieselReading,
    required this.xtraDieselReading,
    required this.petrol92Reading,
    required this.petrol95Reading,
    required this.petrol100Reading,
    required this.date,
  });

  /// Convert Firestore document into a FuelStock object
  factory FuelStock.fromJson(Map<String, dynamic> data, String docId) {
    return FuelStock(
      id: docId, // Assign Firestore document ID as the model ID
      autoDieselReading: (data['autoDieselReading'] as num?)?.toDouble() ?? 0.0,
      superDieselReading:
          (data['superDieselReading'] as num?)?.toDouble() ?? 0.0,
      xtraDieselReading: (data['xtraDieselReading'] as num?)?.toDouble() ?? 0.0,
      petrol92Reading: (data['petrol92Reading'] as num?)?.toDouble() ?? 0.0,
      petrol95Reading: (data['petrol95Reading'] as num?)?.toDouble() ?? 0.0,
      petrol100Reading: (data['petrol100Reading'] as num?)?.toDouble() ?? 0.0,
      date: (data['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  /// Convert FuelStock object into Firestore-compatible JSON
  Map<String, dynamic> toJson() {
    return {
      'autoDieselReading': autoDieselReading,
      'superDieselReading': superDieselReading,
      'xtraDieselReading': xtraDieselReading,
      'petrol92Reading': petrol92Reading,
      'petrol95Reading': petrol95Reading,
      'petrol100Reading': petrol100Reading,
      'date':
          FieldValue.serverTimestamp(), // Firestore auto-generates timestamp
    };
  }
}
