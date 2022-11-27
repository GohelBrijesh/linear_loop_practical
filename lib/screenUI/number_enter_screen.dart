import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:linear_loop_practical/screenUI/dashboard_screen.dart';

class NumberEnterScreen extends StatefulWidget {
  const NumberEnterScreen({Key? key}) : super(key: key);

  @override
  State<NumberEnterScreen> createState() => _NumberEnterScreenState();
}

class _NumberEnterScreenState extends State<NumberEnterScreen> {

  final _formKey = GlobalKey<FormState>();
  final numberHolder = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: FormUI(),
            ),
          ],
        ),
      ),
    );
  }

  Widget FormUI() {
    final focus = FocusNode();
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          Container(
            margin:  const EdgeInsets.only(left: 25 , top: 0 , right: 25 , bottom: 0),
            child : TextFormField(
              controller: numberHolder,
              focusNode: focus,
              textAlignVertical: TextAlignVertical.center,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  // focusedBorder: UnderlineInputBorder(
                  //   borderSide: BorderSide(color: Colors.black),
                  // ),
                  focusedBorder : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  isDense: true,
                  contentPadding: const EdgeInsets.all(10),
                  labelStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500, color: Colors.black),
                  hintStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.normal, color: Colors.grey),
                  hintText: "Enter a number"
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]')),],
              validator: validatePhone,
            ),
          ),

          const SizedBox(height: 30,),

          _submitButton(context),

        ]
    );
  }


  Widget _submitButton(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.only(right: 50,top: 10,left: 50,bottom: 10)),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.withAlpha(2)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: const BorderSide(color: Colors.black)
                )
            )
        ),
      onPressed: () {

        if (_formKey.currentState!.validate()) {
          _formKey.currentState?.save();
          var number = int.parse(numberHolder.text);
          numberHolder.clear();
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => DashboardScreen(number)));
        }

      },
        child: const Text("Submit", style: TextStyle(fontSize: 14)),
    );
  }



  String? validatePhone(value) {
    if (value.trim().isEmpty) {
      return "Enter number";
    } else if(int.parse(value) < 1) {
      return "Enter a number more than 0";
    } else if(int.parse(value) > 25) {
      return "Enter a number less than 25";
    } else
      return null;
  }

}
