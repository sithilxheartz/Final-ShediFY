import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth_tutorials/models/product_model.dart';

class ProductService {
  // reference to the firestore collection
  final CollectionReference productCollection = FirebaseFirestore.instance
      .collection("products");

  // method to add a new product to the firebase collection
  Future<void> createNewProduct(Product product) async {
    try {
      // converet the course object to a map
      final Map<String, dynamic> data = product.toJson();

      // add the course to the collection
      final DocumentReference docRef = await productCollection.add(data);

      // update the course document with the generated id
      await docRef.update({'id': docRef.id});
      print("Product saved");
    } catch (error) {
      print("Error creating Product $error");
    }
  }

  // methods to gell all the elements from the firestore collection
  // get all products as a stream list of course
  Stream<List<Product>> get products {
    try {
      return productCollection.snapshots().map((snapshot) {
        return snapshot.docs
            .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
      });
    } catch (error) {
      print("Error found: $error");
      return Stream.empty();
    }
  }
}
