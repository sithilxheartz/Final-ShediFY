import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.amber,
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
        ),
        body: Center(child: Text("This is a test Page")),
      ),
    );
  }
}
