import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_travel_ui/common/theme_color.dart';
import 'package:flutter_travel_ui/widgets/item_card_destination.dart';
import 'package:flutter_travel_ui/widgets/item_card_hotel.dart';
import 'package:flutter_travel_ui/widgets/header_widget.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  User user = FirebaseAuth.instance.currentUser;
  String uid;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUidLog();
  }

  getUidLog() async {
    DocumentSnapshot getUserLog = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    setState(() {
      uid = user.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore fFireStore = FirebaseFirestore.instance;
    CollectionReference crDestination =
        fFireStore.collection('booking_destinations');
    CollectionReference crHotel = fFireStore.collection('booking_hotels');
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                height: 100,
                child: HeaderWidget(100, false, Icons.house_rounded),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 0.0, bottom: 20.0),
                  child: Text(
                    "List Booking",
                    style: blackTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              StreamBuilder<QuerySnapshot<Map<dynamic, dynamic>>>(
                stream: crDestination.snapshots(),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: snapshot.data.docs
                          .map((e) => e.data()['uid'] != uid
                              ? SizedBox(height: 0)
                              : ItemCardDestination(
                                  e.data()['name'],
                                  e.data()['uid'],
                                  e.data()['price'],
                                  e.data()['rating'],
                                  e.data()['start'],
                                  e.data()['end'],
                                  e.data()['type'],
                                  e.data()['image'],
                                  onDelete: () {
                                    Widget cancelButton = TextButton(
                                      child: Text("Tidak"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    );
                                    Widget continueButton = TextButton(
                                      child: Text("Ya"),
                                      onPressed: () {
                                        crDestination.doc(e.id).delete();
                                      },
                                    );

                                    AlertDialog alert = AlertDialog(
                                      title: Text("Konfirmasi"),
                                      content: Text(
                                          "Anda yakin ingin menghapus list booking ?"),
                                      actions: [
                                        cancelButton,
                                        continueButton,
                                      ],
                                    );

                                    // show the dialog
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return alert;
                                      },
                                    );
                                  },
                                ))
                          .toList(),
                    );
                  } else {
                    return Text("Load Data...");
                  }
                },
              ),
              StreamBuilder<QuerySnapshot<Map<dynamic, dynamic>>>(
                stream: crHotel.snapshots(),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: snapshot.data.docs
                          .map((e) => e.data()['uid'] != uid
                              ? SizedBox(height: 0)
                              : ItemCardHotel(
                                  e.data()['name'],
                                  e.data()['uid'],
                                  e.data()['price'],
                                  e.data()['location'],
                                  e.data()['image'],
                                  onDelete: () {
                                    Widget cancelButton = TextButton(
                                      child: Text("Tidak"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    );
                                    Widget continueButton = TextButton(
                                      child: Text("Ya"),
                                      onPressed: () {
                                        crHotel.doc(e.id).delete();
                                      },
                                    );

                                    AlertDialog alert = AlertDialog(
                                      title: Text("Konfirmasi"),
                                      content: Text(
                                          "Anda yakin ingin menghapus list booking ?"),
                                      actions: [
                                        cancelButton,
                                        continueButton,
                                      ],
                                    );

                                    // show the dialog
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return alert;
                                      },
                                    );
                                  },
                                ))
                          .toList(),
                    );
                  } else {
                    return Text("Load Data...");
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
