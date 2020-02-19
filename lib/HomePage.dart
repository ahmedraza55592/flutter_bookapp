//import 'package:dio/dio.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'book_details.dart';
import 'books.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool downloading = false;
  var progressString = "";

  List<Books> bookdetails = [];

  Future<List<Books>> _bookDetails() async {
    var data = await http
        .get("http://hazratkhurramabbasi.org/webservice/getBooks/1000");
    var jsonData = json.decode(data.body);
    for (var bookval in jsonData) {
      Books books = Books(
          bookval['id'],
          bookval['name'],
          bookval['pdf'],
          bookval['status'],
          bookval['Date'],
          bookval['views'],
          bookval['book_image'],
          bookval['id_categories'],
          bookval['id_sub_categories']);
      bookdetails.add(books);
    }
    return bookdetails;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Khanqah e Aarfi",
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: BookSearch(),
              );
            },
          )
        ],
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: <Widget>[
          FutureBuilder(
              future: _bookDetails(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data != null) {
                  return Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      color: Theme.of(context).accentColor,
                      child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return BookDetails(
                              snapshot.data[index],
                              snapshot.data[index].id,
                              snapshot.data[index].pdf,
                              snapshot.data[index].name,
                              snapshot.data[index].status,
                              snapshot.data[index].Date,
                              snapshot.data[index].views,
                              snapshot.data[index].book_image,
                              snapshot.data[index].id_categories,
                              snapshot.data[index].id_sub_categories,
                            );
                          }),
                    ),
                  );
                } else {
                  return Container(
                    child: Padding(
                      padding: EdgeInsets.only(top: 270.0),
                      child: Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  );
                }
              })
        ],
      ),
    );
  }
}

class BookSearch extends SearchDelegate<Books> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
      close(context, null);
    });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text(query);
  }
}
