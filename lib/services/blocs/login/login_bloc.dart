import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:delivery/services/blocs/login/login_event.dart';
import 'package:delivery/services/blocs/login/login_state.dart';
import 'package:delivery/services/repositories/LoginRepository.dart'
    as authRepository;
import 'package:delivery/shared/models/TokenDto.dart';
import 'package:equatable/equatable.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());
  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    try {
      if (event is LoginByGoogle) {
        yield LoginLoadingState();
        TokenDto tokenDto = await authRepository.googleLogin(event.idToken);
        yield LoginSuccessState(tokenDto: tokenDto);
      } else if (event is LoginByFacebook) {}
    } catch (e) {
      yield LoginFailureState(message: e.toString());
    }
  }
}
