// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'logout_bloc.dart';

abstract class LogoutState extends Equatable {
  const LogoutState();

  @override
  List<Object> get props => [];
}

class LogoutInitial extends LogoutState {
  @override
  List<Object> get props => [];
}

class Logoutsuccess extends LogoutState {
  User user;
  Logoutsuccess({
    required this.user,
  });
  @override
  List<Object> get props => [user];
}

class Logoutfailure extends LogoutState {
  String message;
  Logoutfailure({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
