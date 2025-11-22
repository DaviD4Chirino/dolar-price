import 'package:flutter/material.dart';

class CurrencySelectorButton extends StatelessWidget {
  const CurrencySelectorButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Elegir Monedas'),
      subtitle: Text(
        'Selecciona las monedas que deseas ver en el aplicación',
      ),
      leading: Icon(Icons.check_circle_outline_rounded),
      onTap: () {},
    );
  }
}
