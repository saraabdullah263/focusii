

import 'package:focusi/features/home/date/model/advice_model.dart';

abstract class AdviceState {}

class AdviceInitial extends AdviceState {}

class AdviceLoading extends AdviceState {}

class AdviceLoaded extends AdviceState {
  final AdviceModel advice;
  AdviceLoaded(this.advice);
}

class AdviceError extends AdviceState {
  final String message;
  AdviceError(this.message);
}
