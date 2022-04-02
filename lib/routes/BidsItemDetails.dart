import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:haggle/firebase/UserManagement.dart';

import 'package:haggle/utilities/BidsDataTable.dart';
import 'package:haggle/utilities/AuctionTime.dart';
import 'package:haggle/modals/BottomModal.dart';
import 'package:haggle/utilities/Carousel.dart';


class BidsItemDetails extends StatefulWidget {
  final itemDetails;
  const BidsItemDetails({Key? key, @required this.itemDetails}) : super(key: key);

  @override
  _BidsItemDetailsState createState() => _BidsItemDetailsState();
}

class _BidsItemDetailsState extends State<BidsItemDetails> {

  var hasBid;

  @override
  Widget build(BuildContext context) {
    var details = widget.itemDetails;


    User? user = FirebaseAuth.instance.currentUser;


    return Scaffold(
      appBar: AppBar(
        title: const Text('DETAILS'),
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance.collection('items').doc(details['itemId']).snapshots(includeMetadataChanges: true),
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot){

              if (snapshot.hasData){

                var item = snapshot.data!.data();
                var bidUsers = item!['bidUsers'];

                var hasBidUser = bidUsers.contains(user!.uid) ? true : false;

                var timeInMilliSeconds = (item['lastBidTime'].seconds * 1000);


                return  ListView(
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:[
                          const SizedBox(height: 5,),
                          Carousel().imageCarousel(item['itemImages'], 220.0),
                          Container(
                            child: AuctionTime().getCountDown(item['lastBidTime'], item['itemId'], item['isCompleted']),
                          ),

                          Container(
                              margin: const EdgeInsets.symmetric( horizontal: 10.0, vertical: 5.0),
                              child: Column(
                                children: [

                                  Container(
                                      alignment: Alignment.topLeft,
                                      child : Text(item['itemName'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),textAlign: TextAlign.start,)

                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(vertical: 5),
                                    alignment: Alignment.topLeft,
                                    child: Text(item['itemDesc'], style: const TextStyle(fontSize: 16),),
                                  ),
                                  Container(
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Chip(
                                            label: Text('\$${item['minBidPrice']}(Min)', style: const TextStyle(fontSize: 16, color: Colors.white),),
                                            backgroundColor: Colors.blue[500],
                                            shadowColor: Colors.black12,
                                          ),
                                          Chip(
                                            avatar: const Icon(Icons.date_range, size: 16, color: Colors.white,),
                                            label: Text(AuctionTime().getTime(item['lastBidTime']), style: const TextStyle(fontSize: 16, color: Colors.white),),
                                            backgroundColor: Colors.blue[500],
                                            shadowColor: Colors.black12,
                                          ),
                                        ],
                                      )
                                  ),

                                  const SizedBox(height: 30,),
                                  CountdownTimer(
                                    endTime: timeInMilliSeconds,

                                    widgetBuilder: (BuildContext context, CurrentRemainingTime? time) {

                                      if (time == null) {
                                        return StreamBuilder(
                                          stream: FirebaseFirestore.instance.collection('items')
                                              .doc(item['itemId']).collection('bid-users').orderBy('bidPrice', descending: true).limit(1).snapshots(),
                                          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                                            if(snapshot.hasData && snapshot.data!.docs.isNotEmpty){

                                              var winnerInfo = snapshot.data!.docs[0];

                                              return  Container(
                                                  width: MediaQuery.of(context).size.width,
                                                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                                  decoration: BoxDecoration(
                                                    color: Colors.blue[500],
                                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(30), bottomLeft: Radius.circular(30)),


                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                          alignment: Alignment.center,
                                                          padding: const EdgeInsets.only(bottom: 10.0),
                                                          child : const Text('WINNER! WINNER!', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white),)),
                                                      Container(
                                                        alignment: Alignment.center,
                                                        child: UserManagement().getPostedUser(winnerInfo['userId'], 'MODERATE_NAME', 45.0, 25.0, true, true, false )

                                                      ),


                                                      Container(
                                                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(width: 5, color: Colors.white),
                                                            borderRadius: const BorderRadius.only(topRight: Radius.circular(20), bottomLeft: Radius.circular(20))
                                                        ),
                                                        child: Container(
                                                            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                                            child: Text('\$${winnerInfo['bidPrice']}',
                                                              style: const TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white),)),
                                                      ),
                                                    ],
                                                  )
                                              );
                                            } else {
                                              return const Center(
                                              child: Text('No one makes a bid'),
                                            );
                                            }
                                          },
                                        );

                                      }
                                      else {
                                        return Column(

                                              children: [
                                                hasBidUser || item['userId'] == user.uid ? Container() : FloatingActionButton.extended(
                                                  onPressed: () {
                                                    showModalBottomSheet<void>(
                                                        context: context,
                                                        isScrollControlled: true,
                                                        enableDrag: true,
                                                        useRootNavigator: true,

                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(20.0),
                                                        ),
                                                        backgroundColor: Colors.white,
                                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                                        builder: (BuildContext context) {
                                                          return SingleChildScrollView(
                                                            child: Container(
                                                              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                              child: BottomModal(item['minBidPrice'], item['itemId'], '', 0, 'EDIT'),

                                                            ),
                                                          );
                                                        });
                                                  },
                                                  icon: const Icon( Icons.attach_money),
                                                  backgroundColor: Colors.blue[500], label: const Text('MAKE A BID'),
                                                ),
                                                const SizedBox(height: 30,),
                                                StreamBuilder(
                                                  stream: FirebaseFirestore.instance.collection('items')
                                                      .doc(item['itemId']).collection('bid-users').orderBy(
                                                      'bidPrice', descending: true).snapshots(),
                                                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                                    if (snapshot.hasData) {
                                                      return BidsDataTable().table(
                                                          snapshot.data!.docs, context, item['minBidPrice'],
                                                          item['itemId'], user.uid);
                                                    } else {
                                                      return Center(
                                                        child: CircularProgressIndicator(color: Colors.blue[500],),
                                                      );
                                                    }
                                                  },
                                                )
                                              ]);
                                      }
                                    },

                                  ),
                                ],
                              )
                          ),

                        ]
                    ),
                  ],
                );
              }

              else {
                return Center(child: CircularProgressIndicator(color: Colors.blue[500]));
              }
            },
          )
    );
  }
}
