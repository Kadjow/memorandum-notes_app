import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:habit_tracker/features/habit_tracker/data/datasources/habit_remote_source.dart';
import 'package:habit_tracker/features/habit_tracker/data/repositories/habit_repository.dart';

import 'core/services/auth_service.dart';
import 'features/habit_tracker/domain/repositories/habit_repository.dart';
import 'features/habit_tracker/domain/usecases/get_habits.dart';
import 'features/habit_tracker/domain/usecases/toggle_habit_completion.dart';
import 'features/habit_tracker/presentation/bloc/habit/habit_bloc.dart';

final sl = GetIt.instance;

/// Inicializa e configura todas as dependências via GetIt.
Future<void> init() async {
  if (sl.isRegistered<FirebaseAuth>() || sl.isRegistered<HabitBloc>()) {
    await sl.reset();
  }

  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  // Google Sign-In e AuthService
  sl.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());
  sl.registerLazySingleton<AuthService>(
    () => AuthService(sl<FirebaseAuth>(), sl<GoogleSignIn>()),
  );

  // Data sources
  sl.registerLazySingleton<HabitRemoteDataSource>(
    () => HabitRemoteDataSourceImpl(firestore: sl()),
  );

  // Repositories
  sl.registerLazySingleton<HabitRepository>(
    () => HabitRepositoryImpl(
      remoteDataSource: sl(),
      auth: sl<FirebaseAuth>(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetHabits(sl()));
  sl.registerLazySingleton(() => ToggleHabitCompletion(sl()));

  // BLoCs
  sl.registerFactory(
    () => HabitBloc(
      getHabits: sl(),
      toggleCompletion: sl(),
    ),
  );
}