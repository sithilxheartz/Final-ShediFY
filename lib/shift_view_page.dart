import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'shift_service.dart';
import 'utils/colors.dart';
import 'shift_model.dart';

class ShiftViewPage extends StatefulWidget {
  const ShiftViewPage({super.key});

  @override
  State<ShiftViewPage> createState() => _ShiftViewPageState();
}

class _ShiftViewPageState extends State<ShiftViewPage> {
  final ValueNotifier<DateTime> _selectedDate = ValueNotifier<DateTime>(
    DateTime.now(),
  );

  /// Show date picker and update `_selectedDate`
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2025),
      lastDate: DateTime(2027),
      initialDate: _selectedDate.value,
    );

    if (picked != null && picked != _selectedDate.value) {
      _selectedDate.value = picked;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.calendar_today_outlined, size: 40, color: mainColor),
                const SizedBox(width: 5),
                Text(
                  "ShediFY Schedules",
                  style: TextStyle(
                    color: mainColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            Text(
              "Pumper's Daily Shift Schedules",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Click a shift to view details.",
              style: TextStyle(color: Colors.black54, fontSize: 13),
            ),
            Divider(),

            /// Date Picker
            ValueListenableBuilder<DateTime>(
              valueListenable: _selectedDate,
              builder: (context, date, child) {
                return Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Date: ${DateFormat('yyyy-MM-dd').format(date)}",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    IconButton(
                      onPressed: () => _selectDate(context),
                      icon: const Icon(Icons.calendar_today),
                    ),
                  ],
                );
              },
            ),

            /// Shift List
            ValueListenableBuilder<DateTime>(
              valueListenable: _selectedDate,
              builder: (context, date, child) {
                return StreamBuilder<List<Shift>>(
                  stream: ShiftService().getShiftsByDate(date),
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
                          child: const Text(
                            "No shifts available for this date.",
                          ),
                        ),
                      );
                    } else {
                      final shifts = snapshot.data!;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: shifts.length,
                        itemBuilder: (context, index) {
                          final shift = shifts[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: mainColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// Pumper Name & Date
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(Icons.person, color: mainColor),
                                          const SizedBox(width: 5),
                                          SizedBox(
                                            width: 140,
                                            child: Text(
                                              shift.pumperName,
                                              style: TextStyle(
                                                color: mainColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        DateFormat(
                                          'yyyy-MMMM-dd',
                                        ).format(shift.date),
                                        style: TextStyle(
                                          color: subTextColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),

                                  /// Pump Number
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.local_gas_station,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        shift.pumpNumber,
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),

                                  /// Shift Type
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.timelapse_sharp,
                                        size: 17,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        shift.shiftType,
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
