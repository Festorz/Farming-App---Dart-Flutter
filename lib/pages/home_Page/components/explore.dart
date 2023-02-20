import 'package:flutter/material.dart';
import 'package:mkulima/data/data.dart';
import 'package:mkulima/widgets/apptext.dart';
import 'package:mkulima/widgets/headertext.dart';

class Explore extends StatelessWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.maxFinite,
        height: 70,
        child: ListView.builder(
            itemCount: pages.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => pages[index].page));
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 15),
                  width: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: pages[index].color!,
                        ),
                        child: Icon(
                          pages[index].icon,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                      AppText(text: pages[index].title, size: 14)
                    ],
                  ),
                ),
              );
            }));
  }
}
