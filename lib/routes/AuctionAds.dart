import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:haggle/model/Products.dart';
import 'package:haggle/utilities/GesturedCard.dart';
import 'package:provider/provider.dart';
import 'ProfilePage.dart';
import 'package:lottie/lottie.dart';

class AuctionAds extends StatefulWidget {
  const AuctionAds({Key? key}) : super(key: key);

  @override
  _AuctionAdsState createState() => _AuctionAdsState();
}

class _AuctionAdsState extends State<AuctionAds> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    var userImage = user?.photoURL;

    List<Products> productList = Provider.of<List<Products>>(context);

    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  Center(
                      child: Container(
                          height: 40,
                          width: 40,
                          margin: const EdgeInsets.only(right: 10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3))
                              ]),
                          child: Lottie.asset(
                              'assets/auction_lottie_haggle-bd.json'))),
                  const Text('Haggle BD', textAlign: TextAlign.left),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                    return const ProfilePage();
                  }));
                  //Navigator.of(context).pushNamed('/profilePage');
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(userImage.toString()),
                  radius: 25,
                ),
              )
            ],
          ),
        ),
        body: productList.isNotEmpty
            ? GesturedCard(items: productList)
            : Center(
                child: CircularProgressIndicator(
                color: Colors.blue[500],
              )));
  }
}
