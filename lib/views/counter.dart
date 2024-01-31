import 'package:alalmiya_g2/core/logic/cache_helper.dart';
import 'package:alalmiya_g2/main.dart';
import 'package:flutter/material.dart';

class CounterView extends StatefulWidget {
  const CounterView({Key? key}) : super(key: key);

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  int count = CacheHelper.getCount();

  @override
  void initState() {
    super.initState();
    CacheHelper.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              onPressed: () {
                count++;
                CacheHelper.setCount(count);
                setState(() {});
              },
              child: Icon(Icons.add),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "$count",
                style: TextStyle(fontSize: 35),
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                count--;
                CacheHelper.setCount(count);
                setState(() {});
              },
              child: Icon(Icons.remove),
            ),
          ],
        ),
      ),
    );
  }
}
