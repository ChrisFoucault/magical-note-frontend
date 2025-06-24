import 'dart:ffi';
import 'dart:math';

import 'package:example_project_01/model/note_detail.dart';

class Note {
  final int id;
  final String title;
  final NoteDetail noteDetail;

  Note({required this.id, required this.title, required this.noteDetail});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      title: json['title'],
      noteDetail: NoteDetail.fromJson(json['noteDetail']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'noteDetail': noteDetail.toJson(),
    };
  }
}
