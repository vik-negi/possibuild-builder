import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:possibuild/components/textContainer.dart';
import 'package:possibuild/components/textffWidget.dart';
import 'package:possibuild/firebase_options.dart';
import 'package:possibuild/main.dart';
import 'package:possibuild/models/userModel.dart';
import 'package:possibuild/screens/SignupPage.dart';
import 'package:possibuild/services/auth/auth_provider.dart';
import 'package:possibuild/services/auth/firebase_auth_provider.dart';
import 'package:possibuild/utils/validator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  Map mapResponce = {};
  Map userData = {};

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  late final AuthProvider provider;

  bool _isProcessing = false;
  bool _rembemberMe = false;
  bool _showPassword = false;
  FirebaseAuthProvider user = FirebaseAuthProvider();

  String url = 'https://api-telly-tell.herokuapp.com/api/client/signin';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
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
                    color: const Color.fromARGB(255, 245, 245, 245),
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
                              const TextContainer(
                                text: "Welcom Back",
                                fontweight: FontWeight.w500,
                                size: 32,
                              ),
                              const TextContainer(
                                text: "Greate to see you again",
                                fontweight: FontWeight.w500,
                                size: 18,
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              const TextContainer(
                                  text: "Sign In ",
                                  fontweight: FontWeight.w500,
                                  size: 30),
                              const SizedBox(
                                height: 25,
                              ),
                              TextffWidget(
                                controller: emailController,
                                focus: _focusEmail,
                                hintText: 'abcd@gmail.com',
                                icon: Icons.person,
                                labelText: 'Email Addresss',
                                isPassword: false,
                                isUsername: false,
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              TextFormField(
                                obscureText: _showPassword ? false : true,
                                focusNode: _focusPassword,
                                validator: (value) =>
                                    Validator.validatePassword(
                                        password: value!),
                                controller: passwordController,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  errorBorder: const UnderlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(35)),
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.verified_user_outlined,
                                    color: Colors.white,
                                  ),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _showPassword = !_showPassword;
                                        });
                                      },
                                      icon: Icon(
                                        _showPassword
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: _showPassword
                                            ? const Color(0xffa1a1a1)
                                            : const Color(0xffffffff),
                                      )),
                                  labelText: "Password",
                                  filled: true,
                                  fillColor:
                                      const Color.fromARGB(255, 43, 47, 51),
                                  labelStyle: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(35)),
                                    borderSide: BorderSide.none,
                                  ),
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
                                        onChanged: (bool? newValue) => setState(
                                          () {
                                            _rembemberMe = newValue!;
                                          },
                                        ),
                                      ),
                                      const Text(
                                        "Remember Me",
                                      ),
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.topRight,
                                    child: TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        "Forget Password",
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
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
                                      width: MediaQuery.of(context).size.width,
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
                                              // final userCredential = FirebaseAuth
                                              //     .instance
                                              //     .signInWithEmailAndPassword(
                                              //         email: emailController
                                              //             .text
                                              //             .trim(),
                                              //         password:
                                              //             passwordController
                                              //                 .text
                                              //                 .trim());
                                              // if (FirebaseAuth
                                              //         .instance.currentUser !=
                                              //     null) {
                                              //   Navigator.of(context).push(
                                              //     MaterialPageRoute(
                                              //       builder: ((context) =>
                                              //           const MainPage()),
                                              //     ),
                                              //   );
                                              // }
                                              final user = signinUser(
                                                  emailController.text,
                                                  passwordController.text);
                                              // if (user != null) {
                                              //   Navigator.of(context).push(
                                              //     MaterialPageRoute(
                                              //       builder: ((context) =>
                                              //           const MainPage()),
                                              //     ),
                                              //   );
                                              // }
                                            }
                                            // on FirebaseAuthException catch (e) {
                                            //   if (e.code == "user-not-found") {
                                            //     throw Exception(
                                            //         "User not found");
                                            //   }
                                            // }
                                            catch (e) {
                                              throw Exception(e);
                                            }

                                            setState(() {
                                              _isProcessing = false;
                                            });
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(35),
                                          ),
                                        ),
                                        child: const Text(
                                          "Login",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Container(
                                    height: 2,
                                    width:
                                        0.4 * MediaQuery.of(context).size.width,
                                    color:
                                        const Color.fromARGB(255, 80, 80, 80),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 1.5),
                                    child: const Text(
                                      "or",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 2,
                                    width:
                                        0.4 * MediaQuery.of(context).size.width,
                                    color:
                                        const Color.fromARGB(255, 80, 80, 80),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              const SizedBox(height: 10),
                              Center(
                                child: SignInButton(
                                  Buttons.Google,
                                  onPressed: () {},
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 25),
                                ),
                              ),
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
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                            TextButton(
                              onPressed: () {
                                // Navigator.pushNamed(context, "./signup");
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (content) => const SignUp(),
                                  ),
                                );
                              },
                              child: const Text("Sign up"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Future signinUser(String email, String password) async {
    Map userData = {
      "email": email,
      "password": password,
    };

    http.Response response = await http.post(Uri.parse(url), body: userData);
    print(response.statusCode);
    mapResponce = await json.decode(response.body);
    userData = mapResponce["userData"];
    print(response.body);

    UserModel userModel = UserModel(
      firstName: userData['firstName'],
      lastName: userData['lastName'],
      email: userData['email'],
      password: userData['password'],
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      // return response.body;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: ((context) => NavigatorMenu(userdata: userData)),
        ),
      );
    }
    //else {
    //   return null;
    // }
  }
}
