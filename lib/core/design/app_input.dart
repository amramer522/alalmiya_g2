import 'package:flutter/material.dart';

class AppInput extends StatefulWidget {
  final String labelText, icon;
  final TextEditingController? controller;
  final bool isPhone, isPassword, isEnabled;
  final double paddingBottom, paddingTop;
  final FormFieldValidator? validator;

  const AppInput({Key? key,this.validator,this.controller, this.isEnabled = true, this.paddingTop = 0, this.isPassword = false, this.paddingBottom = 16, this.isPhone = false, required this.labelText, required this.icon})
      : super(key: key);

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: widget.paddingBottom, top: widget.paddingTop),
      child: TextFormField(
        controller: widget.controller,
        obscureText: isPasswordHidden && widget.isPassword,
        enabled: widget.isEnabled,
        keyboardType: TextInputType.phone,
        validator: widget.validator,
        decoration: InputDecoration(
            labelText: widget.labelText,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(isPasswordHidden ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      isPasswordHidden = !isPasswordHidden;
                      setState(() {});
                    },
                  )
                : null,
            icon: widget.isPhone
                ? Container(
                    height: 60,
                    width: 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/saudi.png",
                          width: 32,
                          height: 20,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "+966",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white, border: Border.all(color: Color(0xffF3F3F3))),
                  )
                : null,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12),
              child: Image.asset(
                widget.icon,
                fit: BoxFit.scaleDown,
                height: 20,
                width: 18,
              ),
            )),
      ),
    );
  }
}
