import 'package:dio/dio.dart';
import '../model/note.dart';
import '../utils//http_service.dart';

class NoteApi {
  static Future<List<Note>> fetchNotes() async {
    final res = await HttpService.get('/api/notes');
    return (res.data as List).map((e) => Note.fromJson(e)).toList();
  }

  static Future<Note> createNote(Note note) async {
    final res = await HttpService.post('/api/notes', data: note.toJson());
    return Note.fromJson(res.data);
  }

  static Future<Note> updateNote(Note note) async {
    final res = await HttpService.put('/api/notes/${note.id}', data: note.toJson());
    return Note.fromJson(res.data);
  }

  static Future<void> deleteNote(String id) async {
    await HttpService.delete('/api/notes/$id');
  }
}
