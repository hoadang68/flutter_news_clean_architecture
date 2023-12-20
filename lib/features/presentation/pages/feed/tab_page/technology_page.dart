import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:news/config/colors.dart';
import 'package:news/features/data/data_sources/news_service.dart';
import 'package:news/features/data/model/news.dart';
import 'package:news/features/data/repository/news_repo_impl.dart';
import 'package:news/features/presentation/bloc/news_bloc.dart';

class TechnologyPage extends StatefulWidget {
  const TechnologyPage({super.key});

  @override
  State<TechnologyPage> createState() => _TechnologyPageState();
}

class _TechnologyPageState extends State<TechnologyPage> with AutomaticKeepAliveClientMixin{
  late NewsBloc newsBloc;

  @override
  void initState() {
    super.initState();
    newsBloc = NewsBloc(repository: NewsRepoImpl(NewsService(Dio())));
    newsBloc.fetchTechNews();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: newsBloc.techNewsFetcher,
        builder: (context, AsyncSnapshot<List<News>> snapshot) {
          if (snapshot.hasData) {
            return technologyNewsWidget(
                (snapshot.data as List<News>));
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
  Widget technologyNewsWidget(List<News> listNews) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 8),
            child: Container(
              height: MediaQuery.of(context).size.width * 9 / 16,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  separatorBuilder: (c, i) => SizedBox(
                    width: 8,
                  ),
                  itemBuilder: (c, i) {
                    return Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(image: NetworkImage(listNews[i].image_url),fit: BoxFit.cover)),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          // Below is the code for Linear Gradient.
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color.fromRGBO(0, 0, 0, 0.5),Color.fromRGBO(0, 0, 0, 0.0), Color.fromRGBO(0, 0, 0, 0.0)],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8,right: 8),
                              child: Text(
                                listNews[i].pubDate,
                                style: TextStyle(fontSize: 14, color: Colors.white),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              padding: const EdgeInsets.only(left: 8,right: 8,bottom: 8),

                              child: Text(
                                maxLines: 2,
                                overflow: TextOverflow.clip,
                                listNews[i].title,
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  }),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Latest",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: listNews.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
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
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, bottom: 8),
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
                                  style: TextStyle(
                                      color: Colors.white60, fontSize: 10),
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
                  onTap: (){
                    _onNewsPressed(context, listNews[index]);
                  },
                );
              })
        ],
      ),
    );
  }
  void _onNewsPressed(BuildContext context, News article) {
    Navigator.pushNamed(context, '/NewsDetails', arguments: article);
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
