import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:study_tracker_mobile/domain/model/schedule.dart';
import 'package:study_tracker_mobile/presentation/resources/color_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/styles_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/value_manager.dart';
import 'package:study_tracker_mobile/presentation/schedules/cubit/schedules_cubit.dart';
import 'package:study_tracker_mobile/presentation/schedules/cubit/schedules_state.dart';
import 'package:study_tracker_mobile/presentation/widget/confirm_dialog.dart';
import 'package:study_tracker_mobile/presentation/widget/loading_dialog.dart';
import 'package:get_it/get_it.dart';

class SchedulesView extends StatelessWidget {
  final Schedule? schedule;

  const SchedulesView({super.key, this.schedule});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = SchedulesCubit(schedule);
        cubit.initializeForm();
        return cubit;
      },
      child: const ScheduleContent(),
    );
  }
}

class ScheduleContent extends StatelessWidget {
  const ScheduleContent({super.key});

  static final Map<String, String> _categories = {
    "work": "#FF5733",
    "study": "#33FF57",
    "meeting": "#3357FF",
    "personal": "#FF33A1",
    "health": "#33A1FF",
    "family": "#A133FF",
    "entertainment": "#FFA133",
  };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SchedulesCubit, SchedulesState>(
      builder: (context, state) {
        return Scaffold(
          appBar: _buildAppBar(context, state),
          body: _buildBody(context, state),
          floatingActionButton: _buildFloatingActionButton(context, state),
        );
      },
    );
  }

  AppBar _buildAppBar(BuildContext context, SchedulesState state) {
    return AppBar(
      title: Text(
        state.schedule == null ? 'New Schedule' : 'Schedule',
      ),
      backgroundColor: XColors.primary,
      iconTheme: const IconThemeData(color: XColors.neutral_9),
      actions: [
        IconButton(
          icon: Icon(
            state.isEditMode ? Icons.check : Icons.edit,
            color: XColors.neutral_9,
          ),
          tooltip: state.isEditMode ? 'Save' : 'Edit',
          onPressed: () async {
            if (state.isEditMode) {
              final storage = GetIt.instance.get<FlutterSecureStorage>();
              final userId = await storage.read(key: 'userId') ?? '';
              const roadmapId = '';
              context.read<SchedulesCubit>().saveSchedule(userId, roadmapId);
            } else {
              context.read<SchedulesCubit>().toggleEditMode();
            }
          },
        ),
        if (state.schedule != null)
          IconButton(
            icon: const Icon(Icons.delete, color: XColors.semanticError),
            tooltip: 'Delete',
            onPressed: () => _showDeleteConfirmation(context),
          ),
      ],
    );
  }

  Widget _buildBody(BuildContext context, SchedulesState state) {
    if (state.isLoading) {
      return Scaffold(
        body: const Center(
          child: LoadingDialog(),
        ),
      );
    }
    if (state.errorMessage != null) {
      return Scaffold(
        body: Center(
          child: Text('Error: ${state.errorMessage}'),
        ),
      );
    }
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: state.isEditMode ? _buildEditMode(context, state) : _buildViewMode(context, state),
    );
  }

  Widget _buildEditMode(BuildContext context, SchedulesState state) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitleField(context, state),
            const SizedBox(height: 16),
            _buildDescriptionField(context, state),
            const SizedBox(height: 16),
            _buildDateTimePickers(context, state),
            const SizedBox(height: 16),
            _buildAllDaySwitch(context, state),
            const SizedBox(height: 16),
            _buildCategorySelector(context, state),
          ],
        ),
      ),
    );
  }

  Widget _buildViewMode(BuildContext context, SchedulesState state) {
    final dateFormat = DateFormat('EEE, MMM dd, yyyy, h:mm a');
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    state.title,
                    style: getBoldStyle(fontSize: AppSize.s24),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Color(int.parse(state.color.substring(1), radix: 16) | 0xFF000000),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    StringExtension(state.category).capitalizeFirst!,
                    style: getRegularStyle(color: XColors.neutral_9, fontSize: AppSize.s14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildDetailItem('Start', dateFormat.format(state.startDate!)),
            _buildDetailItem('End', dateFormat.format(state.endDate!)),
            _buildDetailItem('All Day', state.allDay ? 'Yes' : 'No'),
            _buildDetailItem('Category', StringExtension(state.category).capitalizeFirst!),
            if (state.description.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                'Description',
                style: getBoldStyle(fontSize: AppSize.s16),
              ),
              const SizedBox(height: 8),
              Text(
                state.description,
                style: getRegularStyle(fontSize: AppSize.s14),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTitleField(BuildContext context, SchedulesState state) {
    return TextField(
      onChanged: (value) => context.read<SchedulesCubit>().updateTitle(value),
      decoration: InputDecoration(
        labelText: 'Title',
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: XColors.primary),
        ),
        errorText: state.isTitleValid ? null : 'Required',
      ),
      controller: TextEditingController(text: state.title),
    );
  }

  Widget _buildDescriptionField(BuildContext context, SchedulesState state) {
    return TextField(
      onChanged: (value) => context.read<SchedulesCubit>().updateDescription(value),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: XColors.primary),
        ),
      ),
      maxLines: 5,
      controller: TextEditingController(text: state.description),
    );
  }

  Widget _buildDateTimePickers(BuildContext context, SchedulesState state) {
    final dateFormat = DateFormat('EEE, MMM dd, yyyy');
    final timeFormat = DateFormat('h:mm a');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Date & Time', style: getBoldStyle(fontSize: AppSize.s16)),
        const SizedBox(height: 8),
        Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.calendar_today, color: XColors.primary),
                title: Text(
                  'Start: ${dateFormat.format(state.startDate!)}, ${timeFormat.format(state.startDate!)}',
                  style: getMediumStyle(fontSize: AppSize.s12),
                ),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: state.startDate!,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  );
                  if (date != null) {
                    context.read<SchedulesCubit>().updateStartDate(date);
                  }
                  if (!state.allDay) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(state.startDate!),
                    );
                    if (time != null) {
                      context.read<SchedulesCubit>().updateStartTime(time);
                    }
                  }
                },
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.calendar_today, color: XColors.primary),
                title: Text(
                  'End: ${dateFormat.format(state.endDate!)}, ${timeFormat.format(state.endDate!)}',
                  style: getMediumStyle(fontSize: AppSize.s12),
                ),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: state.endDate!,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  );
                  if (date != null) {
                    context.read<SchedulesCubit>().updateEndDate(date);
                  }
                  if (!state.allDay) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(state.endDate!),
                    );
                    if (time != null) {
                      context.read<SchedulesCubit>().updateEndTime(time);
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAllDaySwitch(BuildContext context, SchedulesState state) {
    return Row(
      children: [
        Text('All Day', style: getBoldStyle(fontSize: AppSize.s16)),
        const Spacer(),
        Switch(
          value: state.allDay,
          onChanged: (value) => context.read<SchedulesCubit>().toggleAllDay(value),
          activeColor: XColors.primary,
        ),
      ],
    );
  }

  Widget _buildCategorySelector(BuildContext context, SchedulesState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Category', style: getBoldStyle(fontSize: AppSize.s16)),
        const SizedBox(height: 8),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 2.5,
          children: _categories.entries.map((entry) {
            final isSelected = state.category == entry.key;
            return GestureDetector(
              onTap: () {
                context.read<SchedulesCubit>().selectCategory(entry.key, entry.value);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Color(int.parse(entry.value.substring(1), radix: 16) | 0xFF000000)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Color(int.parse(entry.value.substring(1), radix: 16) | 0xFF000000),
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    StringExtension(entry.key).capitalizeFirst!,
                    style: getRegularStyle(
                      color: isSelected ? XColors.neutral_9 : XColors.neutral_1,
                      fontSize: AppSize.s14,
                    ).copyWith(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDetailItem(String label, String value) {
    if (value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: getBoldStyle(fontSize: AppSize.s14),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: getRegularStyle(fontSize: AppSize.s14),
            ),
          ),
        ],
      ),
    );
  }

  Widget? _buildFloatingActionButton(BuildContext context, SchedulesState state) {
    if (state.schedule == null && !state.isEditMode) {
      return FloatingActionButton(
        onPressed: () async {
          final storage = GetIt.instance.get<FlutterSecureStorage>();
          final userId = await storage.read(key: 'userId') ?? '';
          const roadmapId = '';
          context.read<SchedulesCubit>().saveSchedule(userId, roadmapId);
        },
        backgroundColor: XColors.primary,
        tooltip: 'Save Schedule',
        child: const Icon(Icons.save, color: XColors.neutral_9),
      );
    }
    return null;
  }

  void _showDeleteConfirmation(BuildContext context) {
    final schedule = context.read<SchedulesCubit>().state.schedule;
    if (schedule == null) return;

    Get.dialog(
      ConfirmAlert(
        title: 'Delete',
        content: 'Are you sure you want to delete this schedule?',
        onConfirm: () {
          context.read<SchedulesCubit>().deleteSchedule(schedule.id!);
          Get.back(); // Close dialog
          Get.back(); // Return to previous screen
        },
      ),
    );
  }
}

extension StringExtension on String {
  String? get capitalizeFirst {
    if (isEmpty) return null;
    return this[0].toUpperCase() + substring(1);
  }
}
