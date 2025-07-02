import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/datasources/notes_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/notes_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/notes_repository.dart';
import '../../domain/usecases/auth/login_usecase.dart';
import '../../domain/usecases/auth/signup_usecase.dart';
import '../../domain/usecases/auth/logout_usecase.dart';
import '../../domain/usecases/notes/add_note_usecase.dart';
import '../../domain/usecases/notes/delete_note_usecase.dart';
import '../../domain/usecases/notes/fetch_notes_usecase.dart';
import '../../domain/usecases/notes/update_note_usecase.dart';
import '../../presentation/bloc/auth/auth_bloc.dart';
import '../../presentation/bloc/notes/notes_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<NotesRemoteDataSource>(
    () => NotesRemoteDataSourceImpl(sl(), sl()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<NotesRepository>(
    () => NotesRepositoryImpl(sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => AddNoteUseCase(sl()));
  sl.registerLazySingleton(() => DeleteNoteUseCase(sl()));
  sl.registerLazySingleton(() => FetchNotesUseCase(sl()));
  sl.registerLazySingleton(() => UpdateNoteUseCase(sl()));

  // Blocs
  sl.registerFactory(() => AuthBloc(
    loginUseCase: sl(),
    signUpUseCase: sl(),
    logoutUseCase: sl(),
  ));
  sl.registerFactory(() => NotesBloc(
    addNoteUseCase: sl(),
    deleteNoteUseCase: sl(),
    fetchNotesUseCase: sl(),
    updateNoteUseCase: sl(),
  ));
}
