import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth_tutorials/fuel_stock_model.dart';

class FuelStockService {
  // Reference to the fuel stock collection
  final CollectionReference fuelStockCollection = FirebaseFirestore.instance
      .collection("fuelStocks");

  /// Method to add a new fuel stock to Firebase
  Future<String> createNewFuelStock(FuelStock fuelstock) async {
    try {
      // Convert object to JSON and remove 'id' since Firestore generates it
      final Map<String, dynamic> data = fuelstock.toJson();

      // Add stock to Firestore and get the document reference
      final DocumentReference docRef = await fuelStockCollection.add(data);

      print("✅ Fuel stock saved with ID: ${docRef.id}");
      return docRef.id; // Return the generated ID
    } catch (error) {
      print("❌ Error saving fuel stock: $error");
      rethrow; // Throw the error for further handling
    }
  }

  /// Method to fetch a fuel stock by document ID
  Future<FuelStock?> getFuelStock(String docId) async {
    try {
      DocumentSnapshot doc = await fuelStockCollection.doc(docId).get();
      if (!doc.exists) return null;

      return FuelStock.fromJson(doc.data() as Map<String, dynamic>, doc.id);
    } catch (error) {
      print("❌ Error fetching fuel stock: $error");
      return null;
    }
  }

  Stream<FuelStock?> getLatestFuelStockStream() {
    return fuelStockCollection
        .orderBy('date', descending: true) // Sort by date (latest first)
        .limit(1) // Get only the latest entry
        .snapshots() // Listen to real-time updates
        .map((snapshot) {
          if (snapshot.docs.isNotEmpty) {
            final doc = snapshot.docs.first;
            final data = doc.data() as Map<String, dynamic>;

            print("🔥 Latest Fuel Stock Updated: ${doc.id}");
            print("🔥 Data: $data");

            return FuelStock.fromJson(data, doc.id);
          }
          return null;
        });
  }
}
