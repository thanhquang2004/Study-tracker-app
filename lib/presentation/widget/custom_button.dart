import 'package:flutter/material.dart';
import 'package:study_tracker_mobile/app/constant.dart';
import 'package:study_tracker_mobile/presentation/resources/color_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/font_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/styles_manager.dart';

enum ButtonType { elevated, outlined, text }

class CustomButton extends StatelessWidget {
  final String title; //Nội dung trên nút
  final VoidCallback? onPressed; //Sự kiện khi nhấn nút
  final ButtonType type; //Loại nút (elevated, outlined, text)
  final double? width; //Chiều rộng (tùy chọn)
  final double? height; //Chiều cao (tùy chọn)
  final Color? backgroundColor; //Màu nền nút
  final Color? textColor;
  final double? fontSize; //Màu chữ trên nút
  final Color? borderColor; //Màu viền (chỉ áp dụng cho outlined)
  final double borderRadius; //Độ bo góc
  final IconData? icon; //Icon hiển thị (nếu có)
  final bool iconRight; //Icon bên phải thay vì trái
  final bool isDisabled; //Vô hiệu hóa nút
  final bool enableSplash; //Bật/tắt hiệu ứng splash

  const CustomButton({
    Key? key,
    required this.title,
    this.onPressed,
    this.type = ButtonType.elevated,
    this.width,
    this.height,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.borderColor,
    this.borderRadius = 15.0,
    this.icon,
    this.iconRight = false,
    this.isDisabled = false,
    this.enableSplash = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Xác định màu sắc theo loại button
    final Color finalBgColor = backgroundColor ??
        (type == ButtonType.elevated ? XColors.primary : Colors.transparent);
    final Color finalTextColor = textColor ??
        (type == ButtonType.elevated ? Colors.white : XColors.primary);
    final double finalFontSize = fontSize ?? FontSize.s16;
    final Color finalBorderColor = borderColor ?? XColors.primary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isDisabled ? null : onPressed, //Vô hiệu hóa nếu cần
        borderRadius: BorderRadius.circular(borderRadius),
        splashColor: enableSplash ? null : Colors.transparent,
        highlightColor: enableSplash ? null : Colors.transparent,
        child: Container(
          width: type == ButtonType.text
              ? null
              : (width ??
                  Constants.deviceWidth * 0.8), //Text button không đặt width
          height: type == ButtonType.text
              ? null
              : (height ??
                  Constants.deviceHeight * 0.06), //Text button không đặt height
          padding: type == ButtonType.text
              ? const EdgeInsets.symmetric(
                  horizontal: 8, vertical: 4) //Gọn gàng khi là text button
              : const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: type == ButtonType.elevated
                ? finalBgColor
                : Colors.transparent, //Chỉ có màu nền nếu là elevated
            border: type == ButtonType.outlined
                ? Border.all(color: finalBorderColor, width: 2)
                : null, //Chỉ có viền nếu là outlined
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min, //Đảm bảo nút chỉ vừa với nội dung
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null && !iconRight) ...[
                Icon(icon, color: finalTextColor, size: 20),
                const SizedBox(width: 6),
              ],
              Text(title,
                  style: getSemiBoldStyle(
                    color: finalTextColor,
                    fontSize: finalFontSize,
                  )),
              if (icon != null && iconRight) ...[
                const SizedBox(width: 6),
                Icon(icon, color: finalTextColor, size: 20),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
