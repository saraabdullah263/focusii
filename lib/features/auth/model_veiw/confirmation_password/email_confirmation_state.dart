part of 'email_confirmation_cubit.dart';

abstract class EmailConfirmationState {}

class EmailConfirmationInitial extends EmailConfirmationState {}

class EmailConfirmationLoading extends EmailConfirmationState {}

class EmailConfirmationSuccess extends EmailConfirmationState {}

class EmailConfirmationFailure extends EmailConfirmationState {
  final String error;
  EmailConfirmationFailure({required this.error});
}
