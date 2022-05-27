
import 'package:flutter/painting.dart';
import 'package:new_app/widgets/colors.dart';
import 'package:new_app/widgets/text_widget.dart';


DateTime time= DateTime.now();


 greetings(){
  if(time.hour>=00&&time.hour<12){
    return  const TextWidget(text:"Good morning",maxsize: 16,minsize: 12, color:amber,fontWeight: FontWeight.bold,);
  }else if(time.hour>=12&&time.hour<16){
   return  const TextWidget(text:"Good afternoon",maxsize: 16,minsize: 12, color: amber,fontWeight: FontWeight.bold,);
  }else{
   return  const TextWidget(text:"Good evening",maxsize: 16,minsize: 12, color: amber,fontWeight: FontWeight.bold);
  }

}