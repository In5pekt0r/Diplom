import 'package:webrtc_conference/common/helpers.dart';
import 'package:webrtc_conference/repositories/authentication.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login.g.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(AuthenticationRepository repository)
      : _repository = repository,
        super(const LoginState());

  final AuthenticationRepository _repository;

  Future<void> logInWithEmailAndPassword(String? email, String? password) async {
    if (state.status == LoginStatus.loading) return;
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      await _repository.logInWithEmailAndPassword(email: email, password: password);
      emit(state.copyWith(status: LoginStatus.ready));
    } catch (_) {
      emit(state.copyWith(status: LoginStatus.error));
      rethrow;
    }
  }

  Future<void> signUpWithBasicData(
      String? name,
      String? email,
      String? country,
      String? password,
      String? passwordConfirm
    ) async {
    if (state.status == LoginStatus.loading) return;
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      if (
        name == null || name.isEmpty ||
        email == null || email.isEmpty ||
        country == null || country.isEmpty ||
        password == null || password.isEmpty ||
        passwordConfirm == null || passwordConfirm.isEmpty
      ) {
        throw ValidationException('All fields are mandatory');
      }
      if (password != passwordConfirm) {
        throw ValidationException('Passwords are different');
      }
      await _repository.signUpWithBasicData(
          name: name,
          email: email,
          country: country,
          password: password
      );
      emit(state.copyWith(status: LoginStatus.ready));
    } catch (_) {
      emit(state.copyWith(status: LoginStatus.error));
      rethrow;
    }
  }

  Future<void> logOut() async {
    if (state.status == LoginStatus.loading) return;
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      await _repository.logOut();
      emit(state.copyWith(status: LoginStatus.ready));
    } catch (_) {
      emit(state.copyWith(status: LoginStatus.error));
      rethrow;
    }
  }
}

enum LoginStatus { initial, loading, error, ready }

@CopyWith()
class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.initial,
  });

  final LoginStatus status;

  @override
  List<Object> get props => [status];
}
