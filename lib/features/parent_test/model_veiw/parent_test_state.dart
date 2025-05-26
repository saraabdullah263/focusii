abstract class ParentTestState {}

class ParentTestInitial extends ParentTestState {}

class ParentTestLoading extends ParentTestState {}

class ParentTestSuccess extends ParentTestState {}

class ParentTestFailure extends ParentTestState {
  final String message;
  ParentTestFailure({required this.message});
}
