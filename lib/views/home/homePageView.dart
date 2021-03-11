import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:grocery_app/models/location.dart';
import 'package:grocery_app/models/store.dart';
import 'package:grocery_app/models/user.dart';
import 'package:grocery_app/services/auth.dart';
import 'package:grocery_app/services/database.dart';
import 'package:grocery_app/views/after_search/store_detail_after_search.dart';
import 'package:grocery_app/views/cart/cart_view.dart';
import 'package:grocery_app/views/categories/categories_list_view.dart';
import 'package:grocery_app/views/home/cateories_list/categories_list.dart';
import 'package:grocery_app/views/home/stores_list/stores_list.dart';
import 'package:grocery_app/views/my_account/my_account_view.dart';
import 'package:grocery_app/views/orders/orders_view.dart';
import 'package:provider/provider.dart';

class HomePageView extends StatefulWidget {
  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String currentLocation = 'Sector 94';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUserModel>(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        shadowColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
        title: StreamBuilder<List<Location>>(
          stream: DatabaseService().getLocations(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text('Loading...');
            } else {
              List<DropdownMenuItem> items = [];
              for (Location loc in snapshot.data) {
                items.add(DropdownMenuItem(
                  child: Container(
                      child: Text(
                    loc.location,
                  )),
                  value: loc.location,
                ));
              }
              return DropdownButtonFormField(
                items: items,
                value: currentLocation,
                dropdownColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(border: InputBorder.none),
                style: TextStyle(color: Colors.white),
                onChanged: (val) {
                  setState(() {
                    currentLocation = val;
                  });
                },
              );
            }
          },
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => CartView()));
            },
            child: Padding(
              padding: EdgeInsets.only(left: 25.0, right: 15.0),
              child: Icon(
                Icons.shopping_basket,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Center(
                child: Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                        child: Image(
                          image: AssetImage('assets/avatar.png'),
                          fit: BoxFit.cover,
                          height: 80.0,
                        )),
                    SizedBox(
                      width: 20.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Vender\'s Next Door',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          child: user != null
                              ? FutureBuilder<String>(
                                  future: DatabaseService(uid: user.uid)
                                      .getUserName(),
                                  builder: (context, snapshot) {
                                    return Text(
                                      'Hi, ${snapshot.data}',
                                      style: TextStyle(color: Colors.white),
                                    );
                                  })
                              : Text(
                                  'Hi',
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(color: Theme.of(context).accentColor),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('My Account'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MyAccountView()));
              },
            ),
            ListTile(
              title: Text('My Orders'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => OrdersView()));
              },
            ),
            ListTile(
              title: Text('My Cart'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => CartView()));
              },
            ),
            ListTile(
              title: Text('All Categories'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CategoriesListView(
                          currentLocation: currentLocation,
                        )));
              },
            ),
            ListTile(
              title: Text('Sign Out'),
              onTap: () {
                AuthService().signOut();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                TypeAheadField<Store>(
                    textFieldConfiguration: TextFieldConfiguration(
                        // autofocus: true,
                        // style: DefaultTextStyle.of(context)
                        //     .style
                        //     .copyWith(fontStyle: FontStyle.italic),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Search By Store'),
                        textCapitalization: TextCapitalization.words),
                    suggestionsCallback: (pattern) async {
                      return DatabaseService()
                          .getStoreWithCategorySearched(pattern);
                    },
                    itemBuilder: (context, suggession) {
                      return ListTile(
                        leading: Icon(Icons.shopping_cart),
                        title: Text(suggession.name),
                        subtitle: Text('${suggession.category}'),
                      );
                    },
                    onSuggestionSelected: (sugession) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => StoreDetailAfterSearch(
                                  store: sugession,
                                )),
                      );
                    }),
                Text(
                  'Categories',
                  style: TextStyle(fontSize: 25.0),
                ),
                Container(
                    height: 200.0,
                    child: CategoriesList(
                      currentLocation: currentLocation,
                    )),
                Text(
                  'Nearby Stores:',
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
                Container(
                    // height: 237.0,
                    child: StoresList(
                  currentLocation: currentLocation,
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
