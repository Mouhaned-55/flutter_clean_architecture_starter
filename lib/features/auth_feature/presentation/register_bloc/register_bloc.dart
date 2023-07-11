import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/utils/map_failure_to_message.dart';
import '../../domain/use_cases/register_use_case.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {

  final RegisterUseCase register;

  RegisterBloc({required this.register}) : super(RegisterState()) {
    on<RegisterEvent>((event, emit) async {
      if (event is RegisterUserEvent) {
        emit(state.copyWith(isLoading: true, error: ""));
        final failureOrRegister = await register(
            event.email, event.username, event.password, event.passwordConfirm);
        failureOrRegister.fold((failure) =>
            state.copyWith(
                error: mapFailureToMessage(failure), isLoading: false), (
            _) async {
          state.copyWith(isLoading: false, error: "", success: true);
        });
      }
    });
  }
}
