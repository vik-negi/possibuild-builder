import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:possibuild/screens/HomePage.dart';
import 'package:possibuild/screens/SigninPage.dart';
import 'package:possibuild/services/auth/auth_provider.dart';
import 'package:possibuild/services/auth/auth_service.dart';
import 'package:possibuild/services/auth/auth_user.dart';
import 'package:possibuild/services/auth/firebase_auth_provider.dart';

import '../firebase_options.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _registerFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _rembemberMe = false;
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusName.unfocus();
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 23, 25, 26),
          body: SingleChildScrollView(
            child: FutureBuilder(
                future: Firebase.initializeApp(
                  options: DefaultFirebaseOptions.currentPlatform,
                ),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      return Container(
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
                                key: _registerFormKey,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      const Text(
                                        "We Are Excited to\nOnboard you",
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 235, 235, 235),
                                          fontSize: 32,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),

                                      // ),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      Container(
                                          alignment: Alignment.centerLeft,
                                          child: const Text(
                                            "Sign Up",
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
                                        decoration: const InputDecoration(
                                          errorBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                            color: Colors.red,
                                          )),
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
                                        height: 15,
                                      ),
                                      TextFormField(
                                        focusNode: _focusName,
                                        // validator: (value)=> Validator.validateName(name: value),
                                        controller: usernameController,
                                        decoration: const InputDecoration(
                                          prefixIcon: Icon(Icons.person,
                                              color: Colors.white),
                                          // disabledBorder: InputBorder.none,
                                          filled: true,
                                          fillColor:
                                              Color.fromARGB(255, 43, 47, 51),
                                          labelText: "Username",
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
                                        height: 15,
                                      ),
                                      TextFormField(
                                        focusNode: _focusPassword,
                                        // validator: (value) => Validator.validatePassword(
                                        // password: value!,
                                        // ),
                                        obscureText: true,
                                        controller: passwordController,
                                        decoration: const InputDecoration(
                                          errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                            ),
                                          ),
                                          prefixIcon: Icon(
                                              Icons.verified_user_outlined,
                                              color: Colors.white),
                                          labelText: "Password",
                                          labelStyle: TextStyle(
                                            color: Colors.white,
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(35)),
                                              borderSide: BorderSide.none),
                                          // focusedBorder: InputBorder.none,
                                          filled: true,
                                          fillColor:
                                              Color.fromARGB(255, 43, 47, 51),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      TextField(
                                        obscureText: true,
                                        controller: confirmPasswordController,
                                        decoration: const InputDecoration(
                                          prefixIcon: Icon(
                                              Icons.verified_user_outlined,
                                              color: Colors.white),
                                          labelText: "Confirm Password",
                                          labelStyle: TextStyle(
                                            color: Colors.white,
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(35)),
                                              borderSide: BorderSide.none),
                                          // focusedBorder: InputBorder.none,
                                          filled: true,
                                          fillColor:
                                              Color.fromARGB(255, 43, 47, 51),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Checkbox(
                                              value: _rembemberMe,
                                              onChanged: (bool? newValue) =>
                                                  setState(() {
                                                    _rembemberMe = newValue!;
                                                  })),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  const Text(
                                                      "By Signing up you are accept the",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Color.fromARGB(
                                                            255, 211, 211, 211),
                                                      )),
                                                  SizedBox(
                                                    height: 30,
                                                    child: TextButton(
                                                      onPressed: () {
                                                        Navigator.pushNamed(
                                                            context,
                                                            "./signin");
                                                      },
                                                      child: const Text(
                                                          "Term and Service",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    211,
                                                                    211,
                                                                    211),
                                                          )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Text("and",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Color.fromARGB(
                                                            255, 211, 211, 211),
                                                      )),
                                                  SizedBox(
                                                    // width: 250,
                                                    height: 30,
                                                    child: TextButton(
                                                      onPressed: () {
                                                        // Navigator.pushNamed(
                                                        // context, "./signin");
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (content) =>
                                                                        const SignUp()));
                                                      },
                                                      style:
                                                          TextButton.styleFrom(
                                                        backgroundColor:
                                                            Colors.black,
                                                      ),
                                                      child: const Text(
                                                          "Privacy Policy",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    211,
                                                                    211,
                                                                    211),
                                                          )),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      if (_isProcessing)
                                        const CircularProgressIndicator()
                                      else
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(35)),
                                          height: 50,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: ElevatedButton(
                                              onPressed: () async {
                                                setState(() {
                                                  _isProcessing = true;
                                                });
                                                // AuthService user = AuthService(provider);

                                                if (_registerFormKey
                                                    .currentState!
                                                    .validate()) {
                                                  // user.createUser( email: emailController.text, password: passwordController.text);

                                                  try {
                                                    await FirebaseAuth.instance
                                                        .createUserWithEmailAndPassword(
                                                            email:
                                                                emailController
                                                                    .text,
                                                            password:
                                                                passwordController
                                                                    .text);
                                                    final User? user =
                                                        FirebaseAuth.instance
                                                            .currentUser;
                                                    print(user);
                                                    if (user != null) {
                                                      // ignore: use_build_context_synchronously
                                                      Navigator.pushNamed(
                                                          context, '/signin/');
                                                    }
                                                  } on FirebaseAuthException catch (e) {
                                                    print(e);
                                                  }
                                                  setState(() {
                                                    _isProcessing = false;
                                                  });
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              35))),
                                              child: const Text(
                                                "Sign Up",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )),
                                        ),
                                      const SizedBox(height: 20),
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
                                      "Already have an account?",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SignIn()));
                                        },
                                        child: const Text("Sign in")),
                                  ],
                                ),
                              ),
                            ]),
                      );
                    default:
                      return const Center(child: CircularProgressIndicator());
                  }
                }),
            // ]
          )),
    );
  }
}
