import 'package:flutter/material.dart';
import 'package:study_tracker_mobile/presentation/resources/color_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/value_manager.dart';

enum InputSize { small, medium, large }

enum InputColor { defaultColor, success, warning, error }

class AuthenTextField extends StatefulWidget {
  final String label;
  final String? hint;
  final bool enabled;
  final bool isPassword;
  final IconData? prefixIcon;
  final InputSize size;
  final InputColor color;
  final TextEditingController? controller;

  const AuthenTextField({
    super.key,
    required this.label,
    this.hint,
    this.enabled = true,
    this.isPassword = false,
    required this.prefixIcon,
    this.size = InputSize.medium,
    this.color = InputColor.defaultColor,
    this.controller,
  });

  @override
  _AuthenTextFieldState createState() => _AuthenTextFieldState();
}

class _AuthenTextFieldState extends State<AuthenTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    // Xác định kích thước input
    double fontSize;
    double padding;
    switch (widget.size) {
      case InputSize.small:
        fontSize = 14;
        padding = 8;
        break;
      case InputSize.medium:
        fontSize = 16;
        padding = 12;
        break;
      case InputSize.large:
        fontSize = 18;
        padding = 16;
        break;
    }

    // Xác định màu sắc theo trạng thái
    Color borderColor;
    switch (widget.color) {
      case InputColor.success:
        borderColor = Colors.green;
        break;
      case InputColor.warning:
        borderColor = Colors.orange;
        break;
      case InputColor.error:
        borderColor = Colors.red;
        break;
      default:
        borderColor = Colors.grey;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSize.s8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: widget.controller,
            enabled: widget.enabled,
            obscureText: widget.isPassword ? _obscureText : false,
            style: TextStyle(fontSize: fontSize),
            decoration: InputDecoration(
              hintText: widget.hint,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12, vertical: padding),
              prefixIcon: Icon(widget.prefixIcon, color: XColors.neutral_1),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: XColors.neutral_1,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: borderColor, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: borderColor, width: 1),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: borderColor, width: 0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
