import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_tracker_mobile/presentation/home/cubit/home_cubit.dart';
import 'package:study_tracker_mobile/presentation/home/cubit/home_state.dart';
import 'package:study_tracker_mobile/presentation/home/view/widget/schedule_contain.dart';
import 'package:study_tracker_mobile/presentation/home/view/widget/title_row.dart';

class ScheduleList extends StatelessWidget {
  const ScheduleList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.errorMessage != null) {
          return Center(
            child: Text('Error: ${state.errorMessage}'),
          );
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleRow(
              title: 'Schedule',
              hasMore: false,
              onTap: () => context.read<HomeCubit>().viewMoreSchedules(),
            ),
            const SizedBox(height: 8),
            state.schedules.isEmpty
                ? Center(
                    child: Text(
                      'No schedules available',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.schedules.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: index == state.schedules.length - 1 ? 0 : 16,
                        ),
                        child:
                            ScheduleContain(schedule: state.schedules[index]),
                      );
                    },
                  ),
          ],
        );
      },
    );
  }
}
