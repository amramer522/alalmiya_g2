import 'package:alalmiya_g2/core/logic/dio_helper.dart';
import 'package:alalmiya_g2/features/categories/model.dart';
import 'package:alalmiya_g2/features/categories/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesCubit extends Cubit<CategoriesStates> {
  CategoriesCubit() : super(CategoriesStates());

  Future<void> getData() async {
    emit(CategoriesLoadingState());
    final response = await DioHelper().getData("categories");
    if (response.isSuccess) {
      final model = CategoriesData.fromJson(response.response!.data);
      emit(CategoriesSuccessState(list: model.list));
    } else {
      emit(CategoriesFailedState(msg: response.message));
    }
  }
}
