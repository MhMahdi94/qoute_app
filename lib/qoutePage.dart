import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:qoute_app_1/model/qoute.dart';

class QoutePage extends StatefulWidget {
  const QoutePage({Key? key}) : super(key: key);

  @override
  _QoutePageState createState() => _QoutePageState();
}

class _QoutePageState extends State<QoutePage> {
  Qoute qoute = Qoute(
      author: 'Lao Tzu',
      content: 'He who knows that enough is enough will always have enough.');
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        body: SafeArea(
            child: Container(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Text(qoute.content.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontFamily: 'StickNoBills',
                  )),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(qoute.author.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'StickNoBills',
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                ],
              ),
              if (loading) Spacer(),
              if (loading)
                SpinKitWave(
                  color: Colors.white,
                  size: 30.0,
                ),
              Spacer(),
              TextButton(
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    var url = Uri.https(
                        'api.quotable.io', '/random', {'q': '{https}'});
                    var response = await http.get(url);
                    if (response.statusCode == 200) {
                      var jsonResponse = convert.jsonDecode(response.body)
                          as Map<String, dynamic>;
                      var content = jsonResponse['content'];
                      var author = jsonResponse['author'];
                      //print(content);
                      //print(author);
                      setState(() {
                        qoute = Qoute(author: author, content: content);
                        loading = false;
                      });
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Next',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'StickNoBills',
                            fontSize: 18),
                      ),
                    ],
                  ))
            ],
          ),
        )));
  }
}
