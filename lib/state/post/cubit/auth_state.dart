part of 'auth_cubit.dart';


abstract class AuthState extends Equatable {

  const AuthState();

}


class AuthInitial extends AuthState {

  @override

  List<Object> get props => [];

}


class AuthLoading extends AuthState {

  @override

  List<Object?> get props => throw UnimplementedError();

}


class AuthSuccess extends AuthState {

  final AuthResponse response;

  const AuthSuccess(this.response);

  @override

  List<Object?> get props => [response];

}


class LoginSuccess extends AuthSuccess {

  final LoginResponse _loginResponse;

  const LoginSuccess(this._loginResponse) : super(_loginResponse);
  String get utype => _loginResponse.utype;

  @override

  List<Object?> get props => [_loginResponse];

}


class AuthFailed extends AuthState {

  final String error;


  const AuthFailed(this.error);


  @override

  List<Object?> get props => [error];

}

