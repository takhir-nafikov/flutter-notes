import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notes/models/Note.dart';
import 'package:notes/providers/NoteCollection.dart';
import 'package:provider/provider.dart';

class NoteScreen extends StatefulWidget {
  final Note _note;
  NoteScreen({Key key, note}) : _note = note;

  @override
  State<StatefulWidget> createState() {
    return NoteScreenState(
      note: _note
    );
  }
}

class NoteScreenState extends State<NoteScreen> {
  final Note _note;
  NoteScreenState({Key key, note}) : _note = note;

  final TextEditingController bodyController = TextEditingController();

  void initState() {
    super.initState();

    bodyController.text = _note.body;

    bodyController.addListener(() {
      Provider.of<NoteCollection>(context).updateNote(
        _note.id,
        bodyController.text
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<NoteCollection>(
          builder: (context, notes, child) {
            return Text(
              notes.getNote(_note.id).noteBody
            );
          },
        ),
      ),
      
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: TextField(
                controller: bodyController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  hintText: 'Start Writing your note here',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(20)
                ),
              ),
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(minWidth: double.infinity),
            child: Container (
              child: Consumer<NoteCollection>(
                builder: (context, notes, child) {
                  Note note = notes.getNote(_note.id);

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '${note.characters} characters',
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                      Text(
                        '${note.words} words',
                        style: TextStyle(
                          color: Colors.white
                        ),
                      )
                    ],
                  );
                },
              ),
              decoration: BoxDecoration(
                color: Colors.blue
              ),
              padding: EdgeInsets.all(20),
            ),
          )
        ],
      ),
    );
  }
}