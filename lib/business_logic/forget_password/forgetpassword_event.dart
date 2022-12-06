// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'forgetpassword_bloc.dart';

abstract class ForgetpasswordEvent extends Equatable {
  const ForgetpasswordEvent();

  @override
  List<Object> get props => [];
}

class ForgetAddEvent extends ForgetpasswordEvent {
  String email;
  ForgetAddEvent({
    required this.email,
  });
  @override
  List<Object> get props => [email];
}
