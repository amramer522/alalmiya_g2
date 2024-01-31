import 'package:alalmiya_g2/core/design/app_button.dart';
import 'package:alalmiya_g2/core/design/app_image.dart';
import 'package:alalmiya_g2/core/design/app_input.dart';
import 'package:alalmiya_g2/core/logic/cache_helper.dart';
import 'package:alalmiya_g2/core/logic/dio_helper.dart';
import 'package:alalmiya_g2/core/logic/helper_methods.dart';
import 'package:alalmiya_g2/features/categories/cubit.dart';
import 'package:alalmiya_g2/features/categories/states.dart';
import 'package:alalmiya_g2/features/products/cubit.dart';
import 'package:alalmiya_g2/features/products/model.dart';
import 'package:alalmiya_g2/features/products/states.dart';
import 'package:alalmiya_g2/features/slider/cubit.dart';
import 'package:alalmiya_g2/features/slider/states.dart';
import 'package:alalmiya_g2/views/auth/login/view.dart';
import 'package:alalmiya_g2/features/slider/model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../features/categories/model.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // List<CategoryModel> categoryList = [
  //   CategoryModel(id: 0, image: "https://images.squarespace-cdn.com/content/v1/5ea742bbf02561696504b781/1588042696486-YVQN15JXPKMCIURWC1KL/Vegetables.png", title: "الخضار", color: Color(0xc4bdf892)),
  //   CategoryModel(id: 1, image: "https://images.squarespace-cdn.com/content/v1/5ea742bbf02561696504b781/1588042696486-YVQN15JXPKMCIURWC1KL/Vegetables.png", title: "الفواكه", color: Color(0xc4e33399)),
  //   CategoryModel(id: 2, image: "https://images.squarespace-cdn.com/content/v1/5ea742bbf02561696504b781/1588042696486-YVQN15JXPKMCIURWC1KL/Vegetables.png", title: "اللحوم", color: Color(0xc468d6e0)),
  // ];

  @override
  void initState() {
    super.initState();
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: AppInput(
              labelText: "ابحث عن ماتريد؟",
              icon: "assets/icons/svg/search.svg",
            ),
          ),
          BlocBuilder<SliderCubit, SliderStates>(builder: (context, state) {
            if (state is GetSliderLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is GetSliderSuccessState) {
              return Column(
                children: [
                  CarouselSlider(
                    items: List.generate(
                      state.list.length,
                      (index) => AppImage(
                        state.list[index].image,
                        fit: BoxFit.fill,
                        height: 164,
                        width: double.infinity,
                      ),
                    ),
                    options: CarouselOptions(
                      height: 164,
                      autoPlay: true,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        currentIndex = index;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      state.list.length,
                      (index) => Padding(
                          padding: EdgeInsetsDirectional.only(end: 3),
                          child: CircleAvatar(
                            radius: 4,
                            backgroundColor: index == currentIndex ? Theme.of(context).primaryColor : Color(0xff61B80C),
                          )),
                    ),
                  ),
                ],
              );
            } else {
              return Text("Failed");
            }
          }),
          BlocBuilder<CategoriesCubit,CategoriesStates>(
            builder: (context,state) {
              if (state is CategoriesLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is CategoriesSuccessState) {
                return SizedBox(
                  height: 139,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16,),
                      Padding(
                        padding: EdgeInsetsDirectional.symmetric(horizontal: 16),
                        child: Text(
                          "الأقسام",
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
                        ),
                      ),
                      SizedBox(height: 8,),
                      Expanded(
                        child: ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          separatorBuilder: (context, index) => SizedBox(
                            width: 16,
                          ),
                          itemBuilder: (context, index) => _ItemCategory(
                            model: state.list[index],
                          ),
                          itemCount: state.list.length,
                          scrollDirection: Axis.horizontal,
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return Text("Failed");
              }

            }
          ),
          BlocBuilder<ProductsCubit,ProductsStates>(
            builder: (context,state) {
              if (state is ProductsLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ProductsSuccessState) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "الأصناف",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 163 / 250),
                        itemCount: state.list.length,
                        itemBuilder: (context, index) => _ItemProduct(
                          model: state.list[index],
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return Text("Failed");
              }

            }
          ),
        ],
      ),
    );
  }
}

class _ItemCategory extends StatelessWidget {
  final CategoryModel model;
  const _ItemCategory({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 73,
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: 73,
              height: 70,
              padding: EdgeInsets.all(6),
              child: AppImage(
                model.image,
                fit: BoxFit.scaleDown,
              ),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.grey.withOpacity(.1)),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(model.title)
        ],
      ),
    );
  }
}

class _ItemProduct extends StatelessWidget {
  final ProductModel model;
  const _ItemProduct({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(9),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(17), boxShadow: [BoxShadow(color: Colors.black.withOpacity(.02), offset: Offset(0, 2), blurRadius: 11)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(11),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AppImage(
                   model.mainImage,
                    fit: BoxFit.cover,
                  ),
                  Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      child: Text(
                        "${model.discount}%",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadiusDirectional.only(
                          bottomStart: Radius.circular(11),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            model.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            "السعر / 1${model.unit.name}",
            style: TextStyle(color: Color(0xff808080), fontSize: 12, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 3,
          ),
          Text.rich(
            TextSpan(
                text: "${model.price} ر.س",
                style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16, fontWeight: FontWeight.bold),
                children: [TextSpan(text: "\t"), TextSpan(text: "${model.priceBeforeDiscount} ر.س", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, decoration: TextDecoration.lineThrough))]),
          ),
          SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 35,
            child: AppButton(
              text: "أضف للسلة",
              onPress: () {},
            ),
          )
        ],
      ),
    );
  }
}

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            AppImage(
              "assets/images/logo.png",
              height: 21,
              width: 21,
              fit: BoxFit.scaleDown,
            ),
            SizedBox(
              width: 3,
            ),
            Text(
              "سلة ثمار",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
            ),
            Expanded(
              child: Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  text: "التوصيل إلى",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).primaryColor,
                  ),
                  children: [
                    TextSpan(text: "\n"),
                    TextSpan(text: "شارع الملك فهد - جدة", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                CacheHelper.clear();
                navigateTo(LoginView());
              },
              child: Badge(
                alignment: AlignmentDirectional.topStart,
                label: Text(
                  "3",
                  style: TextStyle(
                    fontSize: 6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Theme.of(context).primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Container(
                  height: 33,
                  width: 33,
                  padding: EdgeInsets.all(7),
                  child: SvgPicture.asset("assets/icons/svg/cart.svg"),
                  decoration: BoxDecoration(color: Theme.of(context).primaryColor.withOpacity(.13), borderRadius: BorderRadius.circular(9)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
