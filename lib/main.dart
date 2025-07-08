import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/features/habit_tracker/auth/presentation/pages/login_page.dart';
import 'package:habit_tracker/features/habit_tracker/presentation/pages/homePage.dart';
import 'firebase_options.dart';                        
import 'injection_container.dart';
import 'core/services/auth_service.dart';
import 'features/habit_tracker/presentation/bloc/habit/habit_bloc.dart';
import 'features/habit_tracker/presentation/bloc/habit/habit_event.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await init(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HabitBloc>(
          create: (_) => sl<HabitBloc>()..add(const LoadHabits()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Habit Tracker',
        theme: ThemeData.dark(),
        home: StreamBuilder<User?>(
          stream: sl<AuthService>().authStateChanges,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            if (snapshot.hasData) {
              return const HomePage();
            }
            return const LoginPage();
          },
        ),
      ),
    );
  }
}
