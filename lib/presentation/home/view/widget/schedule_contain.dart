import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:study_tracker_mobile/data/helpers/date_helper.dart';
import 'package:study_tracker_mobile/domain/model/schedule.dart';
import 'package:study_tracker_mobile/presentation/resources/color_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/styles_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/value_manager.dart';

class ScheduleContain extends StatelessWidget {
  final Schedule schedule;
  static const String defaultColor = '#007AFF'; // XColors.primary

  const ScheduleContain({
    super.key,
    required this.schedule,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = schedule.color.isNotEmpty
        ? Color(int.parse('0xFF${schedule.color.substring(1)}'))
        : Color(int.parse('0xFF${defaultColor.substring(1)}'));

    final textColor = XColors.neutral_1;
    final secondaryTextColor = textColor.withOpacity(0.8);
    final tertiaryTextColor = textColor.withOpacity(0.6);

    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: AppSize.s16),
      padding: const EdgeInsets.all(AppSize.s16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppSize.s12),
        boxShadow: [
          BoxShadow(
            color: XColors.neutral_1.withOpacity(0.1),
            blurRadius: AppSize.s8,
            offset: const Offset(0, AppSize.s4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            schedule.title,
            style: getBoldStyle(
              color: textColor,
              fontSize: AppSize.s16,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: AppSize.s8),
          Text(
            schedule.description,
            style: getRegularStyle(
              color: secondaryTextColor,
              fontSize: AppSize.s14,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: AppSize.s8),
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: AppSize.s16,
                color: tertiaryTextColor,
              ),
              SizedBox(width: AppSize.s4),
              Text(
                _formatTimeRange(schedule),
                style: getRegularStyle(
                  color: tertiaryTextColor,
                  fontSize: AppSize.s12,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSize.s4),
          Row(
            children: [
              Icon(
                Icons.category,
                size: AppSize.s16,
                color: tertiaryTextColor,
              ),
              SizedBox(width: AppSize.s4),
              Text(
                schedule.category,
                style: getRegularStyle(
                  color: tertiaryTextColor,
                  fontSize: AppSize.s12,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSize.s4),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSize.s8,
              vertical: AppSize.s4,
            ),
            decoration: BoxDecoration(
              color: textColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppSize.s4),
            ),
            child: Text(
              schedule.status.toUpperCase(),
              style: getBoldStyle(
                color: textColor,
                fontSize: AppSize.s12,
              ),
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
