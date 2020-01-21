import 'package:flutter/material.dart';
import 'package:weather_app/models/temperature.dart';

class TempItem extends StatelessWidget {
  final Temperature temp;
  final Function _dismiss;

  TempItem(this.temp, this._dismiss);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 9;
    double width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Item Dismissed!",
              textAlign: TextAlign.center,
            ),
          ),
        );
        _dismiss();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: <Widget>[
            Container(
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 8.0),
                ],
              ),
            ),
            Container(
              height: height,
              padding: EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10.0),
                    width: width * 0.6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "${this.temp.city},${this.temp.country}",
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 26,
                            color: Colors.white,
                            letterSpacing: 0.01,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          "Min temp:    ${this.temp.minTemp.toString()}˚",
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 12,
                            color: Colors.white70,
                            letterSpacing: 0.01,
                          ),
                        ),
                        Text(
                          "Max temp:   ${this.temp.maxTemp.toString()}˚",
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 12,
                            color: Colors.white70,
                            letterSpacing: 0.01,
                          ),
                        ),
                        Text(
                          "Description: ${this.temp.description}",
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 12,
                            color: Colors.white70,
                            letterSpacing: 0.01,
                          ),
                        ),
                      ],
                    ),
                  ),
                  VerticalDivider(thickness: 1.0, color: Colors.white70),                 
                  Container(
                    width : width * 0.28,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "${this.temp.temp}˚",
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 36,
                            color: Colors.white,
                            letterSpacing: 0.01,
                          ),
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
