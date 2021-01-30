import 'package:flutter/material.dart';
import 'package:grocery_app_dashboard/views/add_store/add_store_view.dart';
import 'package:grocery_app_dashboard/views/home/stores_list/stores_list.dart';

class HomePageView extends StatefulWidget {
  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grocery App Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Text(
              'Your Stores:',
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddStoreView())),
              // onTap: () => Navigator.of(context).push(
              //     MaterialPageRoute(builder: (context) => AddStoreView())),
              child: Container(
                padding: EdgeInsets.all(10.0),
                color: Theme.of(context).primaryColor,
                child: Text(
                  'Add New Store',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            StoresList(),
          ],
        ),
      ),
    );
  }
}
