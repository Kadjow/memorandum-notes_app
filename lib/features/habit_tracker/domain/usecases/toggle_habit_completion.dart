import 'package:dartz/dartz.dart';
import 'package:habit_tracker/core/error/failure.dart';
import 'package:habit_tracker/features/habit_tracker/domain/repositories/habit_repository.dart';
import 'package:habit_tracker/features/habit_tracker/domain/usecases/usecase.dart';

/// Parâmetros para alternar a conclusão de um hábito em uma data específica.
class ToggleParams {
  final DateTime date;
  final String habitId;

  const ToggleParams(this.date, this.habitId);
}

/// Caso de uso para marcar ou desmarcar a conclusão de um hábito em um dia.
class ToggleHabitCompletion implements UseCase<void, ToggleParams> {
  final HabitRepository repository;

  const ToggleHabitCompletion(this.repository);

  @override
  Future<Either<Failure, void>> call(ToggleParams params) async {
    return repository.toggleHabitCompletion(params);
  }
}
