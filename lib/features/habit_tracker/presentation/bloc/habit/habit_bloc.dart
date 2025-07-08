import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/core/error/failure.dart';
import 'package:habit_tracker/features/habit_tracker/domain/usecases/get_habits.dart';
import 'package:habit_tracker/features/habit_tracker/domain/usecases/toggle_habit_completion.dart';
import 'package:habit_tracker/features/habit_tracker/presentation/bloc/habit/habit_event.dart';
import 'package:habit_tracker/features/habit_tracker/presentation/bloc/habit/habit_state.dart';
import 'package:habit_tracker/core/usecase/usecase.dart';


class HabitBloc extends Bloc<HabitEvent, HabitState> {
  final GetHabits getHabits;
  final ToggleHabitCompletion toggleCompletion;

  HabitBloc({
    required this.getHabits,
    required this.toggleCompletion,
  }) : super(const HabitInitial()) {
    on<LoadHabits>(_onLoadHabits);
    on<ToggleHabit>(_onToggleHabit);
  }

  Future<void> _onLoadHabits(
    LoadHabits event,
    Emitter<HabitState> emit,
  ) async {
    emit(const HabitLoading());
final result = await getHabits();
    result.fold(
      (failure) => emit(HabitError(message: failure.message)),
      (habits)   => emit(HabitLoaded(habits: habits)),
    );
  }

  Future<void> _onToggleHabit(
    ToggleHabit event,
    Emitter<HabitState> emit,
  ) async {
    emit(state);
    await toggleCompletion(ToggleParams(event.date, event.habitId));
    add(const LoadHabits());
  }
}
