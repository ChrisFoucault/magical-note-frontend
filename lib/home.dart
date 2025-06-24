import 'dart:math';

import '/api/note_api.dart';
import 'package:example_project_01/NoteEditorPage.dart';
import 'package:flutter/material.dart';
import '/model/note.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '笔记应用',
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '主页',
            style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: Colors.green,
      ),
      body: NoteCard(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 跳转到第二页
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>const NoteEditorPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class NoteCard extends StatefulWidget  {
  const NoteCard({super.key});

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  List<Note> noteList = [];

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  Future<void> loadNotes() async {
    final notes = await NoteApi.listPreviewNote(1);
    setState(() {
      noteList = notes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: noteList.length,
      itemBuilder: (context, index) {
        final note = noteList[index];
        return Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: const Icon(Icons.note),
            title: Text(note.title ?? '无标题'),
            subtitle: Text(note.noteDetail.blocks[0]['content'] ?? '无内容'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('你点击了 ${note.title}')),
              );
            },
          ),
        );
      },
    );
  }
}
