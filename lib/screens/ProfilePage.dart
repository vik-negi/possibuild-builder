import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // FirebaseAuth auth = FirebaseAuth.instance;

  //     signOut() async {
  //       await auth.signOut().then((value) => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const SignIn()), (route) => false));
  //       setState(() { });
  //       return const SignIn();
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          // padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Column(
            children: [
              Container(
                height: 210,
                child: Stack(
                  children: [
                    Container(
                      height: 150,
                      color: Colors.purple,
                    ),
                    const Positioned(
                      top: 100,
                      left: 25,
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQI5AIyuub1fFa92zVOo09Tlsr5vguctsBAjg&usqp=CAU"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: Column(
                    children: [
                      const UserOptions(
                        icon: Icons.verified_user,
                        title: 'Credit Details',
                      ),
                      const UserOptions(
                        icon: Icons.verified_user,
                        title: 'Account Setting',
                      ),
                      const UserOptions(
                        icon: Icons.location_history,
                        title: 'Invite Your Friends',
                      ),
                      const UserOptions(
                        icon: Icons.message,
                        title: 'Support',
                      ),
                      const UserOptions(
                        icon: Icons.info,
                        title: 'About Us',
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                          ),
                          onPressed: () {
                            // AuthenticationService.signOut();
                            // signOut();
                          },
                          child: const ListTile(
                            leading: Icon(
                              Icons.logout,
                              color: Color.fromRGBO(255, 99, 99, 1),
                            ),
                            title: Text("Logout",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromRGBO(255, 99, 99, 1),
                                    fontWeight: FontWeight.w500)),
                            trailing: Icon(Icons.arrow_right_sharp,
                                color: Colors.redAccent, size: 30),
                          ),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserOptions extends StatelessWidget {
  const UserOptions({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: ListTile(
        leading: Icon(
          icon,
          size: 30,
          // color: Colors.white,
        ),
        title: Text(title,
            style: const TextStyle(
                fontSize: 18,
                // color: Colors.white,
                fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.arrow_right_sharp,
            // color: Colors.white,
            size: 30),
      ),
    );
  }
}

class UpgradeSection extends StatelessWidget {
  const UpgradeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(
              CupertinoIcons.up_arrow,
              size: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Upgrade your Account!",
                      style: TextStyle(
                          fontSize: 18,
                          // color: Colors.white,
                          fontWeight: FontWeight.w600)),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Get Unlimited Premium Account For More Discount.",
                      style: TextStyle(
                          fontSize: 11,
                          // color: Colors.white,
                          fontWeight: FontWeight.w300)),
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        ElevatedButton(
          onPressed: () async {
            // await Navigator.of(context).pushNamed(MyRoutes.exploreRoute);
          },
          style: ElevatedButton.styleFrom(
            textStyle:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            primary: const Color.fromARGB(255, 234, 171, 0),
            // padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 80),
            minimumSize: const Size(300, 50),
          ),
          child: const Text("Upgrade Now"),
        ),
      ],
    );
  }
}
