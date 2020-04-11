import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatefulWidget {
  static const routeName = "/news";

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _Post extends StatelessWidget {
  _Post({
    Key key,
    this.title,
    this.subtitle,
    this.user,
    this.date,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String user;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                '$title',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.oswald(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                '$subtitle',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.oswald(
                  textStyle: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.black54,
                  ),
                ),
              ),
              Text(
                '$user',
                maxLines: 1,
                overflow: TextOverflow.clip,
                style: GoogleFonts.oswald(
                  textStyle: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.black87,
                  ),
                ),
              ),
              Text(
                DateFormat('HH:mm     dd-MMM-yy').format(date),
                style: GoogleFonts.oswald(
                  textStyle: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ListItem extends StatelessWidget {
  ListItem({
    Key key,
    this.thumbnail,
    this.title,
    this.subtitle,
    this.user,
    this.publishDate,
  }) : super(key: key);

  final Widget thumbnail;
  final String title;
  final String subtitle;
  final String user;
  final DateTime publishDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 50,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.0,
              child: thumbnail,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                child: _Post(
                  title: title,
                  subtitle: subtitle,
                  user: user,
                  date: publishDate,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _NewsPageState extends State<NewsPage> {
  List data;

  Future fetchPost() async {
    final response = await http.get(
      'https://newsapi.org/v2/everything?q=COVID&from=2020-03-16&sortBy=publishedAt&apiKey=6a88cd9103ce4509a379f71e33b8136c&language=en&pageSize=100&page=1',
    );
    print(response.body[2]);
    this.setState(() {
      var tempData = json.decode(response.body);
      data = tempData["articles"];
    });
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    this.fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return data == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : data.length == 0
            ? Center(
                child: Text('No Records Found'),
              )
            : ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        _launchURL(data[index]['url']);
                      },
                      child: Container(
                    padding: EdgeInsets.all(5),
                    child: Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: SizedBox(
                            height: 130,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                data[index]["urlToImage"] == null
                                    ? Container()
                                    : AspectRatio(
                                        aspectRatio: 1.0,
                                        child: Image.network(
                                            data[index]["urlToImage"])),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20.0, 0.0, 2.0, 0.0),
                                    child: _Post(
                                      title: data[index]["title"],
                                      subtitle: data[index]["description"],
                                      user: data[index]["url"],
                                      date: DateTime.parse(
                                          data[index]["publishedAt"]),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        elevation: 8,
                      ),
                    ),
                  );
                },
              );
  }
}
