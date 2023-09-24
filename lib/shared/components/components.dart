import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


Widget defaultFormField({
        required TextEditingController controller,
        required TextInputType type,
        Function(String)? onSubmit,
        Function(String)? onChange,
        void Function()? onTap,
        required String? Function(String?)? validate,
        required String? label,
        required String? hint,
        required Widget? prefix,
        Widget? suffix,
        bool isPassword = false,
}) =>
    TextFormField(
            validator: validate,
            controller: controller,
            keyboardType: type,
            obscureText: isPassword,
            decoration: InputDecoration(
                    hintText: hint,
                    labelText: label,
                    border: const OutlineInputBorder(),
                    prefixIcon: prefix,
                    suffixIcon: suffix,
            ),
            onFieldSubmitted: onSubmit,
            onChanged: onChange,
            onTap: onTap,
    );

Widget defaultButton({
        double width = double.infinity,
        Color background = Colors.blue,
        bool isUpperCase = true,
        double radius = 0.0,
        void Function()? function,
        required String text,
}) =>
    Container(
            decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(radius)),
            width: width,
            height: 60,
            child: MaterialButton(
                    onPressed: function,
                    height: 60,
                    color: background,
                    textColor: Colors.white,
                    child: Text(isUpperCase ? text.toUpperCase() : text),
            ),
    );

Widget defaultTextButton({
  required Function function,
  required String text
}) => TextButton(onPressed: (){function();}, child: Text(text.toUpperCase()));
void navigateTo(BuildContext context, Widget widget) => Navigator.push(
    context, MaterialPageRoute(builder: (BuildContext context) => widget));

void navigateAndFinish(BuildContext context, Widget widget) =>
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => widget),
        (Route<dynamic> route) => false);
