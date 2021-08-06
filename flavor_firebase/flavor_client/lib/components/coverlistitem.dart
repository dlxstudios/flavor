import 'package:flutter/material.dart';

class CoverListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6),
      child: ClipRRect(
          borderRadius: new BorderRadius.circular(20.0),
          child: Container(
              height: 200,
              width: 200,
              color: Colors.redAccent,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Image.network(
                    "https://static.vinepair.com/wp-content/uploads/2017/03/darts-int.jpg",
                    fit: BoxFit.cover,
                    height: 200,
                    // width: 200,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      height: 68,
                      color: Colors.black.withOpacity(.3),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Title',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.6),
                          ),
                          Text(
                            'Subtitle',
                            style: TextStyle(
                                color: Colors.white.withOpacity(.7),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1.6),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ))),
    );
  }
}
