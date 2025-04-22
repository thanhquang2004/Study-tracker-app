import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:study_tracker_mobile/presentation/home/cubit/home_cubit.dart';
import 'package:study_tracker_mobile/presentation/home/cubit/home_state.dart';
import 'package:study_tracker_mobile/presentation/home/view/widget/date_time_contain.dart';

class DateTimeList extends StatelessWidget {
  const DateTimeList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final now = state.selectedDate;
        final monday = now.subtract(Duration(days: now.weekday - 1));

        return Container(
          height: 100,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 7,
            itemBuilder: (context, index) {
              final date = monday.add(Duration(days: index));
              final day = DateFormat('E').format(date);
              final dateString = DateFormat('d MMM').format(date);
              return GestureDetector(
                onTap: () => context.read<HomeCubit>().selectDate(date),
                child: DateTimeContain(
                  day: day,
                  date: dateString,
                  isActive: date.isAtSameMomentAs(state.selectedDate),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
