import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe_app/data/repo/user_repo.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepo repo;
  LoginBloc(UserRepo userRepo)
      : repo = userRepo,
        super(LoginInitialState()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginAddEvent) {
        emit(LoginloadindState());
        try {
          var user =
              await repo.login(email: event.email, password: event.password);
          emit(LoginsuccessState(user: user));
        } catch (e) {
          emit(LoginfailureState(message: e.toString()));
        }
      } else if (event is SignUpAddEvent) {
        
        try {
          var user =
              await repo.signin(email: event.email, password: event.password);
          emit(LoginsuccessState(user: user));
        } catch (e) {
          emit(LoginfailureState(message: e.toString()));
        }
      }
    });
  }
}
