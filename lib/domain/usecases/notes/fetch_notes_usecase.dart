import '../../entities/note.dart';
import '../../repositories/notes_repository.dart';

class FetchNotesUseCase {
  final NotesRepository repository;

  FetchNotesUseCase(this.repository);

  Future<List<Note>> call() {
    return repository.fetchNotes();
  }
}
