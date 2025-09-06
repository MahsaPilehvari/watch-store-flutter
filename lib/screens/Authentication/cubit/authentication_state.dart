part of 'authentication_cubit.dart';

@immutable
sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}

final class LoadingState extends AuthenticationState {}

final class ErrorState extends AuthenticationState {
  final String message;
  ErrorState({required this.message});
}

final class SentState extends AuthenticationState {
  final String mobile;
  SentState({required this.mobile});
}

final class VerifiedRegisteredState extends AuthenticationState {}

final class VerifiedNotRegisteredState extends AuthenticationState {}

final class LoggedInState extends AuthenticationState {}

final class LoggedOutState extends AuthenticationState {}
