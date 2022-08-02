import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keep_pass/helper/encrypt.dart';
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
  String hintText = "Encrypted";
  String textToConvert = "";
  bool showPassword = false;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController inputController = TextEditingController();
  final TextEditingController resultController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        title: const Text("Keep Pass"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                sizedBoxHeight(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Decrypt"),
                    Switch(value: encrypt, onChanged: onChanged),
                    const Text("Encrypt"),
                  ],
                ),
                sizedBoxHeight(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: passwordController,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Please enter password";
                      }
                      if (val.length != 16 && val.length!= 32) {
                        return "Please enter password with 16 or 32 length";
                      }
                    },
                    autocorrect: false,
                    enableSuggestions: false,
                    obscureText: !showPassword,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      border: InputBorder.none,
                      hintText: "Password",
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        icon: showPassword
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                      ),
                    ),
                  ),
                ),
                sizedBoxHeight(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Please enter some text to convert";
                      }
                    },
                    controller: inputController,
                    autocorrect: false,
                    enableSuggestions: false,
                    maxLines: 3,
                    // obscureText: !showPassword,
                    decoration: InputDecoration(
                      // prefixIcon: Icon(Icons.lock),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10.0),
                      hintText: hintText + " text",
                      // suffixIcon: IconButton(
                      //   onPressed: () {
                      //     setState(() {
                      //       showPassword = !showPassword;
                      //     });
                      //   },
                      //   icon: showPassword
                      //       ? Icon(Icons.visibility)
                      //       : Icon(Icons.visibility_off),
                      // ),
                    ),
                    onChanged: (val) {
                      setState(() {
                        textToConvert = val;
                      });
                    },
                  ),
                ),
                sizedBoxHeight(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        inputController.clear();
                        inputController.text = await getInputText();
                        setState(() {
                          textToConvert = inputController.text;
                        });
                      },
                      child: const Text("Paste from clipboard"),
                    ),
                    sizedBoxWidth(),
                    ElevatedButton(
                      onPressed: () {
                        //Do encryption and decryption calls
                        if (_formKey.currentState!.validate()) {
                          if (encrypt) {
                            resultController.text = Encrypt.encryptAES(
                                textToConvert, passwordController.text);
                          } else {
                            resultController.text = Encrypt.decryptAES(
                                textToConvert, passwordController.text);
                          }
                          copy();
                        }
                      },
                      child: Text(labelText),
                    ),
                  ],
                ),
                sizedBoxHeight(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: resultController,
                    autocorrect: false,
                    enableSuggestions: false,
                    enabled: false,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10.0),
                    ),
                  ),
                ),
                sizedBoxHeight(),
                ElevatedButton(
                  onPressed: () {
                    // clipboard button action
                    copy();
                  },
                  child: const Text("Copy"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onChanged(bool value) {
    if (value) {
      setState(() {
        encrypt = true;
        labelText = "Encrypt";
        hintText = "Encrypted";
      });
    } else {
      setState(() {
        encrypt = false;
        labelText = "Decrypt";
        hintText = "Decrypted";
      });
    }
  }

  void copy() {
    Clipboard.setData(ClipboardData(text: resultController.text));
  }

  Future<String> getInputText() async {
    ClipboardData? clipboardData = await Clipboard.getData("text/plain");
    if (!clipboardData!.text!.isEmpty) {
      return clipboardData.text!;
    } else {
      return "";
    }
  }
}
