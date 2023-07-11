import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/map_failure_to_message.dart';
import '../../../../core/utils/pref_utils.dart';
import '../../domain/use_cases/login_use_case.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase login;
  final PrefUtils prefUtils;

  LoginBloc({required this.login, required this.prefUtils})
      : super(LoginState()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginUserEvent) {
        emit(state.copyWith(isLoading: true, error: ""));
        final failureOrLogin = await login(event.email, event.password);
        failureOrLogin.fold((failure) {
          state.copyWith(error: mapFailureToMessage(failure), isLoading: false);
        }, (_) async {
          state.copyWith(isLoading: false, error: "", success: true);
        });
      }
    });
  }

}
