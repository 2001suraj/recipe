// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitialState extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthloadingState extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthsuccessState extends AuthState {
  User user;
  AuthsuccessState({
    required this.user,
  });
  @override
  List<Object> get props => [user];
}

class AuthfailureState extends AuthState {
  String message;
  AuthfailureState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
