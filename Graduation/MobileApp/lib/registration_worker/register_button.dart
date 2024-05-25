import 'package:flutter/material.dart';


class RegisterButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const RegisterButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed?.call();
      },
      child: const Text('Зарегистрироваться'),
    );
  }
}