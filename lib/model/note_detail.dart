import 'dart:ffi';

class NoteDetail {
  final String id;
  final String title;
  final List<Map<String, String>> blocks;

  NoteDetail({required this.id, required this.title, required this.blocks});

  factory NoteDetail.fromJson(Map<String, dynamic> json) {
    return NoteDetail(
      id: json['id'],
      title: json['title'],
      blocks: (json['blocks'] as List)
          .map((e) => Map<String, String>.from(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'blocks': blocks,
    };
  }
}
