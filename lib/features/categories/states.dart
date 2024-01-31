import 'model.dart';

class CategoriesStates {}

class CategoriesLoadingState extends CategoriesStates {}

class CategoriesFailedState extends CategoriesStates {
  final String msg;

  CategoriesFailedState({required this.msg});
}

class CategoriesSuccessState extends CategoriesStates {
  final List<CategoryModel> list;

  CategoriesSuccessState({required this.list});
}
