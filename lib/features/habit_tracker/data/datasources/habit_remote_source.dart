import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/habit.dart';
import '../models/habit_model.dart';

abstract class HabitRemoteDataSource {
  Future<List<HabitModel>> getHabits(String userId);

  Future<void> toggleHabitCompletion(String userId, DateTime date, String habitId);
}

class HabitRemoteDataSourceImpl implements HabitRemoteDataSource {
  final FirebaseFirestore firestore;

  HabitRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<HabitModel>> getHabits(String userId) async {
    final collection = firestore
        .collection('users')
        .doc(userId)
        .collection('habits');
    final snapshot = await collection.get();
    return snapshot.docs.map((doc) => HabitModel.fromDocument(doc)).toList();
  }

  @override
  Future<void> toggleHabitCompletion(String userId, DateTime date, String habitId) async {
    final dateStr = '${date.year.toString().padLeft(4, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
    final docRef = firestore
        .collection('users')
        .doc(userId)
        .collection('completions')
        .doc(dateStr);

    final snapshot = await docRef.get();
    final data = snapshot.data() as Map<String, dynamic>? ?? {};
    final current = data[habitId] as bool? ?? false;
    await docRef.set({habitId: !current}, SetOptions(merge: true));
  }
}
