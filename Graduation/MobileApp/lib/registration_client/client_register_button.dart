import 'package:flutter/material.dart';


class ClientRegisterButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const ClientRegisterButton({
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