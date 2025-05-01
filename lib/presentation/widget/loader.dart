import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:study_tracker_mobile/presentation/resources/color_manager.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: XColors.primary,
        size: 50,
      ),
    );
  }
}


Widget noDataWidget = Center(
  child: SizedBox(
      height: 300,
      width: 400,
      child: Image.asset('assets/icons/icon_no_data.png')),
);