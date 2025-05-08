import 'package:flutter/material.dart';
import 'package:study_tracker_mobile/presentation/resources/color_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/value_manager.dart';

class AuthenDatePicker extends StatefulWidget {
  final String label;
  final String? hint;
  final IconData? prefixIcon;
  final TextEditingController? controller;

  const AuthenDatePicker({
    super.key,
    required this.label,
    this.hint,
    this.prefixIcon,
    this.controller,
  });

  @override
  _AuthenDatePickerState createState() => _AuthenDatePickerState();
}

class _AuthenDatePickerState extends State<AuthenDatePicker> {
  int? selectedDay;
  int? selectedMonth;
  int? selectedYear;
  final List<int> days = List.generate(31, (index) => index + 1);
  final List<int> months = List.generate(12, (index) => index + 1);
  final List<int> years = List.generate(100, (index) => DateTime.now().year - index);

  @override
  void initState() {
    super.initState();
    // Initialize with current date or parse from controller if available
    if (widget.controller?.text.isNotEmpty == true) {
      final parts = widget.controller!.text.split('-');
      if (parts.length == 3) {
        selectedDay = int.tryParse(parts[0]);
        selectedMonth = int.tryParse(parts[1]);
        selectedYear = int.tryParse(parts[2]);
      }
    }
  }

  void _updateDate() {
    if (selectedDay != null && selectedMonth != null && selectedYear != null) {
      // Validate day in month
      final daysInMonth = DateTime(selectedYear!, selectedMonth! + 1, 0).day;
      if (selectedDay! > daysInMonth) {
        setState(() {
          selectedDay = daysInMonth;
        });
      }
      // Update controller with formatted date (dd-MM-yyyy)
      widget.controller?.text =
          '${selectedDay!.toString().padLeft(2, '0')}-${selectedMonth!.toString().padLeft(2, '0')}-$selectedYear';
    } else {
      widget.controller?.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSize.s8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Day Dropdown
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<int>(
                    value: selectedDay,
                    hint: const Text('DAY'),
                    isExpanded: true,
                    items: days.map((day) {
                      return DropdownMenuItem<int>(
                        value: day,
                        child: Text(day.toString().padLeft(2, '0')),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedDay = value;
                        _updateDate();
                      });
                    },
                    style: TextStyle(fontSize: 16, color: XColors.neutral_1),
                    icon: Icon(Icons.arrow_drop_down, color: XColors.neutral_1),
                    underline: const SizedBox(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Month Dropdown
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<int>(
                    value: selectedMonth,
                    hint: const Text('MONTH'),
                    isExpanded: true,
                    items: months.map((month) {
                      return DropdownMenuItem<int>(
                        value: month,
                        child: Text(month.toString().padLeft(2, '0')),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedMonth = value;
                        _updateDate();
                      });
                    },
                    style: TextStyle(fontSize: 16, color: XColors.neutral_1),
                    icon: Icon(Icons.arrow_drop_down, color: XColors.neutral_1),
                    underline: const SizedBox(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Year Dropdown
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<int>(
                    value: selectedYear,
                    hint: const Text('YEAR'),
                    isExpanded: true,
                    items: years.map((year) {
                      return DropdownMenuItem<int>(
                        value: year,
                        child: Text(year.toString()),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedYear = value;
                        _updateDate();
                      });
                    },
                    style: TextStyle(fontSize: 16, color: XColors.neutral_1),
                    icon: Icon(Icons.arrow_drop_down, color: XColors.neutral_1),
                    underline: const SizedBox(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
