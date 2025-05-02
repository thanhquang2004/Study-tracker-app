import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:study_tracker_mobile/presentation/resources/color_manager.dart';

class ShimmerLoading extends StatelessWidget {
  final Axis direction; // Hướng hiển thị: ngang hoặc dọc
  final double titleWidth; // Chiều rộng tiêu đề
  final double titleHeight; // Chiều cao tiêu đề
  final double itemHeight; // Chiều cao mỗi item
  final double itemWidth; // Chiều rộng mỗi item (dùng khi direction là horizontal)
  final int itemCount; // Số lượng item giả lập
  final bool showTitle; // Có hiển thị tiêu đề không

  const ShimmerLoading({
    super.key,
    this.direction = Axis.vertical,
    this.titleWidth = 100,
    this.titleHeight = 20,
    this.itemHeight = 80,
    this.itemWidth = 150,
    this.itemCount = 3,
    this.showTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: XColors.neutral_6.withOpacity(0.5),
      highlightColor: XColors.neutral_6.withOpacity(0.2),
      child: direction == Axis.vertical
          ? _buildVerticalLayout(context)
          : _buildHorizontalLayout(context),
    );
  }

  Widget _buildVerticalLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showTitle)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              width: titleWidth,
              height: titleHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: index == itemCount - 1 ? 0 : 16,
              ),
              child: Container(
                height: itemHeight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                // Mô phỏng nội dung bên trong (nếu cần)
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 150,
                        height: 16,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        height: 12,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildHorizontalLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showTitle)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              width: titleWidth,
              height: titleHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        SizedBox(
          height: itemHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  right: index == itemCount - 1 ? 0 : 16,
                ),
                child: Container(
                  width: itemWidth,
                  height: itemHeight,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}