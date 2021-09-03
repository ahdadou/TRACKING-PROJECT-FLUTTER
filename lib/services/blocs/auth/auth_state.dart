part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {

}

class AuthLoadingState extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthenticatedState extends AuthState {
  TokenDto tokenDto;
  AuthenticatedState({@required this.tokenDto});
  @override
  List<Object> get props => [];
}

class AuthenticatedNewAccountState extends AuthState {
  TokenDto tokenDto;
  AuthenticatedNewAccountState({@required this.tokenDto});
  @override
  List<Object> get props => [];
}


class UnAuthenticatedState extends AuthState {
  @override
  List<Object> get props => [];
}
