import 'package:equatable/equatable.dart';

abstract class HabitEvent extends Equatable {
  const HabitEvent();

  @override
  List<Object?> get props => [];
}

class LoadHabits extends HabitEvent {
  const LoadHabits();

  @override
  List<Object?> get props => [];
}

class ToggleHabit extends HabitEvent {
  final DateTime date;
  final String habitId;

  const ToggleHabit({required this.date, required this.habitId});

  @override
  List<Object?> get props => [date, habitId];
}
