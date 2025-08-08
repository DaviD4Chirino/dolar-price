import 'package:awesome_dolar_price/l10n/app_localizations.dart';
import 'package:awesome_dolar_price/tokens/app/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = useState(0);
    AppLocalizations t = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.homeTitle),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, AppRoutes.settings),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => counter.value++,
        child: const Icon(Icons.add),
      ),
      body: Center(child: Text("Counter: ${counter.value}")),
    );
  }
}
