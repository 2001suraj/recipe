// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'forgetpassword_bloc.dart';

abstract class ForgetpasswordState extends Equatable {
  const ForgetpasswordState();

  @override
  List<Object> get props => [];
}

class ForgetpasswordInitial extends ForgetpasswordState {
  @override
  List<Object> get props => [];
}

class ForgetloadingInitial extends ForgetpasswordState {
  @override
  List<Object> get props => [];
}

class ForgetsuccessInitial extends ForgetpasswordState {
  User user;
  ForgetsuccessInitial({
    required this.user,
  });
  @override
  List<Object> get props => [user];
}

class ForgetfailureInitial extends ForgetpasswordState {
  String message;
  ForgetfailureInitial({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
