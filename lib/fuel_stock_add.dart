import 'package:firebase_auth_tutorials/fuel_stock_model.dart';
import 'package:firebase_auth_tutorials/fuel_stock_service.dart';
import 'package:firebase_auth_tutorials/fuel_stock_view.dart';
import 'package:firebase_auth_tutorials/shared/custom_button.dart';
import 'package:firebase_auth_tutorials/shared/custom_input.dart';
import 'package:firebase_auth_tutorials/utils/colors.dart';
import 'package:firebase_auth_tutorials/utils/snack_bar.dart';
import 'package:flutter/material.dart';

class FuelAddStock extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final double tankCapacity = 18000;

  final TextEditingController _tank1Controller = TextEditingController();
  final TextEditingController _tank2Controller = TextEditingController();
  final TextEditingController _tank3Controller = TextEditingController();
  final TextEditingController _tank4Controller = TextEditingController();
  final TextEditingController _tank5Controller = TextEditingController();
  final TextEditingController _tank6Controller = TextEditingController();

  final ValueNotifier<DateTime> _selectedDate = ValueNotifier<DateTime>(
    DateTime.now(),
  );

  FuelAddStock({super.key});

  // Date Picker
  Future<void> _selectDate(BuildContext ctx) async {
    final DateTime? picked = await showDatePicker(
      context: ctx,
      firstDate: DateTime(2025),
      lastDate: DateTime(2027),
      initialDate: _selectedDate.value,
    );

    if (picked != null) {
      _selectedDate.value = picked;
    }
  }

  // Submit Form
  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        // Convert text inputs to double values
        final FuelStock fuelstock = FuelStock(
          id: '',
          autoDieselReading: double.tryParse(_tank1Controller.text) ?? 0.0,
          superDieselReading: double.tryParse(_tank2Controller.text) ?? 0.0,
          xtraDieselReading: double.tryParse(_tank3Controller.text) ?? 0.0,
          petrol92Reading: double.tryParse(_tank4Controller.text) ?? 0.0,
          petrol95Reading: double.tryParse(_tank5Controller.text) ?? 0.0,
          petrol100Reading: double.tryParse(_tank6Controller.text) ?? 0.0,
          date: DateTime(
            _selectedDate.value.year,
            _selectedDate.value.month,
            _selectedDate.value.day,
          ),
        );
        await FuelStockService().createNewFuelStock(fuelstock);

        _tank1Controller.clear();
        _tank2Controller.clear();
        _tank3Controller.clear();
        _tank4Controller.clear();
        _tank5Controller.clear();
        _tank6Controller.clear();

        showSnackBar(context, "Successfully added today's stock");
      } catch (error) {
        print("Error: $error");
        showSnackBar(context, "Failed to add stock");
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
                    Icon(Icons.update_rounded, color: mainColor, size: 35),
                    SizedBox(width: 5),
                    Text(
                      "Add Fuel Stock Readings",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: mainColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  "Fill in the details below to add a new stock reading.",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
                Divider(),

                _buildCustomInput(
                  "Enter Auto Diesel Reading",
                  _tank1Controller,
                ),
                _buildCustomInput(
                  "Enter Super Diesel Reading",
                  _tank2Controller,
                ),
                _buildCustomInput(
                  "Enter Xtra-Mile Diesel Reading",
                  _tank3Controller,
                ),
                _buildCustomInput(
                  "Enter 92 Octane Petrol Reading",
                  _tank4Controller,
                ),
                _buildCustomInput(
                  "Enter 95 Octane Petrol Reading",
                  _tank5Controller,
                ),
                _buildCustomInput(
                  "Enter 100 Octane Petrol Reading",
                  _tank6Controller,
                ),
                CustomButton(
                  labelText: "Add Fuel Stock",
                  onPressed: () => _submitForm(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomInput(String label, TextEditingController controller) {
    return CustomInput(
      controller: controller,
      labelText: label,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a quantity';
        }

        final double? quantity = double.tryParse(value);
        if (quantity == null) {
          return 'Please enter a valid number';
        }
        if (quantity > tankCapacity) {
          return 'Tank maximum capacity is $tankCapacity';
        }
        return null;
      },
    );
  }
}
