import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:study_tracker_mobile/presentation/home/cubit/home_cubit.dart';
import 'package:study_tracker_mobile/presentation/home/view/widget/date_time_list.dart';
import 'package:study_tracker_mobile/presentation/home/view/widget/home_app_bar.dart';
import 'package:study_tracker_mobile/presentation/home/view/widget/home_drawer.dart';
import 'package:study_tracker_mobile/presentation/home/view/widget/note_list.dart';
import 'package:study_tracker_mobile/presentation/home/view/widget/schedule_list.dart';
import 'package:study_tracker_mobile/presentation/resources/color_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/routes_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/styles_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/value_manager.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      endDrawer: const HomeDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.generate);
        },
        backgroundColor: XColors.primary,
        shape: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(AppSize.s8).copyWith(top: AppSize.s12),
          child: Image.asset(
            'assets/icons/bot.png',
            fit: BoxFit.cover,
            color: XColors.neutral_9,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const DateTimeList(),
            Expanded(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child:  const NoteList(),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: const ScheduleList(),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}