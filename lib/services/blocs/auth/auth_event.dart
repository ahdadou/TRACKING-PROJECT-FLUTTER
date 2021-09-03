part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object> get props => [];
}

class startEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

class googleLoginEvent extends AuthEvent {
    final String idToken;
  googleLoginEvent({@required this.idToken});
  @override
  List<Object> get props => [];
}

class facebookLoginEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}