
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:possibuild/firebase_options.dart';
import 'package:possibuild/screens/Home.dart';
import 'package:possibuild/screens/SigninPage.dart';
import 'package:possibuild/screens/SignupPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      routes: {
        '/signin/':(context) => const SignIn(),
        '/signup/':(context) => const SignUp(),
        '/home/':(context) => const HomePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 23, 25, 26),
      appBar: AppBar(
        title: const Text("hii"),
      ),
      body: FutureBuilder(
            future: Firebase.initializeApp(
                      options: DefaultFirebaseOptions.currentPlatform,
                    ),
            builder: (context, snapshot){
              switch (snapshot.connectionState){
                case ConnectionState.done:
                final User? user =  FirebaseAuth.instance.currentUser;
                print(user);
                if(user?.emailVerified ?? false){
                  print("You are varified user");
                }else{
                  print("You need to verify email");
                }
                return const Text("hii");
                default:
                return Text("data");
              }
            }
      )
    );
  }
}
