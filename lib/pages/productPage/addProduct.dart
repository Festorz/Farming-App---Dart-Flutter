import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mkulima/enums/connectivity_status.dart';
import 'package:mkulima/misc/colors.dart';
import 'package:mkulima/pages/subscriptions_page/mpesa_pay.dart';
import 'package:mkulima/server/farmerNotifier.dart';
import 'package:mkulima/widgets/appbutton.dart';
import 'package:mkulima/widgets/apptext.dart';
import 'package:mkulima/widgets/headertext.dart';
import 'package:mkulima/widgets/snackbar.dart';
import 'package:mkulima/widgets/textfield.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String phone = '';
  String location = '';
  String userlocation = '';
  String country = '';
  String town = '';
  String productType = '';
  bool addMore = false;
  bool premium = false;
  bool defaultaddMore = false;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    SharedPreferences user = await SharedPreferences.getInstance();
    setState(() {
      username = user.getString('username') ?? '';
      phone = user.getString('phone') ?? '';
      userlocation = user.getString('location') ?? '';
      town = user.getString('town') ?? '';
      country = user.getString('country') ?? '';
      addMore = user.getBool('upload')!;
      premium = user.getBool('premium')!;
    });
  }

  var imageFile;

  String imagePath = '';
  bool market = true;

  // controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _townController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dataNotifier = Provider.of<FarmerNotifier>(context);
    final connection = Provider.of<ConnectivityStatus>(context);

    if (dataNotifier.products.isEmpty) {
      setState(() {
        defaultaddMore = true;
      });
    }

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, size: 22, color: Colors.white)),
        title:
            const BoldText(text: "Add Product", size: 20, color: Colors.white),
        centerTitle: true,
        backgroundColor: AppColors.bluetheme,
        elevation: 0,
      ),
      backgroundColor: AppColors.bluetheme,
      body: Container(
        height: h,
        width: w,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white54,
            border: Border.all(
                style: BorderStyle.solid, color: Colors.black54, width: 1.0),
            borderRadius: BorderRadius.circular(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              imageFile != null
                  ? Container(
                      height: h * 0.35,
                      width: w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          image: DecorationImage(
                              image: FileImage(
                                imageFile,
                              ),
                              fit: BoxFit.cover)))
                  : Container(),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 20),
                    const AppText(text: 'Title', size: 16),
                    const SizedBox(height: 10),
                    AppTextFormfield(
                        controller: _titleController,
                        hint: 'Name of the product',
                        icon: Icons.edit),
                    const SizedBox(height: 20),
                    const AppText(
                      text: 'Price (Ksh)',
                      size: 16,
                    ),
                    const SizedBox(height: 10),
                    AppTextFormfield(
                        controller: _priceController,
                        hint: 'e.g. 100',
                        icon: Icons.edit,
                        type: TextInputType.number),
                    const SizedBox(height: 20),
                    const AppText(
                      text: 'Quantity',
                      size: 16,
                    ),
                    const SizedBox(height: 10),
                    AppTextFormfield(
                      controller: _quantityController,
                      hint: 'e.g. 10 bags of maize',
                      icon: Icons.edit,
                    ),
                    const SizedBox(height: 20),
                    const AppText(
                      text: 'Description',
                      size: 16,
                    ),
                    const SizedBox(height: 10),
                    AppTextFormfield(
                      controller: _descriptionController,
                      hint: 'Product description',
                      icon: Icons.edit,
                      lines: 10,
                      type: TextInputType.multiline,
                    ),
                    const SizedBox(height: 20),
                    const AppText(
                      text: 'Product type',
                      size: 16,
                    ),

                    const SizedBox(height: 10),
                    Container(
                      // height: 80,
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      width: w,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButtonFormField<String>(
                        validator: (value) {
                          if (value == null) {
                            return "Please select product type";
                          }
                          return null;
                        },
                        hint: const AppText(
                            text: 'Select product type',
                            size: 14,
                            color: Colors.black54),
                        items: <String>[
                          'Crop product',
                          'Animal product',
                          'Other'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: AppText(text: value, size: 14),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            productType = value!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    const BoldText(text: 'Product Location', size: 15),

                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const AppText(
                                  text: "Town", size: 13, color: Colors.black),
                              const SizedBox(height: 5),
                              AppTextFormfield(
                                controller: _townController,
                                hint: 'town',
                                icon: Icons.edit,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const AppText(
                                  text: "Location",
                                  size: 13,
                                  color: Colors.black),
                              const SizedBox(height: 5),
                              AppTextFormfield(
                                controller: _locationController,
                                hint: 'Location, village, area',
                                icon: Icons.edit,
                                type: TextInputType.multiline,
                                lines: 5,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 30),

                    Center(
                      child: Container(
                        width: 200,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                style: BorderStyle.solid,
                                color: Colors.blue,
                                width: 1.0),
                            color: Colors.white),
                        child: GestureDetector(
                          onTap: () => _addFromgallery(),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image,
                                  color: Colors.blue[700], size: 20),
                              const SizedBox(width: 10),
                              const AppText(
                                text: "upload image",
                                size: 16,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Expanded(child: Container()),
                    const SizedBox(height: 30),

                    // Container(
                    //   height: 50,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(10),
                    //       color: Colors.white),
                    //   child: CheckboxListTile(
                    //     activeColor: Colors.pink[800],
                    //     value: market,
                    //     onChanged: (newValue) {
                    //       setState(() {
                    //         market = newValue!;
                    //         // print(market);
                    //       });
                    //     },
                    //     title: const AppText(
                    //         text: "Add to market",
                    //         size: 16,
                    //         color: Colors.black87),
                    //     controlAffinity: ListTileControlAffinity.leading,
                    //   ),
                    // ),

                    Center(
                      child: GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              if (imageFile != null) {
                                if (addMore || defaultaddMore) {
                                  if (connection !=
                                      ConnectivityStatus.Offline) {
                                    var location =
                                        '${_townController.text}, ${_locationController.text}';
                                    var date = DateTime.now().toString();
                                    var data = {
                                      "username": username,
                                      "phone": phone,
                                      "location": location,
                                      "country": country,
                                      "title": _titleController.text,
                                      "price": int.parse(_priceController.text),
                                      "quantity": _quantityController.text,
                                      "type": productType,
                                      "premium": premium,
                                      "description":
                                          _descriptionController.text,
                                      "imageFile": await MultipartFile.fromFile(
                                          imagePath),
                                      "addedDate": date,
                                    };
                                    // print(data);
                                    dataNotifier.addProduct(data, context);
                                    Appsnackbar.snackbar(
                                        context,
                                        'Product added successfully',
                                        AppColors.bluetheme);
                                    Timer(const Duration(seconds: 5), () {
                                      dataNotifier.disposeValues();
                                      dataNotifier.getProducts();
                                    });
                                    Navigator.pop(context);
                                  } else {
                                    Appsnackbar.snackbar(
                                        context,
                                        'Error: You are offline, please connect to the internet!',
                                        AppColors.pink);
                                  }
                                } else {
                                  showAlertDialog(context, 200);
                                }
                              } else {
                                Appsnackbar.snackbar(context,
                                    'Please choose an image', AppColors.pink);
                              }
                            }
                          },
                          child: AppButton(
                              color: Colors.white,
                              backgroundColor: Colors.black,
                              text: 'Submit',
                              size: w * 0.75,
                              borderColor: Colors.white70)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _addFromgallery() async {
    PickedFile pickedFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, maxHeight: 1200, maxWidth: 1200);
    setState(() {
      imageFile = File(pickedFile.path);
      imagePath = pickedFile.path;
      // print(pickedFile);
      // print(imageFile);
    });
  }

  showAlertDialog(BuildContext context, double amount) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    Widget closeButton = IconButton(
      icon: const Icon(Icons.close_outlined, color: Colors.white, size: 25),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alertDialog = AlertDialog(
      backgroundColor: AppColors.bluetheme.withOpacity(0.8),
      title: Center(
          child:
              BoldText(text: "Subscribe", size: 22, color: Colors.amber[700])),
      content: SizedBox(
        height: h * 0.25,
        width: w,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BoldText(
                text: 'Ksh. ${amount.toString()}',
                size: 18,
                color: Colors.lime),
            const SizedBox(height: 15),
            const AppText(
                text: 'Subscribe to add more products',
                size: 14,
                color: Colors.white,
                lines: 3),
            const SizedBox(height: 10),
            Center(
              child: Wrap(
                children: List.generate(5, (index) {
                  return const Icon(Icons.star, color: Colors.amber, size: 16);
                }),
              ),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MpesaPay(price: amount)));
              },
              child: AppButton(
                  color: Colors.teal[800],
                  backgroundColor: Colors.white,
                  text: "Lipa na mpesa",
                  size: w * 0.6,
                  borderColor: Colors.black54),
            ),
          ],
        ),
      ),
      actions: [closeButton],
    );

    showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
