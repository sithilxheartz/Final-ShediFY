import 'package:firebase_auth_tutorials/add_pumper_page.dart';
import 'package:firebase_auth_tutorials/dashboard_button.dart';
import 'package:firebase_auth_tutorials/fuel_stock_add.dart';
import 'package:firebase_auth_tutorials/shift_add_page.dart';
import 'package:firebase_auth_tutorials/test_page.dart';
import 'package:firebase_auth_tutorials/product_add_new_page.dart';
import 'package:firebase_auth_tutorials/utils/colors.dart';
import 'package:flutter/material.dart';

class ManagementPage extends StatelessWidget {
  const ManagementPage({super.key});

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
                  Icon(Icons.settings, size: 40, color: mainColor),
                  SizedBox(width: 5),
                  Text(
                    "ShediFY App Manager",
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
                "Manage overall functionalities of the application.",
                style: TextStyle(color: Colors.black54, fontSize: 13),
              ),
              SizedBox(height: 5),
              Text(
                "*Only for admin use",
                style: TextStyle(color: Colors.red, fontSize: 15),
              ),
              Divider(),
              DashboardButton(
                title: "Add New Product",
                subtitle: "Use this section to add a new product.",
                icon: Icons.add_business_rounded,
                routePage: AddNewProductPage(),
              ),
              DashboardButton(
                title: "Update Fuel Stock",
                subtitle: "Use this section to update daily fuel stock.",
                icon: Icons.update_rounded,
                routePage: FuelAddStock(),
              ),
              DashboardButton(
                title: "Update Schedules",
                subtitle: "Use this section to update shift schedule.",
                icon: Icons.edit_calendar_outlined,
                routePage: ShiftAddPage(),
              ),
              DashboardButton(
                title: "Add New Pumper",
                subtitle: "Use this section to add a new pumper.",
                icon: Icons.person_add_alt,
                routePage: AddPumperPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
