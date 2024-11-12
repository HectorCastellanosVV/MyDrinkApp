import 'package:flutter/material.dart';
class BebidasScreen extends StatefulWidget{
  const BebidasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    return Scanffold(
      appBar:AppBar(
        title:const Text("Bebidas"),
      ),
      body:FutureBuilder<Bebidas>(
        future:fetchBebidas(),
        builder:(context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child:
            CircularProgressIndicator());
          }else if(snapshot.hasError){
            return Center(child:Text("Error: ${snapshot.error}"))
          }
        }
      )
    )
  }
}