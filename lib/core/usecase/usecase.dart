import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../error/failure.dart';

/// Parâmetros sem dados (caso nenhum parâmetro seja necessário).
class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}

/// Contrato genérico para casos de uso (Use Cases).
///
/// [Type] tipo de retorno esperado, [Params] parâmetros de entrada.
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
