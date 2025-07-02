import '../../domain/entities/note.dart';
import '../../domain/repositories/notes_repository.dart';
import '../datasources/notes_remote_data_source.dart';

class NotesRepositoryImpl implements NotesRepository {
  final NotesRemoteDataSource remoteDataSource;

  NotesRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Note>> fetchNotes() {
    return remoteDataSource.fetchNotes();
  }

  @override
  Future<void> addNote(String text) {
    return remoteDataSource.addNote(text);
  }

  @override
  Future<void> updateNote(String id, String text) {
    return remoteDataSource.updateNote(id, text);
  }

  @override
  Future<void> deleteNote(String id) {
    return remoteDataSource.deleteNote(id);
  }
}
