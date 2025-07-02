import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import '../models/note_model.dart';

abstract class NotesRemoteDataSource {
  Future<List<NoteModel>> fetchNotes();
  Future<void> addNote(String text);
  Future<void> updateNote(String id, String text);
  Future<void> deleteNote(String id);
}

class NotesRemoteDataSourceImpl implements NotesRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;
  final Uuid uuid = const Uuid();

  NotesRemoteDataSourceImpl(this.firestore, this.firebaseAuth);

  String get _userId => firebaseAuth.currentUser!.uid;

  CollectionReference get _notesCollection =>
      firestore.collection('users').doc(_userId).collection('notes');

  @override
  Future<List<NoteModel>> fetchNotes() async {
    final querySnapshot = await _notesCollection
        .orderBy('createdAt', descending: true)
        .get();

    return querySnapshot.docs
        .map((doc) => NoteModel.fromJson(
              doc.data() as Map<String, dynamic>,
              doc.id,
            ))
        .toList();
  }

  @override
  Future<void> addNote(String text) async {
    final now = DateTime.now();
    final noteModel = NoteModel(
      id: uuid.v4(),
      text: text,
      createdAt: now,
      updatedAt: now,
    );

    await _notesCollection.doc(noteModel.id).set(noteModel.toJson());
  }

  @override
  Future<void> updateNote(String id, String text) async {
    await _notesCollection.doc(id).update({
      'text': text,
      'updatedAt': DateTime.now().toIso8601String(),
    });
  }

  @override
  Future<void> deleteNote(String id) async {
    await _notesCollection.doc(id).delete();
  }
}
