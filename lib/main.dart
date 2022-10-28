import 'package:flutter/material.dart';
import 'dart:developer' as devtool show log ;
import 'package:universal_io/io.dart';
import 'dart:convert';

import 'package:meta/meta.dart';
extension Log on Object{
  void  log(){
    devtool.log(toString());
  }
}
abstract class CanRun{
  final Type type;
  const CanRun({required this.type});

  @mustCallSuper
  void run(){


    'the run call from the super class'.log();
  }
  // String get type{
  //   if (this is Cat){
  //     return 'I am cat ';
  //   }else {
  //     return ' other type ';
  //   }
  // }

}
class Cat extends CanRun{
  const Cat():super(type: Type.cat);


  @override
  void run() {
    super.run();
    'Cat is run'.log();
  }
}
void main() {
  runApp(const MyApp());
}
enum Type{cat , dog }
class Dog extends CanRun{
  const Dog():super(type: Type.dog);
}
mixin CanFly{
  int get speed;
  void fly(){
    'I can fly at speed $speed '.log();
  }




}
class Beerd with CanFly{
  @override
  int speed =10;


}
extension GetOnUri on Object{
  Future<HttpClientResponse>getUrl(String url)=>
      HttpClient().getUrl(Uri.parse(url))
      .then((request) => request.close());

}
mixin CanMakeGetCall{
  String get url;
  @useResult
  Future<String> getString()=>getUrl(url)
      .then((resp)=> resp.transform(utf8.decoder).join());

}
@immutable
class GetPeople with CanMakeGetCall{
  const GetPeople();
  @override
  String get url=> 'http://localhost/api/person1.json';

}
void testApi()async{
    var headers=' {"Accept": "application/json",  "Access-Control_Allow_Origin": "*"  }';
    final httpClient = HttpClient();
    final request = await httpClient.getUrl(Uri.parse("http://localhost/api/person1.json") );
    final response = await request.close();
    final st = await response.transform(utf8.decoder).join();
    st.log();
  }


void testme ()async{
  final people =await GetPeople().getString();
  people.log();

   // testApi();
  // final cat =Cat();
  // cat.run();
  // cat.type.log();
  // final dog =Dog();
  // dog.run();
  // dog.type.log();
  //
  // final eagle =Beerd();
  // eagle.fly();
  // eagle.speed=20;
  // eagle.fly();

}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    testme();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(''),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}
