//User Model
// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  static const String UID = "uid";
  static const String TITLE = "title";
  static const String SUBTITLE = "subtitle";
  static const String FEATURED = "featured";
  static const String AMOUNT = "amount";
  static const String IMAGE = "image";
  static const String CATEGORY = "category";
  static const String IS_ENDED = "isEnded";
  static const String IS_CANCELLED = "isCancelled";
  static const String HELD_DATE = "heldDate";
  static const String PEOPLE_WAITING = "peopleWaiting";
  static const String PEOPLE_BETTING = "peopleBetting";

  final String uid;
  final String title;
  final String subtitle;
  final String image;
  final String category;
  final num amount;
  final Timestamp heldDate;
  final List peopleBetting;
  final List peopleWaiting;
  final bool featured;
  final bool isEnded;
  final bool isCancelled;

  EventModel({
    required this.uid,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.image,
    required this.featured,
    required this.isEnded,
    required this.isCancelled,
    required this.heldDate,
    required this.category,
    required this.peopleWaiting,
    required this.peopleBetting,
  });

  factory EventModel.fromMap(Map data) {
    return EventModel(
      uid: data[UID],
      title: data[TITLE],
      subtitle: data[SUBTITLE],
      amount: data[AMOUNT],
      image: data[IMAGE],
      featured: data[FEATURED],
      isEnded: data[IS_ENDED],
      isCancelled: data[IS_CANCELLED],
      category: data[CATEGORY],
      heldDate: data[HELD_DATE],
      peopleBetting: data[PEOPLE_BETTING],
      peopleWaiting: data[PEOPLE_WAITING],
    );
  }

  Map<String, dynamic> toJson() => {
        UID: uid,
        TITLE: title,
        IMAGE: image,
        SUBTITLE: subtitle,
        IS_ENDED: isEnded,
        IS_CANCELLED: isCancelled,
        CATEGORY: category,
        AMOUNT: amount,
        FEATURED: featured,
        PEOPLE_WAITING: peopleWaiting,
        PEOPLE_BETTING: peopleBetting,
        HELD_DATE: heldDate,
      };
}
