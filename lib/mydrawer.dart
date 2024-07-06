import 'package:flutter/material.dart';
import 'package:quran_app/constant.dart';
import 'package:quran_app/setting.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
            color:Colors.white,
          ),
          child: Column(
            children: [
              Image.asset('assets/quran.png',height: 80,),
              const Text("Al Quran ",style:TextStyle(fontSize: 20)),
            ],
          ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            onTap: (){
              Navigator.pop(context);
              Navigator.push(context,MaterialPageRoute(builder: (context)=> Setting()));
            },
          ),
          ListTile( 
            leading: const Icon(Icons.share),
            title: const Text("Share"),
            onTap: (){
              Share.share('''*Quran app\n you can develop''');
              Navigator.pop(context);
             
            },),
          ListTile(
             leading: const Icon(Icons.rate_review),
            title: const Text("Rate"),
            onTap: ()async{
              if(!await launchUrl(quranAppUrl,
              mode:LaunchMode.externalApplication)){
                throw 'Could not launch $quranAppUrl';
              }
            },
          ),
        ],
        
      ),
    );
  }
}