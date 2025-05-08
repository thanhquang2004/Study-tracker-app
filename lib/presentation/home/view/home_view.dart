import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:study_tracker_mobile/presentation/home/cubit/change_password_cubit.dart';
import 'package:study_tracker_mobile/presentation/home/cubit/home_cubit.dart';
import 'package:study_tracker_mobile/presentation/home/cubit/home_state.dart';
import 'package:study_tracker_mobile/presentation/home/view/widget/date_time_list.dart';
import 'package:study_tracker_mobile/presentation/home/view/widget/home_app_bar.dart';
import 'package:study_tracker_mobile/presentation/home/view/widget/home_drawer.dart';
import 'package:study_tracker_mobile/presentation/home/view/widget/note_list.dart';
import 'package:study_tracker_mobile/presentation/home/view/widget/schedule_list.dart';
import 'package:study_tracker_mobile/presentation/resources/color_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/routes_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/value_manager.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WidgetsBindingObserver, RouteAware {
  late HomeCubit _homeCubit;

  // Thêm RouteObserver để theo dõi điều hướng
  static final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _homeCubit = HomeCubit();
    _homeCubit.refreshData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Đăng ký RouteAware với RouteObserver
    final ModalRoute? route = ModalRoute.of(context);
    if (route != null) {
      routeObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    // Hủy đăng ký RouteAware
    routeObserver.unsubscribe(this);
    WidgetsBinding.instance.removeObserver(this);
    _homeCubit.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _homeCubit.refreshData();
    }
  }

  // Được gọi khi HomeView quay lại sau khi một trang khác bị pop
  @override
  void didPopNext() {
    _homeCubit.refreshData(); // Làm mới dữ liệu khi quay lại
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>.value(
      value: _homeCubit,
      child: Scaffold(
        appBar: HomeAppBar(),
        endDrawer: const HomeDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(Routes.generate);
          },
          backgroundColor: XColors.primary,
          shape: const CircleBorder(),
          child: Padding(
            padding:
                const EdgeInsets.all(AppSize.s8).copyWith(top: AppSize.s12),
            child: Image.asset(
              'assets/icons/bot.png',
              fit: BoxFit.cover,
              color: XColors.neutral_9,
            ),
          ),
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async => _homeCubit.refreshData(),
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              slivers: [
                SliverToBoxAdapter(
                  child: const DateTimeList(),
                ),
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
        ),
      ),
    );
  }
}
