// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class AppLoginStates {}

class AppLoginInitialState extends AppLoginStates {}

class AppLoginLoadingState extends AppLoginStates {}

class AppLoginSuccessState extends AppLoginStates {
  
 

  
}

class AppLoginErrorState extends AppLoginStates {
  final String? error;
  AppLoginErrorState({this.error});
}

class AppChangePasswordState extends AppLoginStates {}
