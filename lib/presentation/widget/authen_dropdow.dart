import 'package:flutter/material.dart';
import 'package:study_tracker_mobile/presentation/resources/color_manager.dart';

class AuthenDropdown<T> extends StatelessWidget {
  final String label;
  final List<T> items;
  final T? value;
  final String? hint;
  final IconData? prefixIcon;
  final bool enabled;
  final void Function(T?) onChanged;

  const AuthenDropdown({
    super.key,
    required this.label,
    required this.items,
    this.value,
    this.hint,
    this.prefixIcon,
    this.enabled = true,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = Colors.grey;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonFormField<T>(
        padding: const EdgeInsets.symmetric(vertical: 12),
        value: (items.any((item) => item == value)) ? value : null,
        items: items
            .map((e) => DropdownMenuItem<T>(
                  value: e,
                  child: Text(e.toString()),
                ))
            .toList(),
        onChanged: enabled ? onChanged : null,
        hint: Text(hint ?? ''),
        style: TextStyle(
          fontSize: 18,
          color: XColors.neutral_1,
        ),
        icon: Icon(
          Icons.arrow_drop_down,
          color: XColors.neutral_1,
        ),
        isExpanded: true,
        decoration: const InputDecoration(
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
