import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:favorite_places_app/auth/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;

  AuthBloc({required this.authRepo}) : super(AuthInitial()) {
    on<AuthStarted>(_onStarted);
    on<AuthLoggedInWithEmailAndPassword>(_onLoggedInWithEmailAndPassword);
    on<AuthLoggedOut>(_onLoggedOut);
    on<AuthSignedUp>(_onAuthSignUp);
  }

  void _onStarted(AuthStarted event, Emitter<AuthState> emit) {
    // Implementation for AuthenticationStarted
  }

  void _onLoggedInWithEmailAndPassword(
    AuthLoggedInWithEmailAndPassword event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthInProgress());
    try {
      await authRepo.logIn(email: event.email, password: event.password);

      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(_getFirebaseAuthErrorMessage(e)));
    } catch (_) {
      emit(AuthFailure('An unknown error occurred'));
    }
  }

  void _onAuthSignUp(
    AuthSignedUp event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthInProgress());
    try {
      await authRepo.signUp(email: event.email, password: event.password);
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      print(e.code);
      emit(AuthFailure(_getFirebaseAuthErrorMessage(e)));
    } catch (e) {
      emit(AuthFailure('An unknown error occurred'));
    }
  }

  void _onLoggedOut(AuthLoggedOut event, Emitter<AuthState> emit) async {
    await authRepo.logOut();
    emit(AuthLogOutSucess());
  }

  String _getFirebaseAuthErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'The email address is badly formatted.';
      case 'wrong-password':
        return 'The password is invalid or the user does not have a password.';
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Invalid Credentials. Please check again!';
      case 'email-already-in-use':
        return 'Email is already used!';

      default:
        return 'An unknown error occurred. Please try again later.';
    }
  }
}
