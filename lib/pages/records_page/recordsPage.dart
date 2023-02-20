import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mkulima/misc/colors.dart';
import 'package:mkulima/pages/records_page/add_record.dart';
import 'package:mkulima/pages/records_page/record_page.dart';
import 'package:mkulima/server/recordsNotifier.dart';
import 'package:mkulima/widgets/apptext.dart';
import 'package:mkulima/widgets/headertext.dart';
import 'package:provider/provider.dart';

class RecordsPage extends StatefulWidget {
  const RecordsPage({Key? key}) : super(key: key);

  @override
  _RecordsPageState createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  final TextEditingController _searchController = TextEditingController();
  bool searching = false;
  var results = [];
  String query = '';
  String filterOption = '';

  @override
  Widget build(BuildContext context) {
    final record = Provider.of<RecordsNotifier>(context);

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    double w1 = (w - 30) / 2;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.white,
            size: 22,
          ),
        ),
        actions: [],
        backgroundColor: AppColors.bluetheme,
        centerTitle: true,
        title: const BoldText(text: "Records", size: 20, color: Colors.white),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        child: Container(
          color: Colors.white,
          height: h,
          width: w,
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                width: w,
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          labelText: 'Search records',
                          labelStyle: const TextStyle(color: Colors.black54),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.black, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.black, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1.0)),
                          fillColor: Colors.white,
                          filled: true,
                          isDense: true,
                          contentPadding: const EdgeInsets.all(5),
                          prefixIcon: const Icon(Icons.search,
                              color: Colors.black, size: 20),
                          suffixIcon: searching == true
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      searching = false;
                                      FocusScope.of(context).unfocus();
                                      _searchController.clear();
                                    });
                                  },
                                  icon: const Icon(Icons.close_rounded,
                                      color: Colors.black, size: 20))
                              : null,
                        ),
                        onChanged: (text) {
                          setState(() {
                            searching = true;
                            query = text;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showPopupMenu();
                      },
                      child: Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          color: Colors.cyan[900],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: SvgPicture.asset(
                            "images/svg/setting-lines.svg",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: record.dataLoaded
                          ? GridView.extent(
                              maxCrossAxisExtent: 200.0,
                              childAspectRatio: (2 / 2),
                              shrinkWrap: true,
                              mainAxisSpacing: 10.0,
                              crossAxisSpacing: 10.0,
                              scrollDirection: Axis.vertical,
                              children: searching == false
                                  ? List.generate(record.records.length,
                                      (index) {
                                      return GestureDetector(
                                        onTap: () => Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RecordPage(
                                                      record:
                                                          record.records[index],
                                                    ))),
                                        child: Container(
                                          height: 170,
                                          width: w1,
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  style: BorderStyle.solid,
                                                  color: const Color.fromARGB(
                                                      255, 52, 101, 116),
                                                  width: 2.0),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.8),
                                                    blurRadius: 3,
                                                    offset: const Offset(4, 8))
                                              ],
                                              color: Colors.white),
                                          child: Column(
                                            children: [
                                              Center(
                                                  child: BoldText(
                                                      text: record
                                                          .records[index].title,
                                                      size: 16,
                                                      color: Colors.pink[800])),
                                              const SizedBox(height: 10),
                                              Center(
                                                child: CircleAvatar(
                                                  backgroundColor:
                                                      Colors.pink[800],
                                                  child: const Icon(
                                                    Icons.save,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                              Center(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                                  child: AppText(
                                                      text: _date(record
                                                          .records[index]
                                                          .addedDate),
                                                      size: 13),
                                                ),
                                              ),
                                              Expanded(child: Container()),
                                              Container(
                                                height: 30,
                                                width: w1,
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  20),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  20)),
                                                  color: Color.fromARGB(
                                                      255, 11, 61, 63),
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
                                  : List.generate(_filterRecords(query).length,
                                      (index) {
                                      return GestureDetector(
                                        onTap: () => Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RecordPage(
                                                      record:
                                                          record.records[index],
                                                    ))),
                                        child: Container(
                                          height: 170,
                                          width: w1,
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  style: BorderStyle.solid,
                                                  color: const Color.fromARGB(
                                                      255, 52, 101, 116),
                                                  width: 2.0),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.8),
                                                    blurRadius: 3,
                                                    offset: const Offset(4, 8))
                                              ],
                                              color: Colors.white),
                                          child: Column(
                                            children: [
                                              Center(
                                                  child: BoldText(
                                                      text: record
                                                          .records[index].title,
                                                      size: 16,
                                                      color: Colors.pink[800])),
                                              const SizedBox(height: 10),
                                              Center(
                                                child: CircleAvatar(
                                                  backgroundColor:
                                                      Colors.pink[800],
                                                  child: const Icon(
                                                    Icons.save,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                              Center(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                                  child: AppText(
                                                      text: _date(record
                                                          .records[index]
                                                          .addedDate),
                                                      size: 13),
                                                ),
                                              ),
                                              Expanded(child: Container()),
                                              Container(
                                                height: 30,
                                                width: w1,
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  20),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  20)),
                                                  color: Color.fromARGB(
                                                      255, 11, 61, 63),
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
                                    }),
                            )
                          : Center(
                              child: CircularProgressIndicator(
                                  color: AppColors.bluetheme),
                            )))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => const AddRecord()));
        },
        backgroundColor: Colors.pink[800],
        tooltip: 'Add a Record',
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }

  _date(date) {
    DateTime time = DateTime.parse(date);
    String day = DateFormat('MMMM d, yyyy HH:mm').format(time);
    return day;
  }

  Future<void> _pullRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    final record = Provider.of<RecordsNotifier>(context, listen: false);
    if (record.dataLoaded && record.records.isEmpty) {
      record.getRecords();
    }
  }

  _filterRecords(String title) {
    final rec = Provider.of<RecordsNotifier>(context);
    var records = rec.records;
    results.clear();
    if (title.isNotEmpty) {
      for (var element in records) {
        if (element.title.toLowerCase().contains(title.toLowerCase()) ||
            element.description.contains(title.toLowerCase())) {
          results.add(element);
          if (filterOption.isNotEmpty) {
            switch (filterOption) {
              case '1':
                results.sort(((a, b) => a.addedDate.compareTo(b.addedDate)));
                break;
              default:
                break;
            }
          }
        }
      }
      return results;
    }
    return results = [];
  }

  _showPopupMenu() {
    showMenu<String>(
            context: context,
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            position: const RelativeRect.fromLTRB(25, 80, 0, 0),
            items: [
              const PopupMenuItem<String>(
                  child: Text('Order by date'), value: '1')
            ],
            elevation: 8.0)
        .then((value) {
      switch (value) {
        case '1':
          setState(() {
            filterOption = '1';
          });
          return 'price';
        default:
          break;
      }
    });
  }
}
