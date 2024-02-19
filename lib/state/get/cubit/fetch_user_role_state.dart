import 'package:equatable/equatable.dart';
import 'package:mmeasyInvoice/data/response/company_profile_response.dart';
import 'package:mmeasyInvoice/data/response/user_role_response.dart';

abstract class FetchingUserState extends Equatable {
 
  const FetchingUserState();


}

class FetchUserInitial extends FetchingUserState {
  @override
  List<Object?> get props => [];
 }

class UserLoaded extends FetchingUserState {
  final List<UserData> _userData;

  const UserLoaded(this._userData);
  @override
  List<Object?> get props => _userData;
}

class FetchUserLoading extends FetchingUserState {
 
  const FetchUserLoading(
     );
  @override
  List<Object> get props => [];
}

class FetchingUserSuccess extends FetchingUserState {
  final List<UserData> _userData;

  const FetchingUserSuccess(this._userData);

  List<UserData> get userData => _userData;

  @override
  List<Object?> get props => [_userData];
}



//company profile
class CompanyProfile extends FetchingUserState {
  final CompanyProfileResponse _profileResponse;

  const CompanyProfile(this._profileResponse);

 CompanyProfileResponse get companyProfile => _profileResponse;

  @override
  List<Object?> get props => [_profileResponse];
}


//failed

class FetchingUserFailed extends FetchingUserState {
  final String error;

  const FetchingUserFailed({required this.error});

  @override
  List<Object?> get props => [error];
}
