import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class DashboardState extends Equatable {
  final List<Widget> pages;
  final int selectedIndex;

  DashboardState({
    required this.pages,
    this.selectedIndex = 0,
  });

  DashboardState copyWith({
    List<Widget>? pages,
    int? selectedIndex,
  }) {
    return DashboardState(
      pages: pages ?? this.pages,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object> get props => [selectedIndex];
}
