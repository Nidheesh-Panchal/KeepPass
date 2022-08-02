import 'package:flutter/material.dart';
import 'package:keep_pass/shared/Utils.dart';
import 'package:keep_pass/shared/widgets.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool encrypt = true;
  String labelText = "Encrypt";  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        title: const Text("Keep Pass"),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Center(
            child: Column(
              children: [
                sizedBoxHeight(),
                largeText("Encrypt or Decrypt"),
                Switch(value: encrypt, onChanged: onChanged),
                sizedBoxHeight(),
                largeText(labelText),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onChanged(bool value) {
    if(value)
    {
      setState(() {
        encrypt=true;
        labelText="Encrypt";
      });
    }
    else
    {
      setState(() {
        encrypt=false;
        labelText="Decrypt";
      });
    }
  }
}
