import 'package:equatable/equatable.dart';

class Habit extends Equatable {
  final String id;
  final String name;

  const Habit({required this.id, required this.name});
  @override
  List<Object> get props => [id, name];

  Habit copyWith({
    String? id, 
    String? name,
  }) {
    return Habit(id: id ?? this.id, name: name ?? this.name);
  }
}
