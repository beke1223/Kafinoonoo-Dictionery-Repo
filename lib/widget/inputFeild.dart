import 'package:flutter/material.dart';

class InputFieldWidget extends StatelessWidget {
  final Function callBackFunction;
  final String hintText;
  const InputFieldWidget({
    required this.callBackFunction,
    required this.hintText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        onChanged: (ValueKey) {
          callBackFunction(ValueKey);
        },
        // onChanged: (value) =>
        //     ref.read(dataProvider.notifier).filterWords(value),
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: const Icon(
            Icons.search,
          ),
          // focusedBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.only(
          //     topLeft: Radius.circular(20),
          //     bottomLeft: Radius.circular(20),
          //   ),
          // ),
        ),
      ),
    );
  }
}
