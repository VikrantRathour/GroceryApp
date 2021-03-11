import 'package:flutter/material.dart';
import 'package:grocery_app/models/user.dart';
import 'package:grocery_app/services/auth.dart';
import 'package:grocery_app/services/database.dart';
import 'package:grocery_app/views/my_account/bottom_sheet_to_update_profile.dart';
import 'package:grocery_app/views/orders/orders_view.dart';
import 'package:provider/provider.dart';

class MyAccountView extends StatefulWidget {
  @override
  _MyAccountViewState createState() => _MyAccountViewState();
}

class _MyAccountViewState extends State<MyAccountView> {
  void _showUpdateAddress() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheetToUpdateProfile();
        });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUserModel>(context);
    return Scaffold(
      body: StreamBuilder<UserData>(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            return ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(75.0))),
                  padding: EdgeInsets.only(top: 50.0, left: 30.0, right: 30.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100.0),
                            child: Image(
                              image: AssetImage('assets/avatar.png'),
                              height: 80.0,
                              width: 80.0,
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                              ),
                              Text(
                                snapshot.hasData
                                    ? snapshot.data.name
                                    : 'Your Name',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18.0),
                              ),
                              InkWell(
                                onTap: () {
                                  _showUpdateAddress();
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      top: 3.0,
                                      bottom: 3.0,
                                      left: 8.0,
                                      right: 8.0),
                                  decoration: BoxDecoration(
                                      color: Color(0x66FFFFFFF),
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: Text(
                                    snapshot.hasData
                                        ? snapshot.data.address
                                        : 'No Address',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.star_border_rounded,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                                Text(
                                  'Starred',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.settings_outlined,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                                Text(
                                  'Settings',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.payment_outlined,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                                Text(
                                  'Payments',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.0,
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(75.0))),
                  padding: EdgeInsets.only(top: 40.0, left: 10.0, right: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'ORDERS',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      ),
                      InkWell(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => OrdersView())),
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Icon(Icons.agriculture_outlined),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                'Your Orders',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17.0),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Icon(Icons.favorite_outline_rounded),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              'Favorite Orders',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 17.0),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Icon(Icons.book_outlined),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              'Address Book',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 17.0),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Icon(Icons.help_center_outlined),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              'Online Ordering Help',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 17.0),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Icon(Icons.query_builder_outlined),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              'About Us',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 17.0),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Text(
                          'Send Feedback',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 16.0),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Text(
                          'Rate us on Play Store',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 16.0),
                        ),
                      ),
                      InkWell(
                        child: Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Text(
                            'Sign Out',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 16.0),
                          ),
                        ),
                        onTap: () async {
                          await AuthService().signOut();
                        },
                      ),
                    ],
                  ),
                )
              ],
            );
          }),
    );
  }
}
