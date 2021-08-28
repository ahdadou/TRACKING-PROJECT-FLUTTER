import 'package:delivery/shared/models/TokenDto.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSuccessState extends LoginState {
  TokenDto tokenDto;
  LoginSuccessState({@required this.tokenDto});

  @override
  List<Object> get props => [];
}

class LoginFailureState extends LoginState {
  String message;
  LoginFailureState({@required this.message});

  @override
  List<Object> get props => [];
}
