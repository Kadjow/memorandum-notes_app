import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/habit.dart';

class HabitModel extends Habit {
  const HabitModel({
    required String id,
    required String name,
  }) : super(id: id, name: name);

  factory HabitModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return HabitModel(
      id: doc.id,
      name: data['name'] as String? ?? '',
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'name': name,
    };
  }
}
