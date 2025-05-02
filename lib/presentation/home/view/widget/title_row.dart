import 'package:flutter/material.dart';
import 'package:study_tracker_mobile/presentation/resources/color_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/styles_manager.dart';

class TitleRow extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool hasMore;

  const TitleRow({
    super.key,
    required this.title,
    required this.onTap,
    this.hasMore = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (hasMore)
            TextButton(
              onPressed: onTap,
              child:  Text('View All', style: getRegularStyle(color: XColors.neutral_5 ),),
            ),
        ],
      ),
    );
  }
}
