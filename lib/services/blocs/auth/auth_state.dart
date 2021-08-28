part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthenticatedState extends AuthState {
  TokenDto tokenDto;
  AuthenticatedState({@required this.tokenDto});
  @override
  List<Object> get props => [];
}

class UnAuthenticatedState extends AuthState {
  @override
  List<Object> get props => [];
}
