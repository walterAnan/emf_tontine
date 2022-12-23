
import 'package:emf_tontine/presentation/colors/colors.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {

  final IconData icon;
  final String hint;
  final bool obscureText;
  final TextInputType inputType;
  final TextInputAction? inputAction;
  final TextEditingController textController;


  static bool Validation(String test){
    return false;
  }


  const InputField({
    Key? key,
    required this.icon,
    required this.hint,
    this.obscureText = false,
    this.inputType = TextInputType.text,
    this.inputAction, required this.textController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10
      ),
      decoration: const BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: SizedBox(
        height: 60,
        child: TextFormField(
          style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontSize: 22),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 5,
            ),
            hintText: hint,
            prefixIcon: Icon(
              icon,
              color: Colors.black,
            ),
            // hintStyle: kInputHintTextStyle,
            border: InputBorder.none
          ),
          obscureText: obscureText,
          textAlign: TextAlign.left,
          // style: kInputTextStyle,
          keyboardType: inputType,
          textInputAction: inputAction,
          controller: textController,
        ),
      ),
    );
  }
}
