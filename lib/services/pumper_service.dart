import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth_tutorials/models/pumper_model.dart';

class PumperService {
  // reference to the firestore collection
  final CollectionReference pumperCollection = FirebaseFirestore.instance
      .collection("pumpers");

  // method to add a new product to the firebase collection
  Future<void> createNewPumper(Pumper pumper) async {
    try {
      // converet the course object to a map
      final Map<String, dynamic> data = pumper.toJson();

      // add the course to the collection
      final DocumentReference docRef = await pumperCollection.add(data);

      // update the course document with the generated id
      await docRef.update({'id': docRef.id});
      print("Pumper saved");
    } catch (error) {
      print("Error creating pumper $error");
    }
  }

  // methods to gell all the elements from the firestore collection
  // get all products as a stream list of course
  Stream<List<Pumper>> get pumpers {
    try {
      return pumperCollection.snapshots().map((snapshot) {
        return snapshot.docs
            .map((doc) => Pumper.fromJson(doc.data() as Map<String, dynamic>))
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
      pumperCollection.doc(id).delete();
      print("Task deleted");
    } catch (error) {
      print("Error in deleting a task");
      print("$error");
    }
  }
}
