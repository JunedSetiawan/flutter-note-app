import 'package:flutter/material.dart';
import 'package:myapp/database/note_database.dart';
import 'package:myapp/models/note.dart';
import 'package:myapp/widgets/note_form_widget.dart';

class AddEditNotePage extends StatefulWidget {
  const AddEditNotePage({super.key, this.note});

  final Note? note;

  @override
  State<AddEditNotePage> createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {
  late bool _isImportant;
  late int _number;
  late String _title;
  late String _description;
  final _formKey = GlobalKey<FormState>();
  var isUpdateForm = false;

  @override
  void initState() {
    super.initState();
    _isImportant = widget.note?.isImportant ?? false;
    _number = widget.note?.number ?? 0;
    _title = widget.note?.title ?? '';
    _description = widget.note?.description ?? '';
    isUpdateForm = widget.note != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdateForm ? 'Update Note' : 'Add Note'),
        actions: [
          _buildButtonSave()
        ],
      ),
      body: Form(
        key: _formKey,
        child: NoteFormWidget(isImportant: _isImportant, number: _number, title: _title, description: _description, onChangeIsImportant: (value) {
        setState(() {
          _isImportant = value;
    
        });
      }, onChangeNumber: (value) {
        setState(() {
          _number = value;
        });
      }, onChangeTitle: (value) {
        setState(() {
          _title = value;
        });
      }, onChangeDescription: (value) {
        setState(() {
          _description = value;
        });
      },
      )),
    );
  }

  Widget _buildButtonSave() {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    child: ElevatedButton(
      onPressed: () async {
          final isValid = _formKey.currentState!.validate();
          if (isValid) {
            if(isUpdateForm){
              await _updateNode();
            }else {
              await _addNote();
            }
            Navigator.of(context).pop();
          }
      },child: const Text('Save'),)
    );
  }

  Future<void> _addNote() async {
    final note = Note(isImportant: _isImportant, number: _number, title: _title, description: _description, createdTime: DateTime.now());
    await NoteDatabase.instance.create(note);
  }

  Future<void> _updateNode() async {
    final updateNote = Note(id: widget.note?.id, isImportant:_isImportant, number: _number, title: _title, description: _description, createdTime: DateTime.now());
    await NoteDatabase.instance.updateNote(updateNote); 
  }
}