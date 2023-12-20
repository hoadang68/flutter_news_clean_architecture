import 'package:flutter/material.dart';
import 'package:news/config/colors.dart';
import 'package:news/features/data/model/news.dart';

class NewsDetailScr extends StatefulWidget {
  const NewsDetailScr({super.key, required this.news});

  final News news;

  @override
  State<NewsDetailScr> createState() => _NewsDetailScrState();
}

class _NewsDetailScrState extends State<NewsDetailScr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                widget.news.image_url,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Text(
              widget.news.category.first.toUpperCase(),
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,color: AppColors.mGreen),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 8),
            child: Text(widget.news.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700,color: Colors.white)),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 8),
            child: Text(widget.news.pubDate,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Color(0xFFB8B8B8))),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 16,bottom: 16),
            child: Text(widget.news.content,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Color(0xFFB8B8B8))),
          ),
        ],
      ),
    );
  }
}
