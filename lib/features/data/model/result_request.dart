import 'package:news/features/data/model/news.dart';

class ResultRequest {
  String status;

  int totalResults;
  List<News> results;
  String nextPage;

  ResultRequest({required this.status,required  this.totalResults, required this.results, required this.nextPage});

  Map<String, dynamic> toMap() {
    return {
      'status': this.status,
      'totalResults': this.totalResults,
      'results': this.results,
      'nextPage': this.nextPage,
    };
  }

  factory ResultRequest.fromMap(Map<String, dynamic> map) {
    return ResultRequest(
      status: map['status'] as String,
      totalResults: map['totalResults'] as int,
      results: (map['results'] as List<dynamic>).map((e) => News.fromMap(e)).toList(),
      nextPage: map['nextPage'] as String,
    );
  }
}