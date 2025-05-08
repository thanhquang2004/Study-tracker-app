import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:study_tracker_mobile/presentation/home/cubit/home_cubit.dart';
import 'package:study_tracker_mobile/presentation/home/cubit/home_state.dart';
import 'package:study_tracker_mobile/presentation/resources/assets_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/color_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/styles_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/value_manager.dart';
import 'package:study_tracker_mobile/presentation/schedules/view/schedules_view.dart';
import 'package:study_tracker_mobile/presentation/widget/schedule_contain.dart';
import 'package:study_tracker_mobile/presentation/home/view/widget/title_row.dart';
import 'package:study_tracker_mobile/presentation/widget/shimmer_loading.dart';

class ScheduleList extends StatelessWidget {
  const ScheduleList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Expanded(
            child: Column(
              children: [
                ShimmerLoading(
                  itemWidth: 180,
                  itemHeight: 100,
                  titleHeight: 40,
                  itemCount: 4,
                ),
              ],
            ),
          );
        }

        if (state.errorMessage != null) {
          return Center(
            child: Text('Error: ${state.errorMessageSchedule}'),
          );
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleRow(
              title: 'Schedule',
              hasMore: false,
              orther: _buildAddScheduleButton(),
            ),
            const SizedBox(height: 8),
            state.schedules.isEmpty
                ? Center(
                    child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(ImageAssets.empty),
                      const SizedBox(height: 8),
                      Text(
                        'Nothing scheduled today.',
                        style: getBoldStyle(
                          fontSize: 16,
                          color: XColors.neutral_1,
                        ),
                      ),
                    ],
                  ))
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.schedules.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: index == state.schedules.length - 1 ? 0 : 16,
                        ),
                        child: ScheduleContain(schedule: state.schedules[index]),
                      );
                    },
                  ),
          ],
        );
      },
    );
  }

  Widget _buildAddScheduleButton() {
    return InkWell(
      onTap: () => Get.to(() => SchedulesView()),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white, // Nền trắng giúp nổi bật
          borderRadius: BorderRadius.circular(AppSize.s8),
          // border: Border.all(
          //   color: XColors.neutral_3.withOpacity(0.4), // Viền nhạt
          //   width: 1,
          // ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 3,
              offset: const Offset(0, 3), // bóng nhẹ bên dưới
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.add,
              color: XColors.primary,
              size: 20,
            ),
            const SizedBox(width: AppSize.s8),
            Text(
              'Add New',
              style: getSemiBoldStyle(
                fontSize: 12,
                color: XColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
