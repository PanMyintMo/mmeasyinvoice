import 'package:equatable/equatable.dart';
import 'package:mmeasyInvoice/data/response/add_user_response.dart';

abstract class AddUserState extends Equatable {
  const AddUserState();
}

class AddUserInitial extends AddUserState {
  @override
  List<Object> get props => [];
}

class AddUserLoading extends AddUserState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class AddUserSuccess extends AddUserState {
  final UserResponse response;

  const AddUserSuccess(this.response);

  UserResponse get userResponse => response;

  @override
  List<Object?> get props => [response];
}

class AddUserFailed extends AddUserState {
  final String error;

  const AddUserFailed(this.error);

  @override
  List<Object?> get props => [error];
}
