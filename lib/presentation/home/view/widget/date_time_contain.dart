import 'package:flutter/material.dart';
import 'package:study_tracker_mobile/presentation/resources/styles_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/value_manager.dart';

class DateTimeContain extends StatelessWidget {
  final String day;
  final String date;
  final bool isActive;

  const DateTimeContain({
    super.key,
    required this.day,
    required this.date,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s100,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isActive ? Theme.of(context).primaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isActive ? Colors.transparent : Colors.grey.shade300,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            day,
            style: getBoldStyle(
              color: isActive ? Colors.white : Colors.grey.shade600,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            date,
            style: getRegularStyle(
              color: isActive ? Colors.white : Colors.grey.shade600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
} 