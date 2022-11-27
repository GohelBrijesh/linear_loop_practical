import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import '../models/item.dart';

class DashboardScreen extends StatefulWidget {
  var inputedNumber;
  DashboardScreen(this.inputedNumber, {Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  var listQube = <Item>[];
  var listExclusion = <int>[];

  var currentPosition = 0;
  var min = 0;
  var max = 0;

  @override
  void initState() {
    super.initState();

    max = widget.inputedNumber;

    prepareList();

  }

  prepareList(){
    for (int i = 0;  i < max ; i++){
      listQube.add(Item(i,false));
    }
    reloadPosition();
    setState(() {});
  }

  reloadPosition(){

    if(listExclusion.length == listQube.length){

      AwesomeDialog(
        context: context,
        animType: AnimType.scale,
        dialogType: DialogType.success,
        title: 'Congratulations you have tapped all the buttons!',
        btnOkOnPress: () {
          Navigator.pop(context);
        },
      ).show();

    }else{
      var randomNo = getRandom(max);
      if(!listExclusion.contains(randomNo)){
        currentPosition = randomNo;
        print("currentPosition => $currentPosition");
        listExclusion.add(currentPosition);
        print("listExclusion => $listExclusion");
        setState(() {});
      }else{
        reloadPosition();
      }
    }
  }

  getRandom(int max){
    int random = Random().nextInt(max);
    return random;
  }

  getQubeSize(){
    return (MediaQuery.of(context).size.width - 60) / 3;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          alignment: Alignment.center,
          color: Colors.white,
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Wrap(
              direction: Axis.horizontal,
              children: [
                  for (int index = 0 ; index < listQube.length ; index++)
                  InkWell(
                    onTap: () {
                      if(!listQube[index].isTapped && currentPosition == index){
                        listQube[index].isTapped = true;
                        reloadPosition();
                        setState(() {});
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      height: getQubeSize(),
                      width: getQubeSize(),
                      decoration: BoxDecoration(
                        color: listQube[index].isTapped ? Colors.green : currentPosition == index ? Colors.blue : Colors.white,
                          border: Border.all(color: Colors.black)
                      ),
                      alignment: Alignment.center,
                    ),
                  )
              ],
            ),
          ),
        )
      ),
    );
  }
}
