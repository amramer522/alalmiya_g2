import 'package:alalmiya_g2/views/auth/forget_password/view.dart';
import 'package:alalmiya_g2/views/auth/splash/view.dart';
import 'package:flutter/material.dart';

import 'core/logic/helper_methods.dart';
import 'views/auth/login/view.dart';
import 'views/auth/register/view.dart';
import 'views/my_orders/view.dart';
import 'views/notifications/view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(
          primarySwatch: getMyMaterialColor(),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 0,
              titleTextStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: getMyMaterialColor(),
              )),
          filledButtonTheme: FilledButtonThemeData(style: FilledButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), fixedSize: Size.fromHeight(60))),
          outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  side: BorderSide(color: getMyMaterialColor()))),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: Color(0xffF3F3F3))),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: Color(0xffF3F3F3))),
            filled: true,
            fillColor: Colors.white,
          )),
      builder: (context, child) => Directionality(textDirection: TextDirection.rtl, child: child!),
      title: "Amoora",
      home: LoginView(),
    );
  }
}

MaterialColor getMyMaterialColor() {
  Color color = Color(0xff4C8613);
  return MaterialColor(color.value, {
    50: color.withOpacity(.1),
    100: color.withOpacity(.2),
    200: color.withOpacity(.3),
    300: color.withOpacity(.4),
    400: color.withOpacity(.5),
    500: color.withOpacity(.6),
    600: color.withOpacity(.7),
    700: color.withOpacity(.8),
    800: color.withOpacity(.9),
    900: color,
  });
}

/*
1.MaterialApp ( home )
2.Center ( child )
3.Scaffold ( body )
4.Text ( style ( fontSize - fontWeight - color - decoration ))
5.Image.network ( height - width - fit )
6.ListView (children - padding )
7.Row ( children - mainAxisAlignment - crossAxisAlignment )
8.Column ( children - mainAxisAlignment - crossAxisAlignment )
9.Stack ( children )
10.SafeArea ( child )
11.LinearProgressIndicator
12.CircularProgressIndicator
13.SizedBox ( height - width - child )
14.Padding ( padding )
15.FilledButton  ( onPress - child )
16.OutlinedButton ( onPress - child )
17.ElevatedButton ( onPress - child )
18.Icon ( color - size )
19.TextField ( decoration ( border - filled - fillColor - obsecure
                 - obescureCharacter - hintText - labelText - prefixIcon - suffixIcon - icon) )
20.IconButton ( icon - onPress )
21.Container ( decoration ( color - border - borderRadius - gradient - shape )
                  - height - width - color - child - clipBehavior)
22.InkWell ( onTap - borderRadius )
23.GestureDetector ( onTap )
24.CircularAvatar ( radius - backGroundColor - foregroundImage - backgroundImage - child)
25.Align ( alignment )
26.Positioned
27.Transform.translate
28.Image.asset
29.TextButton
30.Directionality
31.Spacer
32.Expanded
33.ListView.builder
34.DecoratedBox
35.Form
36.StatefulBuilder
37.Transform.scale






Packages
1.dio
2.animate_do
3.circular_countdown_timer
4.pin_code_fields


... spreadOperator




Flexible
Switch
CheckBox
Slider
Divider
VerticalDivider

 */
