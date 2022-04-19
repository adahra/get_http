import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    const MaterialApp(
      home: BelajarGetData(),
    ),
  );
}

class BelajarGetData extends StatelessWidget {
  final String apiUrl = "https://reqres.in/api/users?per_page=15";

  const BelajarGetData({Key? key}) : super(key: key);

  Future<List<dynamic>> _fetchDataUsers() async {
    var result = await http.get(Uri.parse(apiUrl));

    return json.decode(result.body)['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get HTTP'),
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: _fetchDataUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        snapshot.data![index]['avatar'],
                      ),
                    ),
                    title: Text(
                      snapshot.data![index]['first_name'] +
                          " " +
                          snapshot.data![index]['last_name'],
                    ),
                    subtitle: Text(
                      snapshot.data![index]['email'],
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
