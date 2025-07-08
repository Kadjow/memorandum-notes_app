import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:habit_tracker/features/habit_tracker/data/datasources/habit_remote_source.dart';
import 'package:habit_tracker/features/habit_tracker/data/repositories/habit_repository.dart';
import 'package:habit_tracker/features/habit_tracker/domain/repositories/habit_repository.dart';
import 'package:habit_tracker/features/habit_tracker/domain/usecases/get_habits.dart';
import 'package:habit_tracker/features/habit_tracker/domain/usecases/toggle_habit_completion.dart';
import 'package:habit_tracker/features/habit_tracker/presentation/bloc/habit/habit_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLoC
  sl.registerFactory(() => HabitBloc(
    getHabits: sl(), 
    toggleCompletion: sl()
  ));

  // Use cases
sl.registerLazySingleton(() => GetHabits(sl()));
sl.registerLazySingleton(() => ToggleHabitCompletion(sl()));
sl.registerFactory(() => HabitBloc(getHabits: sl(), toggleCompletion: sl()));


  // Repositories
sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);


sl.registerLazySingleton<HabitRemoteDataSource>(
  () => HabitRemoteDataSourceImpl(firestore: sl()),
);
sl.registerLazySingleton<HabitRepository>(
  () => HabitRepositoryImpl(
    remoteDataSource: sl(), 
    auth: sl(),
  ),
);

}
