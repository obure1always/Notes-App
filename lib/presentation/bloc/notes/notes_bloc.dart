import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/note.dart';
import '../../../domain/usecases/notes/add_note_usecase.dart';
import '../../../domain/usecases/notes/delete_note_usecase.dart';
import '../../../domain/usecases/notes/fetch_notes_usecase.dart';
import '../../../domain/usecases/notes/update_note_usecase.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final AddNoteUseCase addNoteUseCase;
  final DeleteNoteUseCase deleteNoteUseCase;
  final FetchNotesUseCase fetchNotesUseCase;
  final UpdateNoteUseCase updateNoteUseCase;

  NotesBloc({
    required this.addNoteUseCase,
    required this.deleteNoteUseCase,
    required this.fetchNotesUseCase,
    required this.updateNoteUseCase,
  }) : super(NotesInitial()) {
    on<FetchNotesEvent>(_onFetchNotes);
    on<AddNoteEvent>(_onAddNote);
    on<UpdateNoteEvent>(_onUpdateNote);
    on<DeleteNoteEvent>(_onDeleteNote);
  }

  Future<void> _onFetchNotes(FetchNotesEvent event, Emitter<NotesState> emit) async {
    emit(NotesLoading());
    try {
      final notes = await fetchNotesUseCase();
      emit(NotesLoaded(notes));
    } catch (e) {
      emit(NotesError('Failed to fetch notes'));
    }
  }

  Future<void> _onAddNote(AddNoteEvent event, Emitter<NotesState> emit) async {
    try {
      await addNoteUseCase(event.text);
      add(FetchNotesEvent());
      emit(NotesSuccess('Note added successfully'));
    } catch (e) {
      emit(NotesError('Failed to add note'));
    }
  }

  Future<void> _onUpdateNote(UpdateNoteEvent event, Emitter<NotesState> emit) async {
    try {
      await updateNoteUseCase(event.id, event.text);
      add(FetchNotesEvent());
      emit(NotesSuccess('Note updated successfully'));
    } catch (e) {
      emit(NotesError('Failed to update note'));
    }
  }

  Future<void> _onDeleteNote(DeleteNoteEvent event, Emitter<NotesState> emit) async {
    try {
      await deleteNoteUseCase(event.id);
      add(FetchNotesEvent());
      emit(NotesSuccess('Note deleted successfully'));
    } catch (e) {
      emit(NotesError('Failed to delete note'));
    }
  }
}
