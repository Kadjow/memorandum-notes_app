import 'package:dartz/dartz.dart';
import 'package:habit_tracker/core/error/failure.dart';
import '../entities/habit.dart';
import '../repositories/habit_repository.dart';

class GetHabits {
  final HabitRepository repository;

  GetHabits(this.repository);

  Future<Either<Failure, List<Habit>>> call() async {
    return await repository.getHabits();
  }
}