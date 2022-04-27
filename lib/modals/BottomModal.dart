import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:haggle/firebase/BidsManagement.dart';

class BottomModal extends StatefulWidget {
  final int lowestBidPrice;
  final String postId;
  final String userId;
  final int userBidPrice;
  final String modalType;

  const BottomModal(this.lowestBidPrice, this.postId, this.userId,
      this.userBidPrice, this.modalType, {Key? key}) : super(key: key);

  @override
  _BottomModalState createState() => _BottomModalState();
}

class _BottomModalState extends State<BottomModal> {
  late String price = '0';
  @override
  Widget build(BuildContext context) {
    var lowestBidPrice = widget.lowestBidPrice.toString();
    var postId = widget.postId;
    var userId = widget.userId;
    var userBidPrice = widget.userBidPrice.toString();
    var modalType = widget.modalType;

    User? user = FirebaseAuth.instance.currentUser;
    return Container(
      height: 150,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        color: Colors.white,
      ),
      child: modalType == 'EDIT'
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                  Container(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.remove_circle,
                        color: Colors.blue[500],
                        size: 30,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Text('Min bid price : \$$lowestBidPrice'),
                  TextField(
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    onChanged: (text) {
                      if (text.isNotEmpty) {
                        setState(() {
                          price = text;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        disabledColor: Colors.grey,
                        icon: const Icon(
                          Icons.monetization_on,
                          size: 35,
                        ),
                        onPressed: int.parse(lowestBidPrice) <= int.parse(price)
                            ? () {
                                BidsManagement().makeBid(price, user, postId);
                                Navigator.pop(context);
                              }
                            : null,
                      ),
                      hintText: 'Make your bid',
                    ),
                  ),
                ])
          : modalType == 'UPDATE'
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                      Container(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(
                            Icons.remove_circle,
                            color: Colors.blue[500],
                            size: 30,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Min bid price : \$$lowestBidPrice'),
                          Text('You have bid : \$$userBidPrice'),
                        ],
                      ),
                      TextField(
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        onChanged: (text) {
                          if (text.isNotEmpty) {
                            setState(() {
                              price = text;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            disabledColor: Colors.grey,
                            icon: const Icon(
                              Icons.monetization_on,
                              size: 35,
                            ),
                            onPressed:
                                int.parse(userBidPrice) < int.parse(price)
                                    ? () {
                                        BidsManagement()
                                            .updateBid(price, userId, postId);
                                        Navigator.pop(context);
                                      }
                                    : null,
                          ),
                          hintText: '৳$userBidPrice',
                        ),
                      ),
                    ])
              : Container(),
    );
  }
}
