import 'package:alalmiya_g2/features/get_cities/states.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/get_cities/bloc.dart';
import '../../features/get_cities/model.dart';

class CitiesSheet extends StatefulWidget {
  const CitiesSheet({Key? key}) : super(key: key);

  @override
  State<CitiesSheet> createState() => _CitiesSheetState();
}

class _CitiesSheetState extends State<CitiesSheet> {
  @override
  Widget build(BuildContext context) {

    return Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            Text(
              "اختر مدينتك",
              style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18, fontWeight: FontWeight.w700),
            ),
            BlocBuilder<GetCitiesBloc, GetCitiesStates>(
              // bloc: cubit,
              builder: (context, state) {
                if (state is GetCitiesLoadingState) {
                  return Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is GetCitiesSuccessState) {
                  return Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(16),
                      itemBuilder: (context, index) => _ItemCity(
                        model: state.list[index],
                      ),
                      itemCount: state.list.length,
                    ),
                  );
                } else {
                  return Text("Failed");
                }
              },
            ),
          ],
        )
        // child: ,
        );
  }
}

class _ItemCity extends StatelessWidget {
  final CityModel model;

  const _ItemCity({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context, model);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), color: Theme.of(context).primaryColor.withOpacity(.1)),
        child: Center(child: Text(model.name)),
      ),
    );
  }
}
