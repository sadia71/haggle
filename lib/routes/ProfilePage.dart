
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
                  try{
                    await FirebaseAuth.instance.signOut();
                  }
                  catch(e){
                    print(e);
                  }
                  finally{
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                         const LoginPage()), (Route<dynamic> route) => false);
                    FlutterToast().warningToast('Log out', 'BOTTOM', 14.0, null);
                  }

                },
                icon: const Icon(Icons.logout)
            ),
          ],

        ),


      ),
      body:
      Container(
        child: Column(
          children: [
            Align(
              child: Container(
                decoration: BoxDecoration(color: Colors.blue[500],
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                    )
                ),
                height: 120,

                padding: const EdgeInsets.all(5.0),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 10,
                                offset: const Offset(0, 3)
                            )
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image:NetworkImage(userImage!),
                            fit: BoxFit.fill,
                          )
                      ),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                             Text(user!.displayName!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),maxLines: 1,),
                             Text(user.email!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white),maxLines: 1,),
                          ]
                      ),
                    ),
                  ],
                ),

              ),
              alignment: Alignment.center,
            ),
            const SizedBox(
              height: 25.0,
            ),

            Container(
              child: const Text('Hello'),
              decoration: const BoxDecoration(color: Colors.black12,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0))
              ),
              height: 120,
              width: MediaQuery.of(context).size.width,

              padding: const EdgeInsets.all(5.0),
              margin: const EdgeInsets.symmetric(horizontal: 10.0),

            ),
          ],
        ),
      ),
    );
  }
}
