import 'package:flutter/material.dart';

import '../widgets/apptext.dart';

class PestsDiseases extends StatefulWidget {
  const PestsDiseases({Key? key}) : super(key: key);

  @override
  _PestsDiseasesState createState() => _PestsDiseasesState();
}

class _PestsDiseasesState extends State<PestsDiseases> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Center(
                child: AppText(
                    text: 'This is Pest and Diseases page',
                    size: 16,
                    color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
