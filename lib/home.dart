import 'dart:math';

import 'package:example_project_01/NoteEditorPage.dart';
import 'package:flutter/material.dart';
import '../api/user.dart';

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

class NoteCard extends StatelessWidget {
  const NoteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: List.generate(5, (index) {
        return Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: const Icon(Icons.note),
            title: Text('笔记 $index'),
            subtitle: Text('笔记内容'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('你点击了第 $index 张卡片')),
              );
              UserApi.login(
                  123
              ).then((res) {
              });
            },
          ),
        );
      }),
    );
  }
}
