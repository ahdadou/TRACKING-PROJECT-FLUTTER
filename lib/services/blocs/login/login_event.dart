import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginByGoogle extends LoginEvent {
  final String idToken;
  LoginByGoogle({@required this.idToken});
}

class LoginByFacebook extends LoginEvent {
  final String accessToken;
  LoginByFacebook({@required this.accessToken});
}
