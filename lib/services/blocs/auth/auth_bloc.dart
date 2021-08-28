import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:delivery/shared/models/TokenDto.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:delivery/services/repositories/LoginRepository.dart'
    as authRepository;
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    try {
      if (event is AuthEvent) {
        yield AuthInitial();
        var isAuth = await authRepository.isSignedIn();
        if (isAuth) {
          TokenDto tokenDto = await authRepository.getTokenDto();
          yield AuthenticatedState(tokenDto: tokenDto);
        } else {
          yield UnAuthenticatedState();
        }
      }
    } catch (e) {
      yield UnAuthenticatedState();
    }
  }
}
