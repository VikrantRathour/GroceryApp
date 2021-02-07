import 'package:flutter/material.dart';
import 'package:grocery_app/models/store.dart';
import 'package:grocery_app/views/after_search/products_list_of_store_after_search/products_list_of_store_after_search.dart';

class StoreDetailAfterSearch extends StatefulWidget {
  final Store store;

  const StoreDetailAfterSearch({this.store});
  @override
  _StoreDetailAfterSearchState createState() => _StoreDetailAfterSearchState();
}

class _StoreDetailAfterSearchState extends State<StoreDetailAfterSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          Image(
            image: AssetImage('assets/${widget.store.image}'),
            width: MediaQuery.of(context).size.width,
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Location: ${widget.store.location}',
                        style: TextStyle(fontSize: 15.0, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Text(
                        'Distance from user: ${widget.store.distanceFromUser}',
                        style: TextStyle(fontSize: 16.0, color: Colors.grey),
                      )
                    ],
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
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProductsListOfStoreAfterSearch(
                        store: widget.store,
                      )));
            },
            child: Container(
              padding: EdgeInsets.all(10.0),
              color: Theme.of(context).primaryColor,
              child: Text(
                'See Products available',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
