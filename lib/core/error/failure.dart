/// Definição de falhas (erros) do aplicativo.
abstract class Failure {
  final String message;
  const Failure(this.message);
}

/// Falha de servidor.
class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

/// Falha de cache/local .
class CacheFailure extends Failure {
  const CacheFailure(String message) : super(message);
}
