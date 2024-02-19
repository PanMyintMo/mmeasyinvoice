import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mmeasyInvoice/data/repository/auth_repository.dart';
import 'package:mmeasyInvoice/data/response/authResponse/auth_response.dart';
import 'package:mmeasyInvoice/data/response/authResponse/login_response.dart';
import 'package:mmeasyInvoice/util/app_logger.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  AuthCubit(this._authRepository) : super(AuthInitial());

  Future<void> register(dynamic data) async {
    emit(AuthLoading());
    try {
      final response = await _authRepository.registerApi(data);
      final authResponse = AuthResponse.fromJson(response);
      logger.e("Register response is $authResponse");
      emit(AuthSuccess(authResponse));
    } catch (error) {
         logger.e("Error is $error");
      emit(AuthFailed(error.toString()));
    }
  }

  Future<void> login(dynamic data) async {
    emit(AuthLoading());
    try {
      final response = await _authRepository.loginApi(data);
      final loginResponse = LoginResponse.fromJson(response);
      emit(LoginSuccess(loginResponse));
    } catch (error) {
      emit(AuthFailed(error.toString()));
    }
  }
}
