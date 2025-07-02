import 'package:shared_preferences/shared_preferences.dart';
import '../../data/datasources/auth_local_data_source.dart';
import '../../data/datasources/notes_local_data_source.dart';
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

class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  factory ServiceLocator() => _instance;
  ServiceLocator._internal();

  final Map<Type, dynamic> _services = {};

  T get<T>() => _services[T] as T;

  void registerLazySingleton<T>(T Function() factory) {
    _services[T] = factory();
  }

  void registerFactory<T>(T Function() factory) {
    _services[T] = factory;
  }
}

final sl = ServiceLocator();

Future<void> init() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // Data sources
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<NotesLocalDataSource>(
    () => NotesLocalDataSourceImpl(sl()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<NotesRepository>(
    () => NotesRepositoryImpl(sl(), sl()),
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
