import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_app/models/product.dart';
import 'package:grocery_app/models/store.dart';
import 'package:grocery_app/models/user.dart';
import 'package:grocery_app/services/database.dart';
import 'package:grocery_app/views/my_account/bottom_sheet_to_update_profile.dart';
import 'package:provider/provider.dart';

class OrderSummary extends StatelessWidget {
  final Product product;
  final Store store;

  const OrderSummary({Key key, this.product, this.store}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    void _showUpdateAddress() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return BottomSheetToUpdateProfile();
          });
    }

    final user = Provider.of<CustomUserModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Summary',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          InkWell(
            onTap: () {
              _showUpdateAddress();
            },
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Address:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                  StreamBuilder<UserData>(
                      stream: DatabaseService(uid: user.uid).userData,
                      builder: (context, snapshot) {
                        return Text(
                          snapshot.hasData
                              ? '${snapshot.data.address}'
                              : 'Loading..',
                          style: TextStyle(fontSize: 16.0),
                        );
                      })
                ],
              ),
            ),
          ),
          Container(
            height: 1.0,
            color: Colors.grey[400],
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 1 / 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${product.name}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),
                          Text(
                            '₹ ${product.price}',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                    Image(
                      image: NetworkImage(''),
                      fit: BoxFit.fitWidth,
                      width: MediaQuery.of(context).size.width * 1 / 4,
                    )
                  ],
                ),
                Text(
                  'Your product will be delivered in 30 mins.',
                  style: TextStyle(fontSize: 16.0),
                )
              ],
            ),
          ),
          Container(
            height: 1.0,
            color: Colors.grey[400],
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
            child: Text(
              'Product Pricing:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Price:',
                      style: TextStyle(color: Colors.grey, fontSize: 15.0),
                    ),
                    Text(
                      '₹ ${product.price}',
                      style: TextStyle(fontSize: 16.0),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Discount:',
                      style: TextStyle(color: Colors.grey, fontSize: 15.0),
                    ),
                    Text(
                      '₹ 0',
                      style: TextStyle(fontSize: 16.0),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Delivery Charges:',
                      style: TextStyle(color: Colors.grey, fontSize: 15.0),
                    ),
                    Text(
                      '₹ 25',
                      style: TextStyle(fontSize: 16.0),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total:',
                      style: TextStyle(color: Colors.grey, fontSize: 15.0),
                    ),
                    Text(
                      '₹ ${product.price + 25}',
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
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () async {
            DatabaseService(uid: user.uid).orderItem(
                product.uid, product.name, product.price, product.image, store);
            Navigator.pop(context);
            Navigator.pop(context);
            Fluttertoast.showToast(
                msg: "Product ordered successfully.",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1);
          },
          child: Container(
            child: Center(
                child: Text(
              'Order Now',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20.0),
            )),
            height: 60.0,
          ),
        ),
      ),
    );
  }
}
