
abstract class AppRegisterStates {}

class AppRegisterInitialState extends AppRegisterStates {}

class AppRegisterLoadingState extends AppRegisterStates {}

class AppRegisterSuccessState extends AppRegisterStates {
  
}

class AppRegisterErrorState extends AppRegisterStates {
  final String? error;
  AppRegisterErrorState( {this.error}
  );
}
class AppCreateUserSuccessState extends AppRegisterStates {
    String? uid;
  AppCreateUserSuccessState({
    this.uid,
  });
}

class AppCreateUserErrorState extends AppRegisterStates {
  final String? error;
  AppCreateUserErrorState( {this.error}
  );
}

class AppRegisterChangePasswordState extends AppRegisterStates {}
