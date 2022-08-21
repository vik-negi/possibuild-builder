import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:possibuild/firebase_options.dart';
import 'package:possibuild/main.dart';
import 'package:possibuild/screens/SignupPage.dart';
import 'package:possibuild/services/auth/auth_provider.dart';
import 'package:possibuild/services/auth/firebase_auth_provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  late final AuthProvider provider;

  bool _isProcessing = false;
  bool _rembemberMe = false;
  bool _showPassword = false;

  // Future<FirebaseApp> _initializeFirebase() async {
  //   Future<FirebaseApp> firebaseApp =  Firebase.initializeApp();
  //   FirebaseAuthProvider user = FirebaseAuthProvider();
  //   // users =  user.currentUser!;

  //   if(user.currentUser! != null){
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(builder: (context)=> const MyHomePage())
  //     );
  //   }

  //   return firebaseApp;
  // }
  FirebaseAuthProvider user = FirebaseAuthProvider();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _focusEmail.unfocus();
          _focusPassword.unfocus();
        },
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 23, 25, 26),
          body: FutureBuilder(
              future: Firebase.initializeApp(
                options: DefaultFirebaseOptions.currentPlatform,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height - 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(255, 32, 36, 39),
                      ),
                      margin: const EdgeInsets.only(
                          left: 15, right: 15, top: 35, bottom: 15),
                      padding: const EdgeInsets.all(15),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Form(
                              key: _formKey,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    // const Text("We Are Excited to\nOnboard you",
                                    //   style: TextStyle(
                                    //     color: Color.fromARGB(255, 235, 235, 235),
                                    //     fontSize: 32,
                                    //     fontWeight: FontWeight.w500,

                                    //   ),
                                    // ),

                                    // ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        child: const Text(
                                          "Sign In ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    TextFormField(
                                      controller: emailController,
                                      focusNode: _focusEmail,
                                      // validator: (value)=> Validator.validateEmail(email: value!),
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: const InputDecoration(
                                        hintText: "Email",
                                        errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.red,
                                          ),
                                        ),
                                        prefixIcon: Icon(Icons.person,
                                            color: Colors.white),
                                        // disabledBorder: InputBorder.none,
                                        filled: true,
                                        fillColor:
                                            Color.fromARGB(255, 43, 47, 51),
                                        labelText: "Email Address",
                                        labelStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                        // border:  InputBorder.none,
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(35)),
                                            borderSide: BorderSide.none),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    TextFormField(
                                      obscureText: _showPassword ? false : true,
                                      focusNode: _focusPassword,
                                      // validator: (value)=> Validator.validatePassword(password: value!),
                                      style:
                                          const TextStyle(color: Colors.white),
                                      controller: passwordController,
                                      decoration: InputDecoration(
                                        hintText: "Password",
                                        errorBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.red,
                                          ),
                                        ),
                                        prefixIcon: const Icon(
                                            Icons.verified_user_outlined,
                                            color: Colors.white),
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _showPassword = !_showPassword;
                                              });
                                            },
                                            icon: Icon(
                                                _showPassword
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: Colors.white)),
                                        labelText: "Password",
                                        labelStyle: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(35)),
                                            borderSide: BorderSide.none),
                                        // focusedBorder: InputBorder.none,
                                        filled: true,
                                        fillColor: const Color.fromARGB(
                                            255, 43, 47, 51),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Checkbox(
                                                value: _rembemberMe,
                                                onChanged: (bool? newValue) =>
                                                    setState(() {
                                                      _rembemberMe = newValue!;
                                                    })),
                                            const Text("Remember Me",
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 211, 211, 211),
                                                )),
                                          ],
                                        ),
                                        Container(
                                            alignment: Alignment.topRight,
                                            child: TextButton(
                                                onPressed: () {},
                                                child: const Text(
                                                    "Forget Password",
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 211, 211, 211),
                                                    )))),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    _isProcessing
                                        ? const Center(
                                            child: CircularProgressIndicator())
                                        : Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(35)),
                                            height: 50,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: ElevatedButton(
                                                onPressed: () async {
                                                  _focusEmail.unfocus();
                                                  _focusPassword.unfocus();
                                                  // unstop
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    setState(() {
                                                      _isProcessing = true;
                                                    });

                                                    try {
                                                      final userCredential = FirebaseAuth
                                                          .instance
                                                          .signInWithEmailAndPassword(
                                                              email:
                                                                  emailController
                                                                      .text
                                                                      .trim(),
                                                              password:
                                                                  passwordController
                                                                      .text
                                                                      .trim());
                                                      print(userCredential);
                                                      // if(userCredential != null){
                                                      //   Navigator.pushNamed(context, "/home/");
                                                      // }
                                                      if (FirebaseAuth.instance
                                                              .currentUser !=
                                                          null) {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    ((context) =>
                                                                        const MyHomePage())));
                                                      }
                                                    } on FirebaseAuthException catch (e) {
                                                      if (e.code ==
                                                          "user-not-found") {
                                                        print("User not found");
                                                      }
                                                    } catch (e) {
                                                      return;
                                                    }

                                                    setState(() {
                                                      _isProcessing = false;
                                                    });

                                                    // if(user !=null){
                                                    //   // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const HomePage(),));

                                                    // }else{

                                                    // }
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        35))),
                                                child: const Text(
                                                  "Login",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                )),
                                          ),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 2,
                                          child: Container(
                                            width: 0.4 *
                                                MediaQuery.of(context)
                                                    .size
                                                    .width,
                                            color: const Color.fromARGB(
                                                255, 80, 80, 80),
                                          ),
                                        ),
                                        Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 0, horizontal: 1.5),
                                            child: const Text("or",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 32, 36, 39),
                                                ))),
                                        SizedBox(
                                          height: 2,
                                          child: Container(
                                            width: 0.4 *
                                                MediaQuery.of(context)
                                                    .size
                                                    .width,
                                            color: const Color.fromARGB(
                                                255, 80, 80, 80),
                                          ),
                                        ),

                                        // SizedBox(height: 2, child: Container(color: const Color.fromARGB(255, 80, 80, 80)),),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // CircleAvatar(child: Icon(Icons.facebook)),
                                        SignInButton(
                                          Buttons.Facebook,
                                          onPressed: () {},
                                          mini: true,
                                        ),
                                        SignInButton(Buttons.GitHub,
                                            onPressed: () {}, mini: true),
                                        SignInButton(Buttons.Apple,
                                            onPressed: () {}, mini: true),
                                        SignInButton(Buttons.Microsoft,
                                            onPressed: () {}, mini: true),
                                        SignInButton(Buttons.LinkedIn,
                                            onPressed: () {}, mini: true),

                                        SignInButtonBuilder(
                                          icon: Icons.mail,
                                          text: "button",
                                          mini: true,
                                          onPressed: () {},
                                          backgroundColor: Colors.cyan,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Center(
                                        child: SignInButton(Buttons.Google,
                                            onPressed: () {},
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 3, horizontal: 25)))
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Do not have accoutn?",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        // Navigator.pushNamed(context, "./signup");
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (content) =>
                                                    const SignUp()));
                                      },
                                      child: const Text("Sign up")),
                                ],
                              ),
                            ),
                          ]),
                    ),
                    // ]
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ));
    // );
  }
}
