import 'package:dart_data_class_generator/model/person.dart';
import 'package:flutter/material.dart';

class PersonPage extends StatelessWidget {
  const PersonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final person1 = Person(
      name: 'John Doe',
      age: 30,
      email: 'john@mail.com',
    );
    final person2 = person1.copyWith(email: 'john@doe.com');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Person'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(person2.name),
            Text(person2.age.toString()),
            Text(person2.email),
          ],
        ),
      ),
    );
  }
}
