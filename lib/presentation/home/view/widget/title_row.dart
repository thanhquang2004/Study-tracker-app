// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:study_tracker_mobile/presentation/resources/color_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/styles_manager.dart';

class TitleRow extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool hasMore;
  final Widget? orther;

  const TitleRow({
    super.key,
    required this.title,
    this.onTap,
    this.hasMore = true,
    this.orther,
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
              child: Text(
                'View All',
                style: getRegularStyle(color: XColors.neutral_5),
              ),
            ),
          if (orther != null) orther!,
        ],
      ),
    );
  }
}
