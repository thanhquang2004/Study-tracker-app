import 'package:flutter/material.dart';
import 'package:study_tracker_mobile/presentation/resources/color_manager.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.transparent,
          valueColor: AlwaysStoppedAnimation<Color>(XColors.primary),
        ),
      ),
    );
  }
}
