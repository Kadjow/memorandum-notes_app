import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:habit_tracker/core/error/failure.dart';
import 'package:habit_tracker/features/habit_tracker/data/datasources/habit_remote_source.dart';
import '../../domain/entities/habit.dart';
import '../../domain/repositories/habit_repository.dart';
import '../../domain/usecases/toggle_habit_completion.dart';

class HabitRepositoryImpl implements HabitRepository {
  final HabitRemoteDataSource remoteDataSource;
  final FirebaseAuth auth;

  HabitRepositoryImpl({
    required this.remoteDataSource,
    required this.auth,
  });

  @override
  Future<Either<Failure, List<Habit>>> getHabits() async {
    try {
      final user = auth.currentUser;
      if (user == null) {
        return Left(ServerFailure('Usuário não autenticado'));
      }
      final models = await remoteDataSource.getHabits(user.uid);
      return Right(models);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> toggleHabitCompletion(ToggleParams params) async {
    try {
      final user = auth.currentUser;
      if (user == null) {
        return Left(ServerFailure('Usuário não autenticado'));
      }
      await remoteDataSource.toggleHabitCompletion(
        user.uid,
        params.date,
        params.habitId,
      );
      return const Right(null);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
