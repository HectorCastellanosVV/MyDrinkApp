import 'package:flutter/material.dart';

import 'package:mydrink_app/models/categoria_model.dart';
import 'package:mydrink_app/screens/home_screen.dart';
import 'package:mydrink_app/services/categorias_service.dart';
import 'package:mydrink_app/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:mydrink_app/models/bebida_model.dart';

class BebidasScreen extends StatefulWidget{
  const BebidasScreen({super.key});
  @override
  State<BebidasScreen>  createState() => _bebidasScreenState();
}
  class _bebidasScreenState extends State<BebidasScreen>{
  TextEditingController nombreController = TextEditingController();
  TextEditingController precioController = TextEditingController();
  TextEditingController CatIDController = TextEditingController();
  TextEditingController stockController = TextEditingController();

  Widget build(BuildContext context) {
      Size size = MediaQuery.of(context).size;
      double width = size.width;
      return Scanffold(
        appBar:AppBar(
          title:const Text("Bebidas"),
        ),
        body:FutureBuilder<Bebida>(
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

 
}