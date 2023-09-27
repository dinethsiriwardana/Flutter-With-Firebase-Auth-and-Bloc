import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_auth_with_bloc/bloc/auth/auth_bloc.dart';
import 'package:g_auth_with_bloc/pages/home.dart';
import 'package:g_auth_with_bloc/pages/signpages/signin_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late AuthBloc authBloc;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        if (state is AuthStatusError || state is LogOutState) {
          return const SignInPage();
        } else if (state is AuthStatusSuccess) {
          return const HomePage();
        }
        return Center(
          child: Text(
            state.toString(),
            style: const TextStyle(fontSize: 30),
          ),
        );
      }),
    );
  }
}
