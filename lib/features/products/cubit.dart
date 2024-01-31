import 'package:alalmiya_g2/core/logic/dio_helper.dart';
import 'package:alalmiya_g2/features/products/model.dart';
import 'package:alalmiya_g2/features/products/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsCubit extends Cubit<ProductsStates> {
  ProductsCubit() : super(ProductsStates());

  Future<void> getData() async {
    emit(ProductsLoadingState());
    final response = await DioHelper().getData("products");
    if (response.isSuccess) {
      final model = ProductsData.fromJson(response.response!.data);
      emit(ProductsSuccessState(list: model.list));
    } else {
      emit(ProductsFailedState(msg: response.message));
    }
  }
}
