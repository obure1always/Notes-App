import '../../repositories/notes_repository.dart';

class AddNoteUseCase {
  final NotesRepository repository;

  AddNoteUseCase(this.repository);

  Future<void> call(String text) {
    return repository.addNote(text);
  }
}
