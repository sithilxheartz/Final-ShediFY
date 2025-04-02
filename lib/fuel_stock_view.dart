import 'package:flutter/material.dart';
import 'package:firebase_auth_tutorials/fuel_stock_service.dart';
import 'package:firebase_auth_tutorials/fuel_stock_model.dart';
import 'package:firebase_auth_tutorials/utils/colors.dart';
import 'package:intl/intl.dart';

class FuelStockView extends StatefulWidget {
  const FuelStockView({super.key});

  @override
  _FuelStockViewState createState() => _FuelStockViewState();
}

class _FuelStockViewState extends State<FuelStockView> {
  final double tankCapacity = 18000;
  final FuelStockService _fuelStockService = FuelStockService();

  /// Widget to display progress bars
  Widget _buildFuelProgress(String label, double? value) {
    double progress = (value ?? 0) / tankCapacity;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: mainColor),
          borderRadius: BorderRadius.circular(10),
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              LinearProgressIndicator(
                value: progress.clamp(0.0, 1.0), // Keep between 0 and 1
                backgroundColor: Colors.grey.shade300,
                color: mainColor,
                borderRadius: BorderRadius.circular(7),
                minHeight: 30,
              ),
              SizedBox(height: 5),
              Text(
                "$value / $tankCapacity L",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: StreamBuilder<FuelStock?>(
            stream: _fuelStockService.getLatestFuelStockStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data == null) {
                return Center(child: Text("No fuel stock data available."));
              }

              FuelStock latestStock = snapshot.data!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.local_gas_station_rounded,
                        color: mainColor,
                        size: 40,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "ShediFY Fuel Station",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: mainColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Real-time fuel stocks at a glance. Monitor your inventory levels here.",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                  Divider(),
                  Row(
                    children: [
                      Text(
                        "Available Stock to: ",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                      Text(
                        DateFormat('yyyy-MM-dd').format(DateTime.now()),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  _buildFuelProgress(
                    "Auto Diesel ",
                    latestStock.autoDieselReading,
                  ),
                  _buildFuelProgress(
                    "Super Diesel",
                    latestStock.superDieselReading,
                  ),
                  _buildFuelProgress(
                    "Xtra-Mile Diesel",
                    latestStock.xtraDieselReading,
                  ),
                  _buildFuelProgress("Petrol 92", latestStock.petrol92Reading),
                  _buildFuelProgress("Petrol 95", latestStock.petrol95Reading),
                  _buildFuelProgress(
                    "Petrol 100",
                    latestStock.petrol100Reading,
                  ),
                  SizedBox(height: 30),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
