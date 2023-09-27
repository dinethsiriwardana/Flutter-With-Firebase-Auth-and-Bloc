// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_auth_with_bloc/bloc/auth/auth_bloc.dart';
import 'package:g_auth_with_bloc/bloc/bloc/login_form_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // TextEditingController for controll and get data from TextInput Field
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // FocusNode for controll focus and transfer focus between TextInput Field
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  //Assign TextEditingControllers text to variable
  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  final _formKey = GlobalKey<FormState>();

  late AuthBloc authBloc;
  late LoginFormBloc loginFormBloc;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    loginFormBloc = BlocProvider.of<LoginFormBloc>(context);
    super.initState();
  }

  bool isLogin = true;

  // void _submit() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthStatusSuccess) {
              Navigator.pushNamed(context, '/HomePage');
            } else if (state is AuthStatusError) {
              String error = state.error ?? "Something went wrong";
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(error),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 50.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Column(
                    children: [
                      EmailInput(),
                      const SizedBox(
                        height: 20.0,
                      ),
                      PasswordInput(),
                      const SizedBox(
                        height: 50.0,
                      ),
                      SizedBox(
                          height: 50.0,
                          width: 320.0,
                          child: BlocBuilder<LoginFormBloc, LoginFormState>(
                              builder: (context, state) {
                            if (state is FormChangedState) {
                              isLogin = state.isLogin;
                              if (state.isLogin) {
                                return submitBtn(context);
                              } else {
                                return submitBtn(context);
                              }
                            }
                            return const SizedBox();
                          })),
                      TextButton(
                          onPressed: () {
                            loginFormBloc
                                .add(FormChangedEvent(isLogin: isLogin));
                          },
                          child: const Text(
                            "No account ? Register",
                            style: TextStyle(color: Colors.black),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton submitBtn(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
            Radius.circular(50.0),
          ))),
      onPressed: () {
        try {
          isLogin
              ? authBloc.add(LoginInEvent(email: _email, password: _password))
              : authBloc.add(SignInEvent(email: _email, password: _password));
        } catch (e) {
          // ignore: avoid_print
          print(e.toString());
        }
      },
      child: Text(
        isLogin ? 'Login' : "Register",
        style: const TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }

  SizedBox PasswordInput() {
    return SizedBox(
      width: 320.0,
      height: 55.0,
      child: TextField(
        controller: _passwordController,
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 216, 0, 58),
              width: 2.0,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 216, 122, 0),
              width: 2.0,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          hintText: 'Password',
          labelText: 'Enter your Password',
          // errorText: "widget.invalidEmailErrorText",
          hintStyle: TextStyle(
            fontSize: 15,
          ),
          labelStyle: TextStyle(
            fontSize: 15,
          ),
        ),
        autocorrect: false,
        obscureText: true,
        onChanged: (email) => _updateState(),
      ),
    );
  }

  SizedBox EmailInput() {
    return SizedBox(
      width: 320.0,
      height: 55.0,
      child: TextField(
        controller: _emailController,
        focusNode: _emailFocusNode,
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 216, 0, 58),
              width: 2.0,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 216, 122, 0),
              width: 2.0,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          hintText: 'Enter your Email',
          labelText: 'Email',
          hintStyle: TextStyle(
            fontSize: 15,
          ),
          labelStyle: TextStyle(
            fontSize: 15,
          ),
        ),
        onChanged: (password) => _updateState(),
      ),
    );
  }

  _updateState() {
    setState(() {});
  }
}
