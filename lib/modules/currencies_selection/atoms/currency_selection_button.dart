import 'package:doya/tokens/app/app_routes.dart';
import 'package:flutter/material.dart';

class CurrencySelectionButton extends StatelessWidget {
  const CurrencySelectionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Elegir Monedas'),
      subtitle: Text('Añade o elimina monedas'),
      leading: Icon(Icons.check_circle_outline_rounded),
      onTap: () => Navigator.pushNamed(
        context,
        AppRoutes.currenciesSelection,
      ),
    );
  }
}
