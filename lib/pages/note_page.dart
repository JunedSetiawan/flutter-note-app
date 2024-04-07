import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:myapp/database/note_database.dart';
import 'package:myapp/models/note.dart';
import 'package:myapp/pages/add_edit_note_page.dart';
import 'package:myapp/pages/note_detail_page.dart';
import 'package:myapp/widgets/note_card_widget.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late List<Note> _notes;
  var isLoading = false;

  Future<void> _refreshNotes() async {
    setState(() {
      isLoading = true;
    });
    _notes = await NoteDatabase.instance.getAllNotes();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      floatingActionButton: FloatingActionButton(
  child: Icon(Icons.add),
  onPressed: () async {
    // final note = Note(
    //   isImportant: false,
    //   number: 1,
    //   title: 'Testing',
    //   description: 'Desc Testing',
    //   createdTime: DateTime.now(), // Note
    // );
    // await NoteDatabase.instance.create(note);
    await Navigator.push(context, MaterialPageRoute(builder: (context) => const AddEditNotePage()));
  
    _refreshNotes();
  },
),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : _notes.isEmpty ? Text('Notes Kosong')
          : MasonryGridView.count(
            crossAxisCount: 2, 
            itemCount: _notes.length,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            itemBuilder: (context, index) {
              final note = _notes[index];
              return GestureDetector(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NoteDetailPage(id: note.id!),
                    ),
                  );
                      _refreshNotes();
                },
                child: NoteCardWidget(note: note, index: index)
              );
            }
          )
    );
  }
}