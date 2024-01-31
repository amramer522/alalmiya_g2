import 'package:flutter/material.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("طلباتي"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => _Item(),
        itemCount: 3,
        padding: EdgeInsets.all(16),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.black.withOpacity(.02), offset: Offset(0, 6), blurRadius: 17, blurStyle: BlurStyle.outer)]),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "طلب #4587",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(
                "27 يونيو,2021,",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff9C9C9C),
                ),
              ),
              SizedBox(
                height: 13,
              ),
              Row(
                children: [
                  ...List.generate(
                      9,
                      (index) => Container(
                            height: 25,
                            width: 25,
                            margin: EdgeInsetsDirectional.only(end: 3),
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), border: Border.all(color: Colors.red), color: Colors.yellow),
                            child: Image.network(
                              "https://st.depositphotos.com/1002351/1976/i/950/depositphotos_19761089-stock-photo-tomato-vegetables-pile.jpg",
                              height: 25,
                              width: 25,
                              fit: BoxFit.fill,
                            ),
                          )),
                  Container(
                    height: 25,
                    width: 25,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Theme.of(context).primaryColor.withOpacity(.13),
                    ),
                    child: Center(
                        child: Text(
                      "+2",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    )),
                  ),
                ],
              )
            ],
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Theme.of(context).primaryColor.withOpacity(.13),
                ),
                child: Center(
                    child: Text(
                  "بإنتظار الموافقة",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                )),
              ),
              Text(
                "180ر.س",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).primaryColor,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
