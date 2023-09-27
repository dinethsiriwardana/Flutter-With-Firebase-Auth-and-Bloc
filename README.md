# g_auth_with_bloc

##add this code to main.dart
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
options: DefaultFirebaseOptions.currentPlatform,
);

##add bloc provider to home:
BlocProvider(
create: (context) => CounterBloc(),
child: const MyHomePage(title: 'Flutter Demo Home Page'),
),

##Goto ios folder > open Podfile and uncomment this line:
platform :ios, '11.0'

cd ios
pod install

if its not working try

pod repo update
pod install --repo-update`
