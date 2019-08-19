import 'package:flutter/material.dart'; //disño de material
import 'package:http/http.dart' as http; //para realizar peticiones de http
import 'dart:async'; //manejar codigo asincrono
import 'dart:convert'; // convertir datos reibidos del backend a formato json

void main(){
  runApp(
    MaterialApp(
      home: HomePage()
    ),
  );
}

class HomePage extends StatefulWidget{
  @override 
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  Map data;
  List usersData;

  getUsers() async {
    http.Response response = await http.get('http://10.0.2.2:4000/api/users');
    data = json.decode(response.body);
    setState(() {
     usersData = data['users']; 
    });
    
    //debugPrint(response.body); para ver los datos que entrega el backend por consola
  }

  @override //al momento de iniciar la app solicita la obtencion de usuarios
  void initState(){
    super.initState();
    getUsers();
  }

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Usuarios'),
        backgroundColor: Colors.indigo[900],
      ),
      body: ListView.builder(
        itemCount: usersData == null ? 0 : usersData.length,
        itemBuilder: (BuildContext context, int index){
          return Card(
            child:Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text("$index",
                     style: TextStyle(
                       fontSize: 20.0,
                       fontWeight: FontWeight.w500),),
                  ),
                  CircleAvatar(backgroundImage: NetworkImage(usersData[index]['avatar']),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("${usersData[index]["firstName"]} ${usersData[index]["lastName"]}",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700
                     )
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
      );
  }
}