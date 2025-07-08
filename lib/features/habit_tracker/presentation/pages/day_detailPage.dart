import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/habit/habit_bloc.dart';
import '../bloc/habit/habit_event.dart';
import '../bloc/habit/habit_state.dart';

class DayDetailPage extends StatefulWidget {
  final DateTime date;

  const DayDetailPage({Key? key, required this.date}) : super(key: key);

  @override
  State<DayDetailPage> createState() => _DayDetailPageState();
}

class _DayDetailPageState extends State<DayDetailPage> {
  final Set<String> _completed = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.date.day}/${widget.date.month}/${widget.date.year}',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<HabitBloc, HabitState>(
          builder: (context, state) {
            if (state is HabitLoading || state is HabitInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HabitLoaded) {
              final habits = state.habits;
              return ListView.builder(
                itemCount: habits.length,
                itemBuilder: (context, index) {
                  final habit = habits[index];
                  final isChecked = _completed.contains(habit.id);
                  return CheckboxListTile(
                    title: Text(habit.name),
                    value: isChecked,
                    onChanged: (checked) {
                      if (checked == true) {
                        setState(() => _completed.add(habit.id));
                      } else {
                        setState(() => _completed.remove(habit.id));
                      }
                      context.read<HabitBloc>().add(
                            ToggleHabit(
                              date: widget.date,
                              habitId: habit.id,
                            ),
                          );
                    },
                  );
                },
              );
            } else if (state is HabitError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
