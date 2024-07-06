import 'package:flutter/material.dart';
import 'package:quran_app/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';


class SurahBuilder extends StatefulWidget {

  final surah;
  final arabic;
  final surahName;
  int ayah;

   SurahBuilder({this.arabic,required this.ayah,this.surah,this.surahName,Key?key}):super(key:key);

  @override
  State<SurahBuilder> createState() => _SurahBuilderState();
}

class _SurahBuilderState extends State<SurahBuilder> {
  bool view=true;
  @override
  //initstate
  //jumbtoayah
  //savesebookmark
  //versebuilding
  //singlesurabuilder
  void initState() {
WidgetsBinding.instance.addPostFrameCallback((_) =>jumbToAyah());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    int lengthOfSura=noOfVerses[widget.surah];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: Scaffold(
        appBar:AppBar(
          leading: Tooltip(
            message: 'Mushaf Mood',
            child: TextButton(
              child:const  Icon(
                Icons.chrome_reader_mode,
                color:Colors.white,
              ),
              onPressed: (){
                setState(() {
                  view=!view;
                });
              },),
          ),
          centerTitle: true,
          title: Text(
            widget.surahName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color:Colors.white,
              fontFamily: 'quran',
              shadows: [
                Shadow(
                  offset: Offset(1,1),
                  blurRadius: 2.0,
                  color:Color.fromARGB(255, 0, 0, 0),
                )
              ]
            ),
            
          ),
          backgroundColor: const Color.fromARGB(255, 56, 115, 59),
        ),
        body: SingleSuraBuilder(lengthOfSura),),
    );
  }
  
  jumbToAyah() {
    if(fabIsClicked){
      itemScrollController.scrollTo(
        index: widget.ayah,
        duration: const Duration(seconds: 2),
        curve:Curves.easeInCubic);
    }
    fabIsClicked=false;
  }



Row verseBuilder(int index,previousVerses){
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text( widget.arabic[index+previousVerses]["aya_text"],
              textDirection: TextDirection.rtl,
              style:TextStyle(
                fontFamily: arabicFont,
                fontSize: arabicFontSize,
                color:const Color.fromARGB(196, 0, 0, 0),
              ),),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [],
              ),],),),],);
    
    
  }

SafeArea SingleSuraBuilder(lengthOfSura){
  String fullSura='';
  int previousVerses=0;
  if(widget.surah+1 !=1){
    for(int i=widget.surah-1;i>=0;i--){
      previousVerses=previousVerses+noOfVerses[i];
    }
  }
  if(!view){
    for(int i=0;i<lengthOfSura;i++){
      fullSura +=(widget.arabic[i+previousVerses]['aya_text']);
    }
  }

  return SafeArea(
    child:Container(
      color:const Color.fromARGB(255,253,251,240),
      child:view
      ?ScrollablePositionedList.builder(
        itemBuilder: (BuildContext context,int index){
          return Column(
            children: [ 
              (index!=0)||(widget.surah==0)||(widget.surah==8)
              ? const Text(' ')
              : const ReturnBasmala(),
              Container(
                color:index %2 !=0
                ?const Color.fromARGB(255, 253, 251, 240)
                :const Color.fromARGB(255, 253, 247, 230),
                child:PopupMenuButton(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:verseBuilder(index, previousVerses),
                    ),
                    itemBuilder: (context) => [
                     PopupMenuItem(
                        onTap:() {
                          saveBookMark(widget.surah +1, index);
                        },
                        child: Row(
                          children: const[
                            Icon(Icons.bookmark_add,
                            color:Color.fromARGB(255, 56, 115, 59),
                            ),
                            SizedBox(width: 10,),
                            Text("BookMark"),
                          ],
                        ),

                      ),
                      PopupMenuItem(
                        onTap: (){

                        },
                        child:Row(
                          children: const [
                            Icon(Icons.share,
                            color:Color.fromARGB(255, 56, 115, 59),
                            ),
                            SizedBox(width: 10,),
                            Text("Share"),

                          ],

                        ),
                      )
                    ],
                    ),

              ),
            ],

          );
        },
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
        itemCount:lengthOfSura,
      )
      :ListView(
        children: [
          Row(
            children: [
              Expanded(
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    widget.surah+1 !=1 && widget.surah+1 !=9
                    ?const ReturnBasmala()
                    :const Text(""),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:Text(
                        fullSura,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style:TextStyle(
                          fontFamily: arabicFont,
                          fontSize: mushafFontSize,
                          color:const Color.fromARGB(196, 44, 44, 44),
                        )))
                  ],) )
            ],)
        ],
      )
    ));
}
}

class ReturnBasmala extends StatelessWidget {
  const ReturnBasmala({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Center(
          child:Text(
             'بسم الله الرحمن الرحيم ',
             style: TextStyle(
              fontFamily: 'me_quran',
              fontSize: 30,

             ),
             textDirection: TextDirection.rtl,)
        )
      ],
    );
  }
}