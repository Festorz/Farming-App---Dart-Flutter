import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mkulima/misc/colors.dart';
import 'package:mkulima/pages/market_page/marketPage.dart';
import 'package:mkulima/pages/market_page/market_product.dart';
import 'package:mkulima/pages/records_page/record_page.dart';
import 'package:mkulima/pages/records_page/recordsPage.dart';
import 'package:mkulima/server/marketNotifier.dart';
import 'package:mkulima/server/recordsNotifier.dart';
import 'package:mkulima/widgets/apptext.dart';
import 'package:mkulima/widgets/headertext.dart';
import 'package:provider/provider.dart';

class RecordItems extends StatelessWidget {
  const RecordItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final records = Provider.of<RecordsNotifier>(context);
    double w = MediaQuery.of(context).size.width;
    double w1 = (w - 30) / 2;

    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 5, right: 10),
            child: Row(
              children: [
                const AppText(
                    text: 'Records', size: 14, bold: true, color: Colors.black),
                Expanded(child: Container()),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const RecordsPage())),
                  child: SizedBox(
                    height: 20,
                    child: Row(
                      children: const [
                        AppText(
                          text: 'See all',
                          size: 13,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 10,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
        SizedBox(
            height: 170,
            width: double.maxFinite,
            child: records.dataLoaded
                ? ListView.builder(
                    itemCount:
                        records.records.length > 4 ? 4 : records.records.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, index) {
                      return GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => RecordPage(
                                    record: records.records[index]))),
                        child: Container(
                          margin: const EdgeInsets.only(
                              right: 15, top: 10, bottom: 10),
                          height: 170,
                          width: w1,
                          padding: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  style: BorderStyle.solid,
                                  color:
                                      const Color.fromARGB(255, 52, 101, 116),
                                  width: 2.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.8),
                                    blurRadius: 3,
                                    offset: const Offset(4, 8))
                              ],
                              color: Colors.white),
                          child: Column(
                            children: [
                              Center(
                                  child: BoldText(
                                      text: records.records[index].title,
                                      size: 16,
                                      color: Colors.pink[800])),
                              const SizedBox(height: 10),
                              Center(
                                child: CircleAvatar(
                                  backgroundColor: Colors.pink[800],
                                  child: const Icon(
                                    Icons.save,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: AppText(
                                      text: _date(
                                          records.records[index].addedDate),
                                      size: 13),
                                ),
                              ),
                              Expanded(child: Container()),
                              Container(
                                height: 30,
                                width: w1,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                  color: Color.fromARGB(255, 11, 61, 63),
                                ),
                                child: const Center(
                                    child: BoldText(
                                  text: 'Mkulima App',
                                  size: 12,
                                  color: Colors.white,
                                )),
                              ),
                            ],
                          ),
                        ),
                      );
                    })
                : Center(
                    child:
                        CircularProgressIndicator(color: AppColors.bluetheme),
                  )),
      ],
    );
  }

  _date(date) {
    DateTime time = DateTime.parse(date);
    String day = DateFormat('MMMM d, yyyy HH:mm').format(time);
    return day;
  }
}
