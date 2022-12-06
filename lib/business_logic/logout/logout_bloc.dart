import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/data/repo/user_repo.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  UserRepo repo;
  LogoutBloc(UserRepo userRepo)
      : repo = userRepo,
        super(LogoutInitial()) {
    on<LogoutEvent>((event, emit) async {
      if (event is logoutAddEvent) {
        try {
          var user = await repo.logout();
          emit(Logoutsuccess(user: user!));
        } catch (e) {
          emit(Logoutfailure(message: e.toString()));
        }
      }
    });
  }
}
