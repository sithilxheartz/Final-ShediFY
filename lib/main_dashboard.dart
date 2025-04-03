import 'package:firebase_auth_tutorials/auth_services.dart';
import 'package:firebase_auth_tutorials/dashboard_button.dart';
import 'package:firebase_auth_tutorials/shared/custom_button.dart';
import 'package:firebase_auth_tutorials/shift_view_page.dart';
import 'package:firebase_auth_tutorials/test_page.dart';
import 'package:firebase_auth_tutorials/fuel_stock_view.dart';
import 'package:firebase_auth_tutorials/management_page.dart';
import 'package:firebase_auth_tutorials/product_menu_page.dart';
import 'package:firebase_auth_tutorials/utils/colors.dart';
import 'package:flutter/material.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  final AuthteServices _auth = AuthteServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/logo.png", width: 80),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ShediFY",
                        style: TextStyle(
                          color: mainColor,
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        "Ease Your Life With Us",
                        style: TextStyle(
                          color: subTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                "Dashboard",
                style: TextStyle(
                  color: mainTextColor,
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 10),
              DashboardButton(
                title: "Product Menu",
                subtitle: "Explore our products and discover special offers.",
                icon: Icons.store,
                routePage: ProductMenuPage(),
              ),
              DashboardButton(
                title: "Real-Time Fuel Stock",
                subtitle:
                    "Check current fuel stock levels and real-time availability updates.",
                icon: Icons.local_gas_station_rounded,
                routePage: FuelStockView(),
              ),
              DashboardButton(
                title: "Shift Schedule",
                subtitle:
                    "View shift schedules along with detailed information.",
                icon: Icons.calendar_today_outlined,
                routePage: ShiftViewPage(),
              ),
              DashboardButton(
                title: "App Manager",
                subtitle: "Manage overall functionalities of the application.",
                icon: Icons.settings,
                routePage: ManagementPage(),
              ),
              SizedBox(height: 20),
              Text(
                textAlign: TextAlign.center,
                "© 2025 ShediFY - All rights reserved.",
                style: TextStyle(color: subTextColor, fontSize: 13),
              ),
              Text(
                textAlign: TextAlign.center,
                "Privacy Policy | Terms of Service",
                style: TextStyle(color: subTextColor, fontSize: 13),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: SizedBox(
        width: 180, // Custom width
        height: 50, // Custom height
        child: FloatingActionButton(
          onPressed: () async {
            await _auth.signOut();
            // Action here
          },
          backgroundColor: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.power_settings_new_outlined,
                color: Colors.white,
                size: 20,
              ),
              SizedBox(width: 5),
              Text(
                "Log Out",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ), // Adjust icon size
        ),
      ),
    );
  }
}
