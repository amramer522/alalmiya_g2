import 'package:flutter/material.dart';

import 'model.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<NotificationModel> list = [
    NotificationModel(
      time: "منذ ساعتان",
      body: "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى",
      title: "تم قبول طلبك وجاري تحضيره الأن",
      image: "https://img.freepik.com/free-vector/speech-bubble_53876-43873.jpg?w=826&t=st=1693740648~exp=1693741248~hmac=16360f30dfcc1059b1ffca5fa91ee672f54bfc4cb0cf825d9ba7fa0eff19fd13",
    ),
    NotificationModel(
      time: "منذ ساعه",
      body: "Hello",
      title: "تم قبول طلبك ٢وجاري تحضيره الأن",
      image: "https://img.freepik.com/free-vector/speech-bubble_53876-43873.jpg?w=826&t=st=1693740648~exp=1693741248~hmac=16360f30dfcc1059b1ffca5fa91ee672f54bfc4cb0cf825d9ba7fa0eff19fd13",
    ),
    NotificationModel(
      time: "منذ ساعه",
      body: "Hello3",
      title: "تم قبول طلبك ٢وجاري تحضيره الأن3",
      image: "https://img.freepik.com/free-vector/speech-bubble_53876-43873.jpg?w=826&t=st=1693740648~exp=1693741248~hmac=16360f30dfcc1059b1ffca5fa91ee672f54bfc4cb0cf825d9ba7fa0eff19fd13",
    ),
    NotificationModel(
      time: "منذ ساعه",
      body: "Hello3",
      title: "تم قبول طلبك ٢وجاري تحضيره الأن3",
      image: "https://img.freepik.com/free-vector/speech-bubble_53876-43873.jpg?w=826&t=st=1693740648~exp=1693741248~hmac=16360f30dfcc1059b1ffca5fa91ee672f54bfc4cb0cf825d9ba7fa0eff19fd13",
    ),
  ];

  @override
  void initState() {
    super.initState();
    getData();
  }

  bool isLoading = true;

  getData() async {
    await Future.delayed(Duration(seconds: 3));
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "الإشعارات",
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemBuilder: (context, index) => _Item(model: list[index]),
              itemCount: list.length,
            ),
    );
  }
}

class _Item extends StatelessWidget {
  final NotificationModel model;

  const _Item({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            height: 33,
            width: 33,
            padding: EdgeInsets.all(6.5),
            decoration: BoxDecoration(color: Theme.of(context).primaryColor.withOpacity(.13), borderRadius: BorderRadius.circular(9)),
            child: Image.network(
              model.image,
              fit: BoxFit.scaleDown,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.title,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
                Text(model.body, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300, color: Color(0xff989898))),
                Text(model.time, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
