import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_auth_with_bloc/bloc/auth/auth_bloc.dart';
import 'package:g_auth_with_bloc/bloc/bloc/login_form_bloc.dart';
import 'package:g_auth_with_bloc/firebase_options.dart';
import 'package:g_auth_with_bloc/pages/home.dart';
import 'package:g_auth_with_bloc/pages/landing_page.dart';
import 'package:g_auth_with_bloc/pages/signpages/signin_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => AuthBloc()..add(AuthStatusChangedEvent()),
      ),
      BlocProvider(
        create: (context) =>
            LoginFormBloc()..add(FormChangedEvent(isLogin: false)),
      ),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        // '/': (context) => const MyApp(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/LandingPage': (context) => const LandingPage(),
        '/SignInPage': (context) => const SignInPage(),
        '/HomePage': (context) => const HomePage(),
      },
      home: const LandingPage(),
    );
  }
}
