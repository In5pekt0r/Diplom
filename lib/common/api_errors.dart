import 'helpers.dart';

class NoServerFound implements Exception {
  @override String toString() => "Bad host url";
}

class MessageUp implements Exception {
  MessageUp({required this.message});
  final String message;
  @override String toString() => message;
}

class RepeatableMessageUp implements RepeatableAction {
  RepeatableMessageUp({required this.message});
  final String message;
  @override String toString() => message;
}

class BadCredentials implements Exception {
  @override String toString() => "Wrong credentials";
}
class BadResponseCode implements RepeatableAction {
  BadResponseCode({required this.statusCode});
  final int statusCode;
  @override String toString() => "Bad response code: $statusCode";
}