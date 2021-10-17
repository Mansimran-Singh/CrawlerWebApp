import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardView extends StatelessWidget {
  const CardView(this._releaseData, this._title, this._url, {Key? key})
      : super(key: key);

  final String _releaseData;
  final String _title;
  final String _url;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20.0),
      color: Colors.white38,
      elevation: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topRight: Radius.circular(40),bottomRight: Radius.circular(40)),
            ),
            color: Colors.white70,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                _releaseData,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 22.0,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontSize: 22),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    _url,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
