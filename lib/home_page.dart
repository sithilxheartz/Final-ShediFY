import 'package:firebase_auth_tutorials/auth_services.dart';
import 'package:firebase_auth_tutorials/utils/colors.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // create a object from AuthServices
  final AuthteServices _auth = AuthteServices();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: AppBar(
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                "ShediFY",
                style: TextStyle(
                  color: iconTextColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 17),
                  child: Icon(
                    Icons.login_rounded,
                    size: 30,
                    color: iconTextColor,
                  ),
                ),
                onPressed: () async {
                  await _auth.signOut();
                },
              ),
            ],
            backgroundColor: appBarColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            children: [
              _buildMenuItem(context, Icons.people, "Add Pumpers", TestPage()),
              _buildMenuItem(
                context,
                Icons.assignment,
                "Assign Shifts",
                TestPage(),
              ),
              _buildMenuItem(context, Icons.add, "Add Fuel Stock", TestPage()),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildMenuItem(
  BuildContext context,
  IconData icon,
  String label,
  Widget page,
) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => page));
    },
    child: Container(
      decoration: BoxDecoration(
        color: iconBgColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50, color: iconTextColor),
          SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: iconTextColor,
            ),
          ),
        ],
      ),
    ),
  );
}

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Padding(
              padding: const EdgeInsets.only(top: 17),
              child: Icon(Icons.arrow_back, color: Colors.black),
            ),
            onPressed: () {
              Navigator.pop(context); // Correct back navigation
            },
          ),
          title: Text("This is a test Page"),
        ),
      ),
    );
  }
}
