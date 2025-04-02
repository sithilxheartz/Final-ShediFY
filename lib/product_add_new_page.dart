import 'package:firebase_auth_tutorials/test_page.dart';
import 'package:firebase_auth_tutorials/product_menu_page.dart';
import 'package:firebase_auth_tutorials/product_model.dart';
import 'package:firebase_auth_tutorials/product_service.dart';
import 'package:firebase_auth_tutorials/shared/custom_button.dart';
import 'package:firebase_auth_tutorials/shared/custom_input.dart';
import 'package:firebase_auth_tutorials/utils/colors.dart';
import 'package:firebase_auth_tutorials/utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddNewProductPage extends StatelessWidget {
  AddNewProductPage({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productModelController = TextEditingController();
  final TextEditingController _productSizeController = TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();
  final TextEditingController _productQuantityController =
      TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      // save form
      _formKey.currentState?.save();
      try {
        final Product product = Product(
          id: "",
          name: _productNameController.text,
          brand: _productModelController.text,
          size: _productSizeController.text,
          description: _productDescriptionController.text,
          quantity: double.tryParse(_productQuantityController.text) ?? 0.0,
          price: double.tryParse(_productPriceController.text) ?? 0.0,
        );
        await ProductService().createNewProduct(product);
        _productNameController.clear();
        _productModelController.clear();
        _productSizeController.clear();
        _productDescriptionController.clear();
        _productQuantityController.clear();
        _productPriceController.clear();
        // show succes in snackbar
        if (context.mounted) {
          showSnackBar(context, 'Product added successfully!');
        }
        // Delay navigation to ensure SnackBar is displayed
        await Future.delayed(const Duration(seconds: 1));
        //todo - remove this
      } catch (error) {
        print("Error found: $error");
        // show falled in snackbar
        if (context.mounted) {
          showSnackBar(context, 'Failled to add the product');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.add_business_rounded,
                      color: mainColor,
                      size: 35,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Add New Product",
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  "Fill in the details below to add a new product.",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                Divider(),

                CustomInput(
                  controller: _productNameController,
                  labelText: "Product Name",
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a Product name';
                    }
                    return null;
                  },
                ),
                CustomInput(
                  controller: _productModelController,
                  labelText: "Product Model",
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a Product Model';
                    }
                    return null;
                  },
                ),
                CustomInput(
                  controller: _productSizeController,
                  labelText: "Product Size",
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a Product Size';
                    }
                    return null;
                  },
                ),
                CustomInput(
                  controller: _productPriceController,
                  labelText: "Product Price",
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a Product Price';
                    }
                    return null;
                  },
                ),

                CustomInput(
                  controller: _productDescriptionController,
                  labelText: "Product Description",
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a Product Description';
                    }
                    return null;
                  },
                ),
                CustomInput(
                  controller: _productQuantityController,
                  labelText: "Starting Quantity",
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a Starting Quantity';
                    }
                    return null;
                  },
                ),
                CustomButton(
                  labelText: "Add Product",
                  onPressed: () => _submitForm(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
