import 'package:firebase_auth_tutorials/models/product_model.dart';
import 'package:firebase_auth_tutorials/widgets/custom_button.dart';
import 'package:firebase_auth_tutorials/widgets/custom_input.dart';
import 'package:firebase_auth_tutorials/utils/colors.dart';
import 'package:firebase_auth_tutorials/utils/snack_bar.dart';
import 'package:flutter/material.dart';

class ProductPurchasePage extends StatelessWidget {
  final Product product;
  ProductPurchasePage({super.key, required this.product});
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _NameOnCardController = TextEditingController();
  final TextEditingController _CardNumberController = TextEditingController();
  final TextEditingController _ExpireDateController = TextEditingController();
  final TextEditingController _CVVController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _street1Controller = TextEditingController();
  final TextEditingController _street2Controller = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();

  void _submitPurchaseForm(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      // save form
      _formKey.currentState?.save();

      try {
        _NameOnCardController.clear();
        _CardNumberController.clear();
        _ExpireDateController.clear();
        _CVVController.clear();
        _phoneController.clear();
        _street1Controller.clear();
        _street2Controller.clear();
        _cityController.clear();
        _provinceController.clear();
        _CVVController.clear();
        // show succes in snackbar
        if (context.mounted) {
          showSnackBar(context, 'Invalid Payment Details!');
        }
        // Delay navigation to ensure SnackBar is displayed
        await Future.delayed(const Duration(seconds: 3));
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.shopping_cart, size: 40, color: mainColor),
                  SizedBox(width: 5),
                  Text(
                    "Proceed to Purchase",
                    style: TextStyle(
                      color: mainColor,
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                "Product: ${product.name} ${product.size}",
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),

              Text(
                "Per Price: ${product.price}",
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Card(
                  color: Colors.grey.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          "Enter your card details:",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: 5),
                        Image.asset("assets/image.png", width: 150),

                        CustomInput(
                          controller: _NameOnCardController,
                          labelText: "Card Holder Name",
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter Card Holder Name';
                            }
                            return null;
                          },
                        ),

                        CustomInput(
                          controller: _CardNumberController,
                          labelText: "Card Number",
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter Card Number';
                            }
                            return null;
                          },
                        ),

                        CustomInput(
                          controller: _ExpireDateController,
                          labelText: "Expire Date (YY-MM)",
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter Expire Date';
                            }
                            return null;
                          },
                        ),

                        CustomInput(
                          controller: _CVVController,
                          labelText: "Security Code - CVV",
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter Security Code';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Enter your delivery details:",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: 10),
                        CustomInput(
                          controller: _phoneController,
                          labelText: "Enter Mpbile Number",
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter mobile number';
                            }
                            return null;
                          },
                        ),

                        CustomInput(
                          controller: _street1Controller,
                          labelText: "Enter Street Line 01",
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter Street Line 01';
                            }
                            return null;
                          },
                        ),

                        CustomInput(
                          controller: _street2Controller,
                          labelText: "Enter Street Line 02",
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter Street Line 02';
                            }
                            return null;
                          },
                        ),

                        CustomInput(
                          controller: _cityController,
                          labelText: "Enter Your City",
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter your city';
                            }
                            return null;
                          },
                        ),
                        CustomInput(
                          controller: _provinceController,
                          labelText: "Enter Your Province",
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter your province';
                            }
                            return null;
                          },
                        ),
                        CustomButton(
                          labelText: "Proceed",
                          onPressed: () => _submitPurchaseForm(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
