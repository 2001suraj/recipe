// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe_app/data/repo/user_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserRepo userRepo;
  AuthBloc(UserRepo repo)
      : userRepo = repo,
        super(AuthInitialState()) {
    on<AuthEvent>((event, emit) async {
      if (event is AuthAddEvent) {
        emit(AuthloadingState());
        var isSignin = await userRepo.isSignin();
        var user = await userRepo.getuser();
        try {
          if (isSignin) {
            emit(AuthsuccessState(user: user));
          } else {
            emit(AuthfailureState(message: 'some error occured'));
          }
        } catch (e) {
          emit(AuthfailureState(message: e.toString()));
        }
      } 
   
    });
  }
}
