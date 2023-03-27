import 'package:flutter/material.dart';


   Widget drawerItem(image, title){
    return Column(
      children: [
        ListTile(
          leading: Image.asset(image, height: 40,width: 40,),
          title: Text(title),
        ),
          SizedBox(height: 12,),

      ],
    );
   }