import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mkulima/misc/colors.dart';
import 'package:mkulima/server/recordsNotifier.dart';
import 'package:mkulima/widgets/apptext.dart';
import 'package:mkulima/widgets/headertext.dart';
import 'package:mkulima/widgets/snackbar.dart';
import 'package:provider/provider.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({Key? key, required this.record}) : super(key: key);
  final record;

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, size: 22, color: Colors.white),
            onPressed: () => Navigator.pop(context)),
        title:
            BoldText(text: widget.record.title, size: 20, color: Colors.white),
        backgroundColor: AppColors.bluetheme,
        elevation: 0,
      ),
      backgroundColor: AppColors.bluetheme,
      body: Scaffold(
        backgroundColor: AppColors.bluetheme,
        body: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          width: w,
          height: h,
          decoration: BoxDecoration(
              color: Colors.white70,
              border: Border.all(
                  style: BorderStyle.solid, color: Colors.white, width: 1.0),
              borderRadius: BorderRadius.circular(20)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Center(
                //   child: BoldText(
                //     text: widget.record.title,
                //     size: 20,
                //     color: Colors.red[900],
                //   ),
                // ),
                // const SizedBox(height: 10),
                AppText(
                  text: _date(widget.record.addedDate),
                  size: 12,
                  color: Colors.black54,
                ),
                const SizedBox(height: 20),
                const BoldText(text: "Description", size: 16),
                const SizedBox(height: 10),
                AppText(text: widget.record.description, size: 16, lines: 1000),
                const SizedBox(height: 20),
                const BoldText(text: "Total Expense", size: 16),
                const SizedBox(height: 10),
                AppText(
                    text: '${widget.record.expense.toString()} /=', size: 16),
                const SizedBox(height: 20),
                const BoldText(text: "Profits", size: 16),
                const SizedBox(height: 10),
                AppText(
                    text: '${widget.record.profit.toString()} /=', size: 16),
                const SizedBox(height: 20),
                const BoldText(text: "Plans", size: 16),
                const SizedBox(height: 10),
                AppText(text: widget.record.plans, size: 16, lines: 1000),
                // const SizedBox(height: 20),
                // Center(
                //     child: GestureDetector(
                //         onTap: () async {},
                //         child: AppButton(
                //             color: Colors.white,
                //             backgroundColor: AppColors.pink,
                //             text: 'Submit',
                //             size: w * 0.75,
                //             borderColor: Colors.black)))
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showAlertDialog(context);
          },
          backgroundColor: Colors.white,
          tooltip: 'Delete record',
          child: Icon(Icons.delete, color: Colors.red[600], size: 30),
        ),
      ),
    );
  }

  _date(date) {
    DateTime time = DateTime.parse(date);
    String day = DateFormat('MMMM d, yyyy HH:mm').format(time);
    return day;
  }

  showAlertDialog(BuildContext context) {
    final recordsNotifier =
        Provider.of<RecordsNotifier>(context, listen: false);

    Widget cancelButton = TextButton(
      child: const AppText(text: "Cancel", size: 16, color: Colors.black),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget okButton = TextButton(
      child: const AppText(text: "Ok", size: 14, color: Colors.black45),
      onPressed: () {
        recordsNotifier.deleteRecord({"id": widget.record.id});
        recordsNotifier.records
            .removeWhere((record) => record.id == widget.record.id);

        Appsnackbar.snackbar(
            context,
            "${widget.record.title} record deleted successfully",
            AppColors.pink);
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.popAndPushNamed(context, '/records');
      },
    );

    AlertDialog alertDialog = AlertDialog(
      title: const AppText(text: "Confirm", size: 15, color: Colors.blue),
      content: AppText(
          text: "Delete ${widget.record.title} record?",
          size: 16,
          lines: 3,
          bold: true),
      actions: [cancelButton, okButton],
    );

    showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }
}
