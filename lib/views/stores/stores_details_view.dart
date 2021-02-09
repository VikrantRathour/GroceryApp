import 'package:flutter/material.dart';
import 'package:grocery_app/models/store.dart';
import 'package:grocery_app/views/stores/products_list/products_list.dart';

class StoreDetailView extends StatefulWidget {
  final Store store;

  const StoreDetailView({this.store});
  @override
  _StoreDetailViewState createState() => _StoreDetailViewState();
}

class _StoreDetailViewState extends State<StoreDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          Image(
            image: NetworkImage('${widget.store.image}'),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1 / 3,
          ),
          Container(
            padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                    ),
                    Text(
                      widget.store.name,
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Location: ${widget.store.location}',
                    style: TextStyle(fontSize: 15.0, color: Colors.grey),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.star_rounded,
                            color: Color(0xFFFFD11A),
                            size: 25.0,
                          ),
                          Text(
                            '4.9',
                            style: TextStyle(
                                color: Color(0xFFFFD11A), fontSize: 25.0),
                          )
                        ],
                      ),
                      Text(
                        '250 reviews',
                        style: TextStyle(color: Colors.grey, fontSize: 12.0),
                      )
                    ],
                  )
                ]),
          ),
          SizedBox(
            height: 25.0,
          ),
          Container(
            padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Phone:',
                      style: TextStyle(color: Colors.grey, fontSize: 15.0),
                    ),
                    Text(
                      '(+91) 987 654 3210',
                      style: TextStyle(fontSize: 16.0),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Text(
                  'Products available:',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                ProductsList(
                  store: widget.store,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
