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
      if (event is startEvent) {
        yield AuthLoadingState();
        TokenDto tokenDto = await authRepository.getTokenDto();
        if (tokenDto.auth) {
          yield AuthenticatedState(tokenDto: tokenDto);
        } else {
          yield UnAuthenticatedState();
        }
      } else if (event is googleLoginEvent) {
        yield AuthLoadingState();
        var tokenDto = await authRepository.googleLogin(event.idToken);
        if (tokenDto.newAccount) {
          yield AuthenticatedNewAccountState(tokenDto: tokenDto);
        } else if (tokenDto.newAccount == false) {
          yield AuthenticatedState(tokenDto: tokenDto);
        } else {
          yield UnAuthenticatedState();
        }
      }
    } catch (e) {
      print('-----------------catch Error-------------' + e.toString());
      yield UnAuthenticatedState();
    }
  }
}
