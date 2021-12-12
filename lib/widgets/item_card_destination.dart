import 'package:flutter/material.dart';
import 'package:flutter_travel_ui/common/theme_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ItemCardDestination extends StatelessWidget {
  final String uid;
  final String name;
  final int price;
  final int rating;
  final String start;
  final String end;
  final String type;
  final String images;
  //// Pointer to Delete Function
  final Function onDelete;

  ItemCardDestination(this.name, this.uid, this.price, this.rating, this.start,
      this.end, this.type, this.images,
      {this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.blue[900])),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            "${images}",
            height: 50.0,
            width: 100,
            fit: BoxFit.cover,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${name}',
                style: blackTextStyle,
              ),
              Text(
                '${NumberFormat.simpleCurrency(locale: 'id').format(price)}',
                style: blackTextStyle,
              )
            ],
          ),
          Row(
            children: [
              SizedBox(
                height: 40,
                width: 60,
                child: RaisedButton(
                    shape: CircleBorder(),
                    color: Colors.red[900],
                    child: Center(
                        child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    )),
                    onPressed: () {
                      if (onDelete != null) onDelete();
                    }),
              )
            ],
          )
        ],
      ),
    );
  }
}
