import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:notes/models/Note.dart';
import 'package:notes/providers/NoteCollection.dart';
import 'package:notes/screens/NoteScreen.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatelessWidget {
  var collection = NoteCollection();
  var uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<NoteCollection>(
          builder: (context, notes, child) {
            if (notes.count == 0) {
              return Text('Notes');
            }

            return Text('Notes (${notes.count})');
          },
        ),
      ),

      body: _buildNoteList(),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()  {
          Note _note = Note(
            id: uuid.v4()
          );

          Provider.of<NoteCollection>(context).addNote(_note);

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NoteScreen(
                  note: _note
              )
            )
          );
        },
      ),
    );
  }

  Widget _buildNoteList() {
    return Consumer<NoteCollection>(
      builder: (context, notes, child) {
        var allNotes = notes.allNotes;

        if (allNotes.length == 0) {
          return Center(
            child: Text('No notes'),
          );
        }

        return ListView.builder(
          itemCount: allNotes.length,
          itemBuilder: (context, index) {
            var note = allNotes[index];

            return Dismissible(
              key: Key(note.id),
              onDismissed: (direction) {
                Provider.of<NoteCollection>(context).deleteNote(note.id);
              },
              background: Container(
                color: Colors.red
              ),
              child: ListTile(
                title: Text(note.body),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => NoteScreen(
                            note: note,
                          )
                      )
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}