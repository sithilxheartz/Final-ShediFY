import 'package:firebase_auth_tutorials/pumper_model.dart';
import 'package:firebase_auth_tutorials/pumper_service.dart';
import 'package:firebase_auth_tutorials/shared/custom_button.dart';
import 'package:firebase_auth_tutorials/shared/custom_input.dart';
import 'package:firebase_auth_tutorials/utils/colors.dart';
import 'package:firebase_auth_tutorials/utils/snack_bar.dart';
import 'package:flutter/material.dart';

class AddPumperPage extends StatefulWidget {
  AddPumperPage({super.key});

  @override
  State<AddPumperPage> createState() => _AddPumperPageState();
}

class _AddPumperPageState extends State<AddPumperPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _pumperName = TextEditingController();
  final TextEditingController _pumperMobile = TextEditingController();
  final TextEditingController _pumperShift = TextEditingController();
  String? _selectedShift;
  final TextEditingController _pumperPosition = TextEditingController();
  String? _selectedPosition;

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      // save form
      _formKey.currentState?.save();
      try {
        final Pumper pumper = Pumper(
          id: "",
          name: _pumperName.text,
          mobile: _pumperMobile.text,
          shiftType: _pumperShift.text,
          fuelType: _pumperPosition.text,
        );
        await PumperService().createNewPumper(pumper);
        _pumperName.clear();
        _pumperMobile.clear();
        _pumperName.clear();
        _pumperShift.clear();
        _pumperPosition.clear();

        // show succes in snackbar
        if (context.mounted) {
          showSnackBar(context, 'Pumper added successfully!');
        }
        // Delay navigation to ensure SnackBar is displayed
        await Future.delayed(const Duration(seconds: 1));
      } catch (error) {
        print("Error found: $error");
        // show falled in snackbar
        if (context.mounted) {
          showSnackBar(context, 'Failled to add the pumper');
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.person_add_alt, color: mainColor, size: 35),
                    SizedBox(width: 5),
                    Text(
                      "Add New Pumper",
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
                  "Fill in the details below to add a new pumper.",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 15,
                  ),
                ),
                Divider(),
                CustomInput(
                  controller: _pumperName,
                  labelText: "Enter Pumper Name",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }

                    return null;
                  },
                ),
                CustomInput(
                  controller: _pumperMobile,
                  labelText: "Enter Mobile Number",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a mobile number';
                    } else if (value.length != 10) {
                      return 'Maximum 10 characters allowed';
                    }

                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      filled: true,
                      labelStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      labelText: "Select Interested Shift",
                    ),

                    value: _selectedShift,
                    items:
                        ['🌞 Day Shift', '🌙 Night Shift']
                            .map(
                              (value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ),
                            )
                            .toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedShift = newValue;
                        _pumperShift.text = newValue ?? "";
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      filled: true,
                      labelStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      labelText: "Select Fuel Type",
                    ),

                    value: _selectedPosition,
                    items:
                        ['Petrol Pumper', 'Diesel Pumper']
                            .map(
                              (value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ),
                            )
                            .toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedPosition = newValue;
                        _pumperPosition.text = newValue ?? "";
                      });
                    },
                  ),
                ),
                CustomButton(
                  labelText: "Add Pumper",
                  onPressed: () => _submitForm(context),
                ),
                Divider(),
                Text(
                  "Currunt Pumpers on duty",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                StreamBuilder(
                  stream: PumperService().pumpers,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height / 5,
                          ),
                          child: Text("No Pumpers are available."),
                        ),
                      );
                    } else {
                      final pumpers = snapshot.data!;

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: pumpers.length,
                        itemBuilder: (context, index) {
                          final pumper = pumpers[index];
                          return Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: mainColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              title: Row(
                                children: [
                                  Icon(Icons.person_outline_rounded, size: 40),
                                  SizedBox(width: 10),
                                  SizedBox(
                                    width: 210,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          pumper.name,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          "Mobile: ${pumper.mobile}",
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 13,
                                          ),
                                        ),
                                        Text(
                                          "${pumper.fuelType} | ${pumper.shiftType}",
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // todo delete button
                                  SizedBox(width: 30),
                                  GestureDetector(
                                    onDoubleTap: () {
                                      PumperService().deleteTask(pumper.id);
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      size: 25,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
