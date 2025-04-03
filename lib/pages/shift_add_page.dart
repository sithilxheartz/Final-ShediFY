import 'package:firebase_auth_tutorials/widgets/custom_button.dart';
import 'package:firebase_auth_tutorials/models/shift_model.dart';
import 'package:firebase_auth_tutorials/services/shift_service.dart';
import 'package:firebase_auth_tutorials/utils/colors.dart';
import 'package:firebase_auth_tutorials/utils/snack_bar.dart' show showSnackBar;
import 'package:flutter/material.dart';
import 'package:firebase_auth_tutorials/services/pumper_service.dart';
import 'package:firebase_auth_tutorials/models/pumper_model.dart';

class ShiftAddPage extends StatefulWidget {
  ShiftAddPage({super.key});

  @override
  State<ShiftAddPage> createState() => _ShiftAddPageState();
}

class _ShiftAddPageState extends State<ShiftAddPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pumpNumber = TextEditingController();
  final TextEditingController _shiftType = TextEditingController();
  String? _selectedPump;
  String? _selectedShiftType;
  String? selectedPumper;
  final ValueNotifier<DateTime> _selectedDate = ValueNotifier<DateTime>(
    DateTime.now(),
  );

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

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate() && selectedPumper != null) {
      try {
        final Shift shift = Shift(
          id: '',
          pumpNumber: _pumpNumber.text,
          pumperName: selectedPumper!,
          shiftType: _shiftType.text,
          date: DateTime(
            _selectedDate.value.year,
            _selectedDate.value.month,
            _selectedDate.value.day,
          ),
        );
        await ShiftService().createNewShift(shift);
        showSnackBar(context, "Successfully added shift detail");
      } catch (error) {
        showSnackBar(context, "Failed to add shift");
      }
    } else {
      showSnackBar(context, "Please fill all fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.edit_calendar_outlined,
                    color: mainColor,
                    size: 35,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Update Shift Schedule",
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
                "Fill in the details below to add a new shift schedule.",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
              Divider(),
              ValueListenableBuilder<DateTime>(
                valueListenable: _selectedDate,
                builder: (context, date, child) {
                  return Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Date: ${date.toLocal().toString().split(" ")[0]}",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      IconButton(
                        onPressed: () => _selectDate(context),
                        icon: Icon(Icons.calendar_today),
                      ),
                    ],
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    filled: true,
                    labelText: "Select a Pump",
                    labelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  value: _selectedPump,
                  items:
                      [
                            'Pump 01',
                            'Pump 02',
                            'Pump 03',
                            'Pump 04',
                            'Pump 05',
                            'Pump 06',
                          ]
                          .map(
                            (value) => DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            ),
                          )
                          .toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedPump = newValue;
                      _pumpNumber.text = newValue ?? "";
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
                    labelText: "Select Shift Type",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  value: _selectedShiftType,
                  items:
                      [
                            'Day Shift (7.30 AM - 7.30 PM) 🌞',
                            'Night Shift (7.30 PM - 7.30 AM) 🌙',
                          ]
                          .map(
                            (value) => DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            ),
                          )
                          .toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedShiftType = newValue;
                      _shiftType.text = newValue ?? "";
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: StreamBuilder<List<Pumper>>(
                  stream: PumperService().pumpers,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return CircularProgressIndicator();
                    List<String> pumperNames =
                        snapshot.data!.map((p) => p.name).toList();
                    return DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                        ),
                        filled: true,
                        labelText: "Select Pumper",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      value: selectedPumper,
                      items:
                          pumperNames
                              .map(
                                (name) => DropdownMenuItem(
                                  value: name,
                                  child: Text(name),
                                ),
                              )
                              .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedPumper = value;
                        });
                      },
                    );
                  },
                ),
              ),

              CustomButton(
                labelText: "Add Schedule",
                onPressed: () => _submitForm(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
