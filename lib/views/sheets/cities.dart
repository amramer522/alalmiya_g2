import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../models/cities.dart';

class CitiesSheet extends StatefulWidget {
  const CitiesSheet({Key? key}) : super(key: key);

  @override
  State<CitiesSheet> createState() => _CitiesSheetState();
}

class _CitiesSheetState extends State<CitiesSheet> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  bool isLoading = true;

  late GetCitiesData model;
  void getData() async {
    final response = await Dio().get("https://thimar.amr.aait-d.com/api/cities/1");
    print(response.data);
    model = GetCitiesData.fromJson(response.data);
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 16,),
            Text("اختر مدينتك",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 18,fontWeight: FontWeight.w700),),
            isLoading
                ? Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
                : Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(16),
                      itemBuilder: (context, index) => _ItemCity(
                        model: model.list[index],
                      ),
                      itemCount: model.list.length,
                    ),
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
