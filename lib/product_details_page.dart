import 'package:firebase_auth_tutorials/product_model.dart';
import 'package:firebase_auth_tutorials/product_purchase_page.dart';
import 'package:firebase_auth_tutorials/shared/custom_button.dart';
import 'package:firebase_auth_tutorials/shared/custom_input.dart';
import 'package:firebase_auth_tutorials/utils/colors.dart';
import 'package:firebase_auth_tutorials/utils/snack_bar.dart';
import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;
  ProductDetailsPage({super.key, required this.product});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _buyQuantityController = TextEditingController();

  void _submitQuantityForm(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      // save form
      _formKey.currentState?.save();

      try {
        _buyQuantityController.clear();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPurchasePage(product: product),
          ),
        );
      } catch (error) {
        print("Error found: $error");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.oil_barrel_rounded, size: 40, color: iconColor),
                  SizedBox(width: 5),
                  Text(
                    product.name,
                    style: TextStyle(
                      color: iconColor,
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                "Size: ${product.size}",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Brand: ${product.brand}",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "In Stock: ${product.quantity}",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Description",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                product.description,
                style: TextStyle(fontSize: 15, color: Colors.black54),
              ),
              SizedBox(height: 10),
              Text(
                "ShediFY Special Price:",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),

              Text(
                "Rs.${product.price}",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomInput(
                      controller: _buyQuantityController,
                      labelText: "Order Quantity",
                      validator: (value) {
                        // Check if the input is empty
                        if (value == null || value.isEmpty) {
                          return 'Please enter a quantity'; // User must provide a quantity
                        }

                        // Try to convert the input into an integer
                        final int? quantity = int.tryParse(value);

                        // Check if the input is a valid number
                        if (quantity == null) {
                          return 'Please enter a valid number'; // Input must be numeric
                        }

                        // Check if the entered quantity exceeds available stock
                        if (quantity > product.quantity) {
                          return 'Low stock available'; // Notify the user about stock limitations
                        }

                        return null; // Input is valid, no errors
                      },
                    ),
                    CustomButton(
                      labelText: "Buy now ${product.name} ${product.size}",
                      BgColor: iconColor,
                      onPressed: () => _submitQuantityForm(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
