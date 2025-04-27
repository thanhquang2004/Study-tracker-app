import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_tracker_mobile/domain/model/note.dart';
import 'package:flutter/material.dart';
import 'package:study_tracker_mobile/presentation/notes/cubit/create_note_cubit.dart';
import 'package:study_tracker_mobile/presentation/resources/color_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/styles_manager.dart';

class CreateNoteView extends StatelessWidget {
  const CreateNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    final Map<String, String> colorMap = {
      'Red': '#FF0000',
      'Green': '#00FF00',
      'Blue': '#0000FF',
      'Yellow': '#FFFF00',
      'Purple': '#800080',
    };
    String selectedColor = colorMap.keys.first;

    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(titleController, 'Title'),
            SizedBox(height: 16),
            _buildTextField(contentController, 'Content', maxLines: 5),
            SizedBox(height: 16),
            _buildColorDropdown(colorMap, selectedColor, (value) {
              if (value != null) {
                selectedColor = value;
              }
            }),
            SizedBox(height: 16),
            _buildSaveButton(context, titleController, contentController,
                colorMap[selectedColor]!),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('Create Note'),
      backgroundColor: XColors.primary,
      foregroundColor: XColors.neutral_8,
    );
  }

  TextField _buildTextField(TextEditingController controller, String label,
      {int maxLines = 1}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: XColors.primary),
        ),
      ),
      maxLines: maxLines,
    );
  }

  DropdownButtonFormField<String> _buildColorDropdown(
      Map<String, String> colorMap,
      String selectedColor,
      ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      value: selectedColor,
      decoration: InputDecoration(
        labelText: 'Color',
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: XColors.primary),
        ),
      ),
      items: colorMap.keys.map((color) {
        return DropdownMenuItem(
          value: color,
          child: Text(color),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  Center _buildSaveButton(
      BuildContext context,
      TextEditingController titleController,
      TextEditingController contentController,
      String colorCode) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: XColors.primary,
          foregroundColor: XColors.neutral_8,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: getBoldStyle(color: XColors.neutral_8),
        ),
        onPressed: () {
          context.read<CreateNoteCubit>().createNote(
                titleController.text,
                contentController.text,
                colorCode,
              );
          Navigator.pop(context);
        },
        child: Text('Save'),
      ),
    );
  }
}
