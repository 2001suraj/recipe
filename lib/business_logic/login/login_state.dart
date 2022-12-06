// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitialState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginloadindState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginsuccessState extends LoginState {
  User user;
  LoginsuccessState({
    required this.user,
  });
  @override
  List<Object> get props => [user];
}

class LoginfailureState extends LoginState {
  String message;
  LoginfailureState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
