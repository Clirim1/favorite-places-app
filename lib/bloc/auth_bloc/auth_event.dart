part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthStarted extends AuthEvent {}

class AuthLoggedIn extends AuthEvent {}

class AuthLoggedOut extends AuthEvent {}

class AuthSignedUp extends AuthEvent {
  final String email;
  final String password;

  AuthSignedUp(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class AuthLoggedInWithEmailAndPassword extends AuthEvent {
  final String email;
  final String password;

  AuthLoggedInWithEmailAndPassword(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}
