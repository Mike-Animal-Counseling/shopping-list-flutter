import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/shopping/bloc/shopping_event.dart';
import 'features/shopping/bloc/shopping_bloc.dart';
import 'features/shopping/ui/shopping_home_page.dart';
import 'services/sound_service.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final soundService = SoundService();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: soundService),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => ShoppingBloc()..add(ShoppingStarted()),
          ),
        ],
        child: MaterialApp(
          title: 'Shopping List',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: Colors.green,
          ),
          home: const ShoppingHomePage(),
        ),
      ),
    );
  }
}
