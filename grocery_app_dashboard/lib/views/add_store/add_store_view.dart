import 'package:flutter/material.dart';
import 'package:grocery_app_dashboard/models/category.dart';
import 'package:grocery_app_dashboard/services/database.dart';
import 'package:grocery_app_dashboard/shared/add_category_bottom_sheet.dart';

class AddStoreView extends StatefulWidget {
  @override
  _AddStoreViewState createState() => _AddStoreViewState();
}

class _AddStoreViewState extends State<AddStoreView> {
  final _formKey = GlobalKey<FormState>();

  String name;
  String location;
  int distanceFromUser;
  String category = 'Fruits and Vegetables';
  @override
  Widget build(BuildContext context) {
    void _showAddCategoryPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return AddCategoryBottomSheet();
          });
    }

    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add New Store'),
        ),
        body: Column(
          children: [
            TextFormField(
              validator: (val) =>
                  val.isEmpty ? 'Please enter store name' : null,
              onChanged: (val) {
                setState(() => name = val);
              },
              decoration: InputDecoration(hintText: 'Store Name'),
            ),
            SizedBox(
              height: 15.0,
            ),
            TextFormField(
              validator: (val) => val.isEmpty ? 'Please enter location' : null,
              onChanged: (val) {
                setState(() => location = val);
              },
              decoration: InputDecoration(hintText: 'Location'),
            ),
            SizedBox(
              height: 15.0,
            ),
            TextFormField(
              validator: (val) => (val.isEmpty ||
                      int.tryParse(val) <= 0 ||
                      int.tryParse(val) == null)
                  ? 'Please enter valid distance'
                  : null,
              onChanged: (val) {
                setState(() => distanceFromUser = int.tryParse(val));
              },
              decoration: InputDecoration(hintText: 'Distance from user'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    child: StreamBuilder<List<Category>>(
                      stream: DatabaseService().getCategoriesList(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Text('Loading');
                        } else {
                          List<DropdownMenuItem> categoryItems = [];
                          for (Category cat in snapshot.data) {
                            categoryItems.add(DropdownMenuItem(
                              child: Text('${cat.name}'),
                              value: cat.name,
                            ));
                          }
                          return DropdownButtonFormField(
                              items: categoryItems,
                              value: 'Fruits and Vegetables',
                              onChanged: (val) {
                                setState(() => category = val);
                              });
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                InkWell(
                  onTap: () {
                    _showAddCategoryPanel();
                  },
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    padding: EdgeInsets.all(15.0),
                    child: Center(
                      child: Text(
                        'New Category',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).primaryColor,
          child: InkWell(
            onTap: () {
              if (_formKey.currentState.validate()) {
                DatabaseService()
                    .addNewStore(name, location, distanceFromUser, category);
                Navigator.of(context).pop();
              }
            },
            child: Container(
              child: Center(
                  child: Text(
                'Add Store',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20.0),
              )),
              height: 60.0,
            ),
          ),
        ),
      ),
    );
  }
}
