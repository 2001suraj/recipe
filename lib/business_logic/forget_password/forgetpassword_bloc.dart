// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe_app/data/repo/user_repo.dart';

part 'forgetpassword_event.dart';
part 'forgetpassword_state.dart';

class ForgetpasswordBloc
    extends Bloc<ForgetpasswordEvent, ForgetpasswordState> {
  UserRepo repo;
  ForgetpasswordBloc(UserRepo userRepo)
      : repo = userRepo,
        super(ForgetpasswordInitial()) {
    on<ForgetpasswordEvent>((event, emit) async {
      if (event is ForgetAddEvent) {
        emit(ForgetloadingInitial());
        try {
          var user = await repo.forgetpassword(email: event.email);
          emit(ForgetsuccessInitial(user: user));
        } catch (e) {
          emit(ForgetfailureInitial(message: e.toString()));
        }
      }
    });
  }
}
