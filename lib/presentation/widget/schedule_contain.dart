import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:study_tracker_mobile/data/helpers/date_helper.dart';
import 'package:study_tracker_mobile/domain/model/schedule.dart';
import 'package:study_tracker_mobile/presentation/resources/color_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/styles_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/value_manager.dart';

class ScheduleContain extends StatelessWidget {
  final Schedule schedule;

  const ScheduleContain({
    super.key,
    required this.schedule,
  });

  @override
  Widget build(BuildContext context) {
    

    return Container(
      width: 180,
      height: 100,
      margin: const EdgeInsets.only(right: AppSize.s12),
      padding: const EdgeInsets.all(AppSize.s12),
      decoration: BoxDecoration(
        color: XColors.neutral_8,
        borderRadius: BorderRadius.circular(AppSize.s8),
        boxShadow: [
          BoxShadow(
            color: XColors.neutral_5.withOpacity(0.25),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: AppSize.s12,
        children: [
          Icon(
            Icons.calendar_today,
            color: XColors.primary,
            size: AppSize.s32,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  schedule.title,
                  style: getBoldStyle(
                    fontSize: AppSize.s16,
                    color: XColors.neutral_1,
                  ),
                ),
                const SizedBox(height: AppSize.s4),
                Text(
                  schedule.description,
                  
                  style: getRegularStyle(
                    fontSize: AppSize.s14,
                    color: XColors.neutral_6,
                  ),
                ),
              ],
            ),
          ),
          
        ],
      ),
    );
  }

  String _formatTimeRange(Schedule schedule) {
    if (schedule.allDay) {
      return 'All Day';
    }

    final startDate = formatStringToDateTime(schedule.startDate.toString());
    final endDate = formatStringToDateTime(schedule.endDate.toString());

    final startTime = DateFormat('HH:mm').format(startDate);
    final endTime = DateFormat('HH:mm').format(endDate);
    return '$startTime - $endTime';
  }
}