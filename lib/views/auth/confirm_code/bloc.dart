import 'dart:io';

import 'package:alalmiya_g2/views/auth/confirm_code/events.dart';
import 'package:alalmiya_g2/views/auth/confirm_code/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/dio_helper.dart';
import '../../../core/logic/helper_methods.dart';
import '../create_new_password/view.dart';
import '../login/view.dart';

class ConfirmCodeBloc extends Bloc<ConfirmCodeEvents,ConfirmCodeStates>
{
  ConfirmCodeBloc():super(ConfirmCodeStates()){
    on<ConfirmCodeEvent> (_verify);
    on<ResendCodeEvent> (_resend);
  }

  bool isPasswordHidden = true;
  bool isTimerFinished = false;

  final codeController = TextEditingController();



  Future<void> _resend(ResendCodeEvent event,Emitter<ConfirmCodeStates> emit)async{
    await DioHelper().sendData("resend_code", data: {
      "phone": event.phone,
    });
  }
  void _verify(ConfirmCodeEvent event,Emitter<ConfirmCodeStates> emit) async {
    emit(ConfirmCodeLoadingState());
    if (event.isActive) {
      await DioHelper().sendData("resend_code", data: {
        "phone":event. phone,
      });
    }
    final response = await DioHelper().sendData("verify", data: {
      "code": codeController.text,
      "phone": event.phone,
      "type": Platform.operatingSystem,
      "device_token": "test",
    });

    if (response.isSuccess) {
      showMessage(response.message, type: MessageType.success);
      if (event.isActive) {
        navigateTo(LoginView());
      } else {
        navigateTo(CreateNewPasswordView());
      }
      emit(ConfirmCodeSuccessState());
    } else {
      showMessage(response.message);
      emit(ConfirmCodeFailedState());
    }
  }

}