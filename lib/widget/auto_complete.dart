import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';

class AutoComplete extends StatelessWidget {
  final Function submit;
  final List<String> locations;

  AutoComplete({@required this.locations, @required this.submit});

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      SizedBox(width: 20.0),
      Expanded(
        child: AutoCompleteTextField<String>(
          key: key,
          suggestions: locations,
          style: new TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: "Search by City, Country",
            hintStyle: TextStyle(color: Colors.white),
          ),
          itemFilter: (item, query) {
            return item.toLowerCase().startsWith(query.toLowerCase());
          },
          itemSorter: (a, b) {
            return a.compareTo(b);
          },
          itemSubmitted: (item) {
            this.submit(item);
          },
          itemBuilder: (context, item) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 40.0,
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: Text(
                    item,
                    style: TextStyle(fontSize: 18.0),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            );
          },
        ),
      ),
      SizedBox(width: 20.0),
    ]);
  }
}
