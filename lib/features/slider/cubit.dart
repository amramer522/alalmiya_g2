import 'package:alalmiya_g2/features/slider/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/logic/dio_helper.dart';
import 'model.dart';

class SliderCubit extends Cubit<SliderStates> {
  SliderCubit() : super(SliderStates());

  Future<void> getData() async {
    emit(GetSliderLoadingState());
    final response = await DioHelper().getData("sliders");
    print(response.response?.data);
    if (response.isSuccess) {
      final model = SliderData.fromJson(response.response!.data);
      emit(GetSliderSuccessState(list: model.list));
    } else {
      emit(GetSliderFailedState(msg: response.message));
    }
  }
}
