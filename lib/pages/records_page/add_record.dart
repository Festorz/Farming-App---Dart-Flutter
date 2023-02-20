import 'package:flutter/material.dart';
import 'package:mkulima/misc/colors.dart';
import 'package:mkulima/server/recordsNotifier.dart';
import 'package:mkulima/widgets/appbutton.dart';
import 'package:mkulima/widgets/apptext.dart';
import 'package:mkulima/widgets/headertext.dart';
import 'package:mkulima/widgets/textfield.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import '../../widgets/snackbar.dart';

class AddRecord extends StatefulWidget {
  const AddRecord({Key? key}) : super(key: key);

  @override
  State<AddRecord> createState() => _AddRecordState();
}

class _AddRecordState extends State<AddRecord> {
  final _formKey = GlobalKey<FormState>();
  String username = '';

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    SharedPreferences user = await SharedPreferences.getInstance();
    setState(() {
      username = user.getString('username') ?? '';
    });
  }

  // controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _expenseController = TextEditingController();
  final TextEditingController _profitController = TextEditingController();
  final TextEditingController _plansController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final recordsNotifier = Provider.of<RecordsNotifier>(context);

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    DateTime date = DateTime.now();
    String day = DateFormat('MMMM d, yyyy HH:mm').format(date);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, size: 22, color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 11, 61, 63),
        elevation: 0,
        centerTitle: true,
        title: const BoldText(
          text: "Add a record",
          size: 20,
          color: Colors.white,
        ),
      ),
      backgroundColor: Color.fromARGB(255, 11, 61, 63),
      body: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        width: w,
        height: h,
        decoration: BoxDecoration(
            color: Colors.white54,
            border: Border.all(
                style: BorderStyle.solid, color: Colors.black54, width: 1.0),
            borderRadius: BorderRadius.circular(20)),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: BoldText(text: day, size: 20),
                ),
                const AppText(text: "Topic", size: 16),
                const SizedBox(height: 10),
                AppTextFormfield(
                    controller: _titleController,
                    hint: 'Topic',
                    icon: Icons.edit),
                const SizedBox(height: 20),
                const AppText(text: "Description", size: 16),
                const SizedBox(height: 10),
                AppTextFormfield(
                    controller: _descriptionController,
                    hint: 'Record description',
                    lines: 5,
                    type: TextInputType.multiline,
                    icon: Icons.edit),
                const SizedBox(height: 20),
                const AppText(text: "Expenditure", size: 16),
                const SizedBox(height: 10),
                AppTextFormfield(
                    type: TextInputType.number,
                    controller: _expenseController,
                    hint: 'Total expenses',
                    icon: Icons.edit),
                const SizedBox(height: 20),
                const AppText(text: "Profit", size: 16),
                const SizedBox(height: 10),
                AppTextFormfield(
                    type: TextInputType.number,
                    controller: _profitController,
                    hint: 'Profits',
                    icon: Icons.edit),
                const SizedBox(height: 20),
                const AppText(text: "Plans", size: 16),
                const SizedBox(height: 10),
                AppTextFormfield(
                    controller: _plansController,
                    hint: 'Future Plans',
                    lines: 5,
                    type: TextInputType.multiline,
                    icon: Icons.edit),
                const SizedBox(height: 20),
                Center(
                    child: GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            var data = {
                              "username": username,
                              "title": _titleController.text,
                              "description": _descriptionController.text,
                              "expense": int.parse(_expenseController.text),
                              "profit": int.parse(_profitController.text),
                              "plans": _plansController.text,
                              "addedDate": DateTime.now().toString(),
                            };
                            recordsNotifier.addRecord(data, context);
                            recordsNotifier.disposeValues();
                            recordsNotifier.getRecords();
                            Appsnackbar.snackbar(
                                context, 'Processing...', AppColors.bluetheme);
                            Navigator.pop(context);
                          }
                        },
                        child: AppButton(
                            color: Colors.white,
                            backgroundColor: Colors.black,
                            text: 'Save',
                            size: w * 0.5,
                            borderColor: Colors.black)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
