import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:study_tracker_mobile/app/constant.dart';
import 'package:study_tracker_mobile/presentation/resources/assets_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/color_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/value_manager.dart';

class CustomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;

  const CustomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  /// Hàm tạo BottomNavigationBarItem với màu tự động thay đổi
  BottomNavigationBarItem buildNavItem(
      String iconPath, int index, BuildContext context) {
    final isSelected = selectedIndex == index;
    final color = isSelected ? XColors.primary : Colors.grey;

    return BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.only(top: 0.02 * Constants.deviceHeight),
        child: SvgPicture.asset(
          iconPath,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        ),
      ),
      label: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildBottomNavigationBar() {
      return Padding(
        padding: const EdgeInsets.all(AppSize.s12).copyWith(top: AppSize.s40),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // Màu bóng
                blurRadius: 2, // Độ mờ của bóng
                spreadRadius: 0, // Độ lan của bóng
                offset: const Offset(0, -1), // Hướng của bóng (lên trên)
              ),
            ],
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent, // Tắt hiệu ứng khi click
              highlightColor: Colors.transparent, // Tắt hiệu ứng khi click
              hoverColor: Colors.transparent, // Tắt hiệu ứng khi hover
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                currentIndex: selectedIndex,
                selectedItemColor: Theme.of(context).primaryColor,
                selectedFontSize: 0,
                unselectedFontSize: 0,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                elevation: 0,
                enableFeedback: false,
                useLegacyColorScheme: false,
                onTap: onTabSelected,
                items: [
                  buildNavItem(ImageAssets.homeIcon, 0, context),
                  buildNavItem(ImageAssets.userIcon, 1, context),
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget _buildFloatingActionButton() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              print('Push to bot screen');
            },
            child: Container(
              alignment: Alignment.center,
              width: 0.2 * Constants.deviceWidth,
              height: 0.092 * Constants.deviceHeight,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: XColors.primary,
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/bot.svg',
                  width: 0.075 * Constants.deviceWidth,
                  height: 0.075 * Constants.deviceWidth,
                  fit: BoxFit.contain,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Stack(
      children: [
        _buildBottomNavigationBar(),
        _buildFloatingActionButton(),
      ],
    );
  }
}
