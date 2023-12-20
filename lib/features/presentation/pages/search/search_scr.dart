import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:news/config/colors.dart';
import 'package:news/features/data/data_sources/news_service.dart';
import 'package:news/features/data/model/news.dart';
import 'package:news/features/data/repository/news_repo_impl.dart';
import 'package:news/features/presentation/bloc/news_bloc.dart';
import 'package:news/features/presentation/pages/detail_feed/news_detail.dart';


class SearchScr extends StatefulWidget {
  const SearchScr({super.key, required this.keyword});

  final String keyword;

  @override
  State<SearchScr> createState() => _SearchScrState();
}

class _SearchScrState extends State<SearchScr> {
  late NewsBloc newsBloc;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    newsBloc = NewsBloc(repository: NewsRepoImpl(NewsService(Dio())));
    newsBloc.search(widget.keyword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
          stream: newsBloc.searchNewsFetcher,
          builder: (context, AsyncSnapshot<List<News>> snapshot) {
            if (snapshot.hasData) {
              return technologyNewsWidget((snapshot.data as List<News>));
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }

  Widget technologyNewsWidget(List<News> listNews) {
    return ListView.builder(
      controller: _scrollController,
        shrinkWrap: true,
        itemCount: listNews.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.mBlack,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4.0),
                            child: Image.network(
                              listNews[index].image_url,
                              height: 60.0,
                              width: 80.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 4, right: 8),
                                child: Text(
                                  listNews[index].category.first,
                                  style: TextStyle(
                                      color: Colors.white60, fontSize: 12),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                listNews[index].title,
                                maxLines: 2,
                                overflow: TextOverflow.clip,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 12,
                            color: Colors.white60,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            listNews[index].pubDate,
                            style:
                                TextStyle(color: Colors.white60, fontSize: 10),
                          ),
                          Spacer(),
                          Icon(
                            Icons.share,
                            size: 14,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewsDetailScr(
                          news: listNews[index],
                        )),
              );
            },
          );
        });
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom){
      //call get next page
      print("bat dau goi next page");
      newsBloc.search(widget.keyword);
    };
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
