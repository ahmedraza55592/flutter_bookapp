import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'books.dart';


class BookDetails extends StatefulWidget {
  final Books index;
  final String id;
  final String pdf;
  final String name;
  final String status;
  final String date;
  final String views;
  final String book_image;
  final String id_categories;
  final String id_sub_categories;

  BookDetails(this.index, this.id, this.pdf, this.name, this.status, this.date,
      this.views, this.book_image, this.id_categories, this.id_sub_categories);

  @override
  _BookDetailsState createState() => _BookDetailsState();
}
class _BookDetailsState extends State<BookDetails> {
  bool downloading = false;
  var progressString = "";


  Future<void> downloadFile() async {
    Dio dio = Dio();
    try{
      var dir = await getApplicationDocumentsDirectory();
      await dio.download(widget.pdf, "${dir.path}/mypdf.pdf",onReceiveProgress: (rec,total){
        print("rec: $rec, Total: $total");
        setState(() {
          downloading = true;
          progressString = ((rec/total)*100).toStringAsFixed(0)+"%";
        });
      });
    }catch(e){
      print(e);
    }
    setState(() {
      downloading = false;
      progressString = "Download Completed";
    });
    print("Download Complete");
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 250.0,
              height: 350.0,
              decoration: new BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                    image: NetworkImage(widget.book_image),
                    fit: BoxFit.fill,
                  )
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: <Widget>[

                  Text(
                    widget.views,
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.visibility,
                        color: Theme
                            .of(context)
                            .primaryColor,
                      ),
                      onPressed: () {}),
                  IconButton(
                    icon: Icon(
                      Icons.file_download,
                      color: Theme
                          .of(context)
                          .primaryColor,
                    ),
                    onPressed: () {
                      setState(() {
                        downloadFile();
                      });
                    },
                  )
                ]
            )
          ]
      ),
    );
  }
}
