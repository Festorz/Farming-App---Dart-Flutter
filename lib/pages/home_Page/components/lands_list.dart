import 'package:flutter/material.dart';
import 'package:mkulima/data/data.dart';

class LandList extends StatelessWidget {
  const LandList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return SizedBox(
        height: 160,
        width: double.maxFinite,
        child: ListView.builder(
            itemCount: images.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, index) {
              return Container(
                margin: const EdgeInsets.only(right: 15, top: 10, bottom: 10),
                width: w * 0.85,
                height: 140,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(color: Colors.black38, blurRadius: 5)
                    ],
                    image: DecorationImage(
                      image: AssetImage(images.values.elementAt(index)),
                      // image: NetworkImage("url"),
                      fit: BoxFit.cover,
                    )),
              );
            }));
  }
}
