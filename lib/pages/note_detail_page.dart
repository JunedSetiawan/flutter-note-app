import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/database/note_database.dart';
import 'package:myapp/models/note.dart';
import 'package:myapp/pages/add_edit_note_page.dart';

class NoteDetailPage extends StatefulWidget {
  const NoteDetailPage({super.key, required this.id});

  final int id;

  @override
  State<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late Note _note;
  var isLoading = false;

  Future<void> _refreshNote() async {
    setState(() {
      isLoading = true;
    });
    _note = await NoteDatabase.instance.getNoteById(widget.id);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshNote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Note'),
        actions: [
          _editButton(),
          _deleteButton()
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
            padding: const EdgeInsets.all(8),
            children: [
              Text(
                _note.title, style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),

              ),
              const SizedBox(height: 8,),
              Text(DateFormat.yMMMd().format(_note.createdTime)),
              const SizedBox(height: 8,),
              Text(_note.description, style: TextStyle(
                fontSize: 18,
              ),)
            ]
          )
    );
  }
  

  Widget _editButton(){
    return IconButton(onPressed: () async {
      if (isLoading) return;
      await Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditNotePage(note: _note)));
      _refreshNote();
    }, icon: Icon(Icons.edit));
  }

  Widget _deleteButton() {
    return IconButton(onPressed: () async {
      if (isLoading) return;
        // await NoteDatabase.instance.deleteNoteById(widget.id);
        // Navigator.pop(context);
        _refreshNote();
        await NoteDatabase.instance.deleteNoteById(widget.id);
        Navigator.pop(context);
      }, icon: Icon(Icons.delete));
    }
}