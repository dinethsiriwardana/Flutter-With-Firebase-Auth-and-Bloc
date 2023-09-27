import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:g_auth_with_bloc/service/auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      User? user;
      if (event is SignOutEvent) {
        await Auth().signOut();
        emit(LogOutState());
      } else if (event is AuthStatusChangedEvent) {
        // Auth().signOut();

        Auth().authStateChanges();
        user = Auth().currentUser;
        print(user);
        if (user != null) {
          emit(AuthStatusSuccess());
        } else {
          emit(AuthStatusError());
        }
      } else if (event is SignInEvent) {
        print(event);
        try {
          Map<String, dynamic> result = await Auth()
              .createUserWithEmailandPassword(event.email, event.password);
          print(result);
          emit(AuthStatusSuccess());
        } catch (e) {
          emit(AuthStatusError(error: e.toString()));
        }
      } else if (event is LoginInEvent) {
        print(event);
        try {
          Map<String, dynamic> result = await Auth()
              .signInWithEmailAndPassword(event.email, event.password);
          print(result);
          emit(AuthStatusSuccess());
        } catch (e) {
          emit(AuthStatusError(error: e.toString()));
        }
      }
    });
  }
}
