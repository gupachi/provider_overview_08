import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/dog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Dog>(
      create: (context) => Dog(name: 'dog08', breed: 'breed08', age: 3),
      child: MaterialApp(
        title: 'Provider 08',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider 08'),
      ),
      body: Selector<Dog, String>(
        selector: (BuildContext context, Dog dog) => dog.name,
        builder: (BuildContext context,String name, Widget? child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                child!,
                SizedBox(height: 10.0),
                Text(
                  '- name: ${name}',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 10.0),
                BreedAndAge(),
              ],
            ),
          );
        },
        child: Text(
          'I like dogs very much',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}

class BreedAndAge extends StatelessWidget {
  const BreedAndAge({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //column 대신에 container 사용
    // consumer 를 사용하는 이유는 column 인 UI 기능보다 더 provider 에 유동적으로 쓸 수 있어서이다.
    //builder 랑 child 랑 쓰는 거에 따라 
    return Consumer<Dog>(
      builder: (_, Dog dog, __) {
        return Column(
          children: [
            Text(
              '- breed: ${dog.breed}',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 10.0),
            Age(),
          ],
        );
      },
    );
  }
}

class Age extends StatelessWidget {
  const Age({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<Dog , int>(
      //builder 에서 쓰면 내부 ui 에서는 쓸 필요가 없다. 
      selector:(BuildContext context,Dog dog) => dog.age,
      builder: (_, int age, __) {
        return Column(
          children: [
            Text(
              '- age: $age',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => context.read<Dog>().grow(),
              child: Text(
                'Grow',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ],
        );
      },
    );
  }
}
