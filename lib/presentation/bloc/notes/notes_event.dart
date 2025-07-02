part of 'notes_bloc.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

class FetchNotesEvent extends NotesEvent {}

class AddNoteEvent extends NotesEvent {
  final String text;

  const AddNoteEvent(this.text);

  @override
  List<Object> get props => [text];
}

class UpdateNoteEvent extends NotesEvent {
  final String id;
  final String text;

  const UpdateNoteEvent({required this.id, required this.text});

  @override
  List<Object> get props => [id, text];
}

class DeleteNoteEvent extends NotesEvent {
  final String id;

  const DeleteNoteEvent(this.id);

  @override
  List<Object> get props => [id];
}
