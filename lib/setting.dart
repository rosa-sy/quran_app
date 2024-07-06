import 'package:flutter/material.dart';
import 'constant.dart';

class Setting extends StatefulWidget{
  @override
  State<Setting> createState()=>_SettingState();

}

class _SettingState extends State<Setting>{
  double _value=0.0;
  @override
  Widget build(BuildContext context) {
 return Material(
  child:Scaffold(
    appBar: AppBar(
    title:const Text (
      "Settings",),
      backgroundColor: const Color.fromARGB(255, 56, 115, 59),
      ),
      body:SafeArea(
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child:SingleChildScrollView(
            child:Column(
              children: [
                const Text(
                  'Arabic Font Size :',
                  style:TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Slider(
                  value:arabicFontSize,
                  onChanged: (value){
                    setState(() {
                     arabicFontSize=value;
                    });
                  },
                  
                  min: 20,
                  max: 40,),

                  Text(
                    "بسم الله الرحمن الرحيم ",
                    style :TextStyle(
                      fontFamily: 'quran',
                      fontSize: arabicFontSize,
                    ),
                    textDirection: TextDirection.rtl,
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10,bottom: 10),
                    child: Divider(),
                    ),
                    Text(
                      "Mushaf Mode Font Size:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),),
                      Slider(value: mushafFontSize,
                      min:20,
                      max:50,
                      onChanged: (value){
                        setState(() {
                          mushafFontSize=value;
                        });
                      }),
                       Text(
                    "بسم الله الرحمن الرحيم ",
                    style :TextStyle(
                      fontFamily: 'quran',
                      fontSize: mushafFontSize,
                    ),
                    textDirection: TextDirection.rtl,
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10,bottom: 10),
                    child: Divider(),
                    ),
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: (){
                              setState(() {
                                arabicFontSize=28;
                                mushafFontSize=40;
                              });
                              savedSetting();
                            },
                            child: Text("Save")),
                          ElevatedButton(
                            onPressed: (){
                            setState(() {
                              savedSetting();
                              Navigator.of(context).pop();
                            });
                          },
                           child: Text("Reset"))
                        ],
                      ),

              ],
            ),

          ),
        ) ,
      )
  ),
 );
  }
}