import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/features/habit_tracker/presentation/bloc/habit/habit_bloc.dart';
import 'package:habit_tracker/features/habit_tracker/presentation/bloc/habit/habit_event.dart';
import 'package:habit_tracker/features/habit_tracker/presentation/pages/homePage.dart';

import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HabitBloc>(
          create: (_) => sl<HabitBloc>()..add(const LoadHabits()),
        ),
      ],
      child: MaterialApp(
        title: 'Habit Tracker',
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.deepPurple,
        ),
        home: const HomePage(),
      ),
    );
  }
}
