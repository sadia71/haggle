import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:haggle/utilities/FlutterToast.dart';
import 'LoginPage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    var userImage = user?.photoURL;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('PROFILE'),
            IconButton(
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signOut();
                  } catch (e) {
                    print(e);
                  } finally {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                        (Route<dynamic> route) => false);
                    FlutterToast()
                        .warningToast('Log out', 'BOTTOM', 14.0, null);
                  }
                },
                icon: const Icon(Icons.logout)),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.blue[500],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                )),
            height: 120,
            padding: const EdgeInsets.all(5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: const Offset(0, 3))
                      ],
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(userImage!),
                        fit: BoxFit.fill,
                      )),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.person,
                          size: 20,
                          color: Colors.white,
                        ),
                        Text(
                          "  " + user!.displayName!,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          maxLines: 1,
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.call,
                          size: 20,
                          color: Colors.white,
                        ),
                        Text("  " + "+8801715002544",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.white),
                            maxLines: 1,
                            textAlign: TextAlign.left),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.email,
                          size: 20,
                          color: Colors.white,
                        ),
                        Text("  " + user.email!,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.white),
                            maxLines: 1,
                            textAlign: TextAlign.left),
                      ],
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.person_pin_circle,
                          size: 20,
                          color: Colors.white,
                        ),
                        Text("  " + "Mirpur, Dhaka",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.white),
                            maxLines: 1,
                            textAlign: TextAlign.left),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 25.0,
          ),
          Container(
            child: Column(
              children: [
                Row(
                  children: const [
                    Icon(Icons.align_vertical_bottom, color: Colors.blue,),
                    Text('Dashboard', style: TextStyle(fontSize: 20),),
                  ],
                ),
                 Divider(
                  height: 10,
                  thickness: 1,
                  indent: 0,
                  endIndent: 0,
                  color: Colors.blue.withOpacity(0.3),
                ),

              ],
            ),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 3))
                ],
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(5.0))),
            height: 120,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(5.0),
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
          ),
        ],
      ),
    );
  }
}
