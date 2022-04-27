
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Products extends Equatable{
  final String itemId;
  final String userId;
  final String itemDesc;
  final String itemName;
  final bool isCompleted;
  final Timestamp bidAt;
  final Timestamp lastBidTime;
  final List itemImages;
  final List bidUsers;
  final int minBidPrice;

  const Products({
    required this.itemId,
    required this.userId,
    required this.itemDesc,
    required this.isCompleted,
    required this.bidAt,
    required this.lastBidTime,
    required this.itemImages,
    required this.bidUsers,
    required this.itemName,
    required this.minBidPrice,

});

  static Products fromSnapshot(DocumentSnapshot product){
    return Products(
      itemId: product['itemId'],
      userId: product['userId'],
      itemDesc: product['itemDesc'],
      isCompleted: product['isCompleted'],
        bidAt: product['bidAt'],
      lastBidTime: product['lastBidTime'],
        itemImages: product['itemImages'],
      bidUsers: product['bidUsers'],
        itemName: product['itemName'],
      minBidPrice: product['minBidPrice'],
    );
  }
  @override
  List<Object?> get props => [
    itemId,userId, itemDesc, isCompleted, bidAt, lastBidTime, itemImages,bidUsers, itemName, minBidPrice
  ];

}