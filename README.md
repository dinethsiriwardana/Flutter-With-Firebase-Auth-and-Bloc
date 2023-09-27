## Setting up Firebase Authentication with BLoC in Flutter

### Step 1: Initialize Firebase

In your `main.dart` file, ensure that Flutter is initialized with Firebase using the following code:

```dart
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```

### Step 2: Add BLoC Provider

In your home screen or wherever you want to use BLoC, wrap your main methode with `BlocProvider` to provide access to your BLoC instance. Here's an example:

```dart
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

```

### Step 3: Configure iOS Platform

If you're targeting iOS, make sure to configure your `ios/Podfile`. Open the `Podfile` and uncomment or add the following line:

```ruby
platform :ios '11.0'
```

Then, navigate to the `ios` directory in your project and run:

```bash
cd ios
pod install
```

If the installation doesn't work, try updating your pod repo and reinstalling:

```bash
pod repo update
pod install --repo-update
```

That's it! You've successfully set up Firebase Authentication with BLoC in your Flutter project. Make sure to replace `AuthBloc` with your actual BLoC class name.
