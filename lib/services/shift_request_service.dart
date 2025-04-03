import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth_tutorials/models/shift_request_model.dart';

class ShiftRequestService {
  // Reference to the fuel stock collection
  final CollectionReference shiftRequestCollection = FirebaseFirestore.instance
      .collection("shift_requests");

  /// Method to add a new shift to Firebase
  Future<String> createNewShiftRequest(ShiftRequest shiftrequest) async {
    try {
      // Convert object to JSON and remove 'id' since Firestore generates it
      final Map<String, dynamic> data = shiftrequest.toJson();

      // Add stock to Firestore and get the document reference
      final DocumentReference docRef = await shiftRequestCollection.add(data);

      // update the course document with the generated id
      await docRef.update({'id': docRef.id});

      print("✅ Fuel stock saved with ID: ${docRef.id}");
      return docRef.id; // Return the generated ID
    } catch (error) {
      print("❌ Error saving fuel stock: $error");
      rethrow; // Throw the error for further handling
    }
  }

  // methods to gell all the elements from the firestore collection
  // get all products as a stream list of course
  Stream<List<ShiftRequest>> get shiftrequest {
    try {
      return shiftRequestCollection.snapshots().map((snapshot) {
        return snapshot.docs
            .map(
              (doc) =>
                  ShiftRequest.fromJson(doc.data() as Map<String, dynamic>),
            )
            .toList();
      });
    } catch (error) {
      print("Error found: $error");
      return Stream.empty();
    }
  }

  // method to delete a task from the firestore collection
  Future<void> deleteTask(String id) async {
    try {
      shiftRequestCollection.doc(id).delete();
      print("Task deleted");
    } catch (error) {
      print("Error in deleting a task");
      print("$error");
    }
  }
}
