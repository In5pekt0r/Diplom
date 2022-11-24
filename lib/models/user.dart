import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel({
    this.email,
    required this.token,
  });

  final String? email;
  final String token;

  static const empty = UserModel(
    email: '',
    token: '',
  );

  @override
  List<Object> get props => [
        token,
      ];
}
