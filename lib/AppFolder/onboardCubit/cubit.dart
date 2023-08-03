import 'package:chat_app/AppFolder/onboardCubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Api/SharedPrefrences.dart';

class OnboardCubit extends Cubit<OnboardStates> {
  OnboardCubit() : super((OnboardInitialState()));
  static OnboardCubit get(context) => BlocProvider.of(context);

  bool onLastPage = false;
  onBoardChange(value) {
    value == 2 ? onLastPage = true : onLastPage = false;
    emit(onBoardChangeSuccessStates());
  }

  submit() {
    emit(SubmitOnboardLoadingStates());
    
    SharedPref.setData(key: "onboarding", value: true)
        .then((value) => emit(SubmitOnboardSuccessStates()));
  }


}
