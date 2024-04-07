import 'package:flutter/material.dart';

class NoteFormWidget extends StatelessWidget {
  const NoteFormWidget({super.key, required this.isImportant, required this.number, required this.title, required this.description, required this.onChangeIsImportant, required this.onChangeNumber, required this.onChangeTitle, required this.onChangeDescription});
  final bool isImportant;
  final int number;
  final String title;
  final String description;
  final ValueChanged<bool> onChangeIsImportant;
  final ValueChanged<int> onChangeNumber;
  final ValueChanged<String> onChangeTitle;
  final ValueChanged<String> onChangeDescription;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Switch(value: isImportant, onChanged: onChangeIsImportant),
                Expanded(child: Slider(
                  min: 0,
                  max: 5,
                  divisions: 5,
                  value: number.toDouble(), onChanged: ((value) => value.toInt()))
                )
              ],
            ),
            _buildTitileField(),
            SizedBox(height: 8,),
            _buildDescriptionField(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitileField(){
    return TextFormField(
      maxLines: 1,
      initialValue: title,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Title',
      ),
      onChanged: onChangeTitle,
      validator: (title) {
        return title == null || title.isEmpty ? 'Title is required' : null;
      },
    );
  }

   Widget _buildDescriptionField(){
    return TextFormField(
      maxLines: 1,
      initialValue: description,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'description',
      ),
      onChanged: onChangeDescription,
      validator: (description) {
        return description == null || description.isEmpty ? 'description is required' : null;
      },
    );
  }
}