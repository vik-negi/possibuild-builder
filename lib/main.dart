import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:possibuild/firebase_options.dart';
import 'package:possibuild/screens/ProfilePage.dart';
import 'package:possibuild/screens/Catalog.dart';
import 'package:possibuild/screens/HomePage.dart';
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NavigatorMenu(),
      routes: {
        '/signin/': (context) => const SignIn(),
        '/signup/': (context) => const SignUp(),
        '/home/': (context) => const HomePage(),
      },
    );
  }
}

class NavigatorMenu extends StatefulWidget {
  NavigatorMenu({Key? key}) : super(key: key);

  @override
  State<NavigatorMenu> createState() => _NavigatorMenuState();
}

class _NavigatorMenuState extends State<NavigatorMenu> {
  int index = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> screens = const <Widget>[
    HomePage(),
    Catalog(),
    ProfilePage(),
  ];

  void _onItemTapped(int i) {
    setState(() {
      index = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens.elementAt(index),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          navbarItem(icon: Icons.home, label: "Home"),
          navbarItem(icon: Icons.favorite_outline_outlined, label: "Favourite"),
          navbarItem(icon: Icons.account_box, label: "Accounts"),
        ],
        currentIndex: index,
        unselectedItemColor: const Color(0xffa1a1a1),
        selectedItemColor: const Color(0xff415859),
        showUnselectedLabels: true,
        selectedIconTheme: const IconThemeData(size: 30),
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  BottomNavigationBarItem navbarItem(
      {required IconData icon, required String label}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
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
        body: FutureBuilder(
            future: Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform,
            ),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  final User? user = FirebaseAuth.instance.currentUser;
                  print(user);
                  if (user != null) {
                    if (user.emailVerified) {
                      return const HomePage();
                    } else {
                      return SendMail();
                      // Center(child : Text("We sent you a verification link"));
                    }
                  } else {
                    return SignIn();
                  }
                default:
                  return const Text("data");
              }
            }));
  }
}

class SendMail extends StatefulWidget {
  SendMail({Key? key}) : super(key: key);

  @override
  State<SendMail> createState() => _SendMailState();
}

class _SendMailState extends State<SendMail> {
  User? user = FirebaseAuth.instance.currentUser;

  bool isMailBtnPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
          child: Column(
        children: [
          TextButton(
              onPressed: () {
                user?.sendEmailVerification();
                setState(() {
                  isMailBtnPressed = !isMailBtnPressed;
                });
              },
              child: const Text("Send Verification mail")),
          Text(isMailBtnPressed ? "We sent you a verification link" : ""),
          TextButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const SignIn()),
                    (route) => false);
              },
              child: const Text("Singout")),
          Text(user?.email ?? ""),
        ],
      )),
    ));
  }
}
