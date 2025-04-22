import 'package:flutter/material.dart';
import 'package:study_tracker_mobile/presentation/resources/color_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/styles_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/value_manager.dart';

enum HomeAppBarAction {
  profile,
  editProfile,
  notifications,
  settings,
  logout,
}

class HomeAppBarActions {
  static List<PopupMenuEntry<HomeAppBarAction>> buildPopupMenuItems() {
    return [
      _buildPopupMenuItem(
        action: HomeAppBarAction.profile,
        icon: Icons.person,
        label: 'Profile',
      ),
      _buildPopupMenuItem(
        action: HomeAppBarAction.editProfile,
        icon: Icons.edit,
        label: 'Edit Profile',
      ),
      _buildPopupMenuItem(
        action: HomeAppBarAction.settings,
        icon: Icons.settings,
        label: 'Settings',
      ),
      const PopupMenuDivider(),
      _buildPopupMenuItem(
        action: HomeAppBarAction.logout,
        icon: Icons.logout,
        label: 'Logout',
        isDanger: true,
      ),
    ];
  }

  static PopupMenuItem<HomeAppBarAction> _buildPopupMenuItem({
    required HomeAppBarAction action,
    required IconData icon,
    required String label,
    bool isDanger = false,
  }) {
    return PopupMenuItem<HomeAppBarAction>(
      value: action,
      height: AppSize.s48,
      child: Row(
        children: [
          Icon(
            icon,
            size: AppSize.s24,
            color: isDanger ? XColors.semanticError : null,
          ),
          SizedBox(width: AppSize.s8),
          Text(
            label,
            style: isDanger
                ? getRegularStyle(color: XColors.semanticError)
                : getRegularStyle(color: XColors.neutral_1),
          ),
        ],
      ),
    );
  }

  static void handleAction(BuildContext context, HomeAppBarAction action) {
    switch (action) {
      case HomeAppBarAction.profile:
        _navigateToProfile(context);
        break;
      case HomeAppBarAction.editProfile:
        _navigateToEditProfile(context);
        break;
      case HomeAppBarAction.notifications:
        _navigateToNotifications(context);
        break;
      case HomeAppBarAction.settings:
        _navigateToSettings(context);
        break;
      case HomeAppBarAction.logout:
        _showLogoutDialog(context);
        break;
    }
  }

  static void _navigateToProfile(BuildContext context) {
    // TODO: Implement navigation
    print('Navigate to profile');
  }

  static void _navigateToEditProfile(BuildContext context) {
    // TODO: Implement navigation
    print('Navigate to edit profile');
  }

  static void _navigateToNotifications(BuildContext context) {
    // TODO: Implement navigation
    print('Navigate to notifications');
  }

  static void _navigateToSettings(BuildContext context) {
    // TODO: Implement navigation
    print('Navigate to settings');
  }

  static void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout', style: getBoldStyle(color: XColors.neutral_1)),
        content: Text(
          'Are you sure you want to logout?',
          style: getRegularStyle(color: XColors.neutral_1),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel',
                style: getRegularStyle(color: XColors.neutral_1)),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement logout functionality
              print('Logout');
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
