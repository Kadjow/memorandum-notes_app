import 'package:dartz/dartz.dart';
import 'package:habit_tracker/core/error/failure.dart';
import 'package:habit_tracker/features/habit_tracker/domain/entities/habit.dart';
import 'package:habit_tracker/features/habit_tracker/domain/usecases/toggle_habit_completion.dart';

abstract class HabitRepository {
  Future<Either<Failure, List<Habit>>> getHabits();

  Future<Either<Failure, void>> toggleHabitCompletion(ToggleParams params);
}
