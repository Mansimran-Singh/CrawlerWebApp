import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardView extends StatelessWidget {
  const CardView(this._releaseData, this._title, this._url, this._posterUrl,
      {Key? key})
      : super(key: key);

  final String _releaseData;
  final String _title;
  final String _url;
  final String _posterUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20.0),
      color: Colors.white38,
      elevation: 5,
      child: CachedNetworkImage(
        imageUrl: _posterUrl,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
          ),
          child: 
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(40)),
                ),
                color: Colors.white70.withOpacity(0.5),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    _releaseData,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                ),
                color: Colors.black87.withAlpha(20),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          _title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          _url,
                          style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                              fontSize: 10),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        placeholder: (context, url) => const Center(
          child: SizedBox(
                  child: CircularProgressIndicator(),
                  height: 10.0,
                  width: 10.0,
                ),
        ),
        errorWidget: (context, url, error) => Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(40)),
              ),
              color: Colors.white70.withOpacity(0.5),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  _releaseData,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
              ),
              color: Colors.black87.withAlpha(20),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        _url,
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                            fontSize: 10),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
