import 'package:equatable/equatable.dart';
import '../../../domain/entities/habit.dart';

abstract class HabitState extends Equatable {
  const HabitState();

  @override
  List<Object?> get props => [];
}

class HabitInitial extends HabitState {
  const HabitInitial();
}

class HabitLoading extends HabitState {
  const HabitLoading();
}

class HabitLoaded extends HabitState {
  final List<Habit> habits;

  const HabitLoaded({required this.habits});

  @override
  List<Object?> get props => [habits];
}

class HabitError extends HabitState {
  final String message;

  const HabitError({required this.message});

  @override
  List<Object?> get props => [message];
}
