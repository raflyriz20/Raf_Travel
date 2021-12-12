import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_travel_ui/common/theme_color.dart';
import 'package:flutter_travel_ui/models/hotel_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class HotelScreen extends StatefulWidget {
  final Hotel hotel;
  HotelScreen({this.hotel});

  @override
  _HotelScreenState createState() => _HotelScreenState();
}

class _HotelScreenState extends State<HotelScreen> {
  User user = FirebaseAuth.instance.currentUser;
  String uid;

  showDialogWrong(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text("Oke"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Pesan Gagal !"),
      content: Text("Gagal Melakukan Booking !"),
      actions: [
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showDialogSuccess(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text("Oke"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Pesan Berhasil !"),
      content:
          Text("Berhasil Melakukan Booking, Silahkan Cek di Menu Booking !"),
      actions: [
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUidLog();
  }

  getUidLog() async {
    setState(() {
      uid = user.uid;
    });
  }

  Text _buildRatingStars(int rating) {
    String stars = '';
    for (int i = 0; i < rating; i++) {
      stars += '⭐';
    }
    stars.trim();
    return Text(stars);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 1,
                    ),
                  ],
                ),
                child: Hero(
                  tag: widget.hotel.imageUrl,
                  child: ClipRRect(
                    child: Image(
                      image: AssetImage(widget.hotel.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      iconSize: 30.0,
                      color: Colors.white,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    child: Text(
                      "${widget.hotel.name}",
                      style: blackTextStyle.copyWith(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    child: Text(
                      "Lokasi   : ${widget.hotel.address}",
                      style: blackTextStyle.copyWith(
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    child: Text(
                      "Harga   : ${NumberFormat.simpleCurrency(locale: 'id').format(widget.hotel.price)} / malam",
                      style: blackTextStyle.copyWith(
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          if (user != null) {
                            print("Pesan : Berhasil Booking Hotel");
                            FirebaseFirestore.instance
                                .collection('booking_hotels')
                                .add(({
                                  'uid': uid,
                                  'name': widget.hotel.name,
                                  'price': widget.hotel.price,
                                  'location': widget.hotel.address,
                                  'image': widget.hotel.imageUrl,
                                }));
                            showDialogSuccess(context);
                          } else {
                            print("Pesan : Gagal Melakukan Booking");
                            showDialogWrong(context);
                          }
                        },
                        icon: Icon(Icons.book, size: 18),
                        label: Text("Booking"),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
          /* Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 10, bottom: 15),
              itemCount: widget.destination.activities.length,
              itemBuilder: (BuildContext context, int index) {
                Activity activity = widget.destination.activities[index];
                return Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(40, 5.0, 20.0, 5.0),
                      height: 200.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.cyan,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(100.0, 20.0, 20.0, 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: 120.0,
                                  child: Text(
                                    activity.name,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        NumberFormat.simpleCurrency(
                                                locale: 'id')
                                            .format(activity.price),
                                        style: TextStyle(
                                          fontSize: 11.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.yellowAccent,
                                        ),
                                      ),
                                      Text(
                                        'per orang',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              activity.type,
                              style: TextStyle(
                                color: Colors.white70,
                              ),
                            ),
                            _buildRatingStars(activity.rating),
                            SizedBox(height: 10.0),
                            Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(5.0),
                                  width: 70.0,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).accentColor,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    activity.startTimes[0],
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Container(
                                  padding: EdgeInsets.all(5.0),
                                  width: 70.0,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).accentColor,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    activity.startTimes[1],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 14.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    if (user != null) {
                                      print("Pesan : Berhasil Register");
                                      FirebaseFirestore.instance
                                          .collection('bookings')
                                          .add(({
                                            'uid': uid,
                                            'name': activity.name,
                                            'price': activity.price,
                                            'rating': activity.rating,
                                            'start': activity.startTimes[0],
                                            'end': activity.startTimes[1],
                                            'type': activity.type,
                                            'image': activity.imageUrl,
                                          }));
                                      showDialogSuccess(context);
                                    } else {
                                      print("Pesan : Gagal Melakukan Booking");
                                      showDialogWrong(context);
                                    }
                                  },
                                  icon: Icon(Icons.book, size: 18),
                                  label: Text("Booking"),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20.0,
                      top: 15.0,
                      bottom: 15.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image(
                          width: 110.0,
                          image: AssetImage(
                            activity.imageUrl,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ), */
        ],
      ),
    );
  }
}
