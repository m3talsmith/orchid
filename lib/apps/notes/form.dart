import 'package:flutter/material.dart';
import 'model.dart';
import 'dart:developer';

class NotesForm extends StatefulWidget {
  const NotesForm({super.key, required this.note});

  final Note note;

  @override
  State<NotesForm> createState() => _NotesFormState();
}

class _NotesFormState extends State<NotesForm> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text =
        widget.note.title ?? DateTime.now().toIso8601String();
    contentController.text = widget.note.content ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final contentSpan = TextSpan(text: contentController.text);
    final contentPainter = TextPainter(
      text: contentSpan,
      textDirection: TextDirection.ltr,
    );
    contentPainter.layout();

    return Column(
      children: [
        Text('Editing Note'),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: titleController,
            decoration: InputDecoration(hintText: 'Title'),
            onSubmitted: (value) {},
          ),
        ),
        TextField(
          controller: contentController,
          decoration: InputDecoration(
            hintText: 'Content',
            border: OutlineInputBorder(),
          ),
          minLines: 1,
          maxLines: contentPainter.preferredLineHeight.toInt(),
        ),
      ],
    );
  }
}
