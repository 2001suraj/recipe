// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginAddEvent extends LoginEvent {
  String email;
  String password;
  LoginAddEvent({
    required this.email,
    required this.password,
  });
    @override
  List<Object> get props => [email, password];
}
class SignUpAddEvent extends LoginEvent {
  String email;
  String password;
  SignUpAddEvent({
    required this.email,
    required this.password,
  });
    @override
  List<Object> get props => [email, password];
}
