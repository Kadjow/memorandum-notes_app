import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../injection_container.dart';
import '../bloc/habit/habit_bloc.dart';
import '../bloc/habit/habit_event.dart';
import '../bloc/habit/habit_state.dart';
import 'day_detailPage.dart';

/// Tela principal exibindo o calendário e permitindo navegar
/// para o detalhe de um dia selecionado.
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    // Dispara o carregamento de hábitos
    context.read<HabitBloc>().add(const LoadHabits());
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit Tracker'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
              onDaySelected: (selected, focused) {
                setState(() {
                  _selectedDay = selected;
                  _focusedDay = focused;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DayDetailPage(date: selected),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<HabitBloc, HabitState>(
                builder: (context, state) {
                  if (state is HabitLoading || state is HabitInitial) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is HabitLoaded) {
                    return ListView.builder(
                      itemCount: state.habits.length,
                      itemBuilder: (context, index) {
                        final habit = state.habits[index];
                        return ListTile(
                          title: Text(habit.name),
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
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Text('Menu'),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                // TODO: chamar logout do AuthService
              },
            ),
          ],
        ),
      ),
    );
  }
}
