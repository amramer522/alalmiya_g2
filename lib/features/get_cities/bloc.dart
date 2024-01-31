import 'package:alalmiya_g2/core/logic/dio_helper.dart';
import 'package:alalmiya_g2/features/get_cities/events.dart';
import 'package:alalmiya_g2/features/get_cities/states.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'model.dart';


class GetCitiesBloc extends Bloc<CitiesEvents,GetCitiesStates> {
  GetCitiesBloc() : super(GetCitiesStates()){
    on<GetCitiesEvent> (_getData);
  }


  void _getData(GetCitiesEvent event,Emitter<GetCitiesStates> emit) async {
    emit(GetCitiesLoadingState());
    final response = await DioHelper().getData("cities/1");
    if (response.isSuccess) {
      final model = GetCitiesData.fromJson(response.response!.data);
      emit(GetCitiesSuccessState(list: model.list));
    } else {
      emit(GetCitiesFailedState());
    }
  }
}
