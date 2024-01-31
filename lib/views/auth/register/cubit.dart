import 'package:alalmiya_g2/views/auth/register/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/dio_helper.dart';
import '../../../core/logic/helper_methods.dart';
import '../../../features/get_cities/model.dart';
import '../confirm_code/view.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterStates());

  CityModel? selectedCity;
  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void register() async {
    if (formKey.currentState!.validate()) {
      emit(RegisterLoadingState());
      final response = await DioHelper().sendData("client_register", data: {
        "fullname": fullNameController.text,
        "password": passwordController.text,
        "password_confirmation": confirmPasswordController.text,
        "phone": phoneController.text,
        "country_id": 1,
        "city_id": selectedCity!.id
      });

      if (response.isSuccess) {
        showMessage(response.message, type: MessageType.success);
        navigateTo(ConfirmCodeView(
          isActive: true,
          phone: phoneController.text,
        ));
        emit(RegisterSuccessState());
      } else {
        showMessage(response.message);
        emit(RegisterFailedState());
      }
    }
  }
}
