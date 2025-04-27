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
                      child: const NoteList(),
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

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSize.s16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: AppSize.s24,
            backgroundImage: NetworkImage('https://via.placeholder.com/48'),
          ),
          const SizedBox(width: AppSize.s16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'John Doe',
                style: getBoldStyle(color: Colors.black),
              ),
              Text(
                'john.doe@example.com',
                style: getRegularStyle(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDanger = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDanger ? XColors.semanticError : null,
      ),
      title: Text(
        title,
        style: isDanger
            ? getRegularStyle(color: XColors.semanticError)
            : getRegularStyle(color: Colors.black),
      ),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout', style: getBoldStyle(color: Colors.black)),
        content: Text(
          'Are you sure you want to logout?',
          style: getRegularStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: getRegularStyle(color: Colors.black)),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement logout functionality
              Navigator.pop(context);
            },
            child: Text('Logout',
                style: getRegularStyle(color: XColors.semanticError)),
          ),
        ],
      ),
    );
  }
}
