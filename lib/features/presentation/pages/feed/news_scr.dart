import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:dio/dio.dart';
import 'package:news/config/colors.dart';
import 'package:news/features/data/data_sources/news_service.dart';
import 'package:news/features/data/repository/news_repo_impl.dart';
import 'package:news/features/presentation/bloc/news_bloc.dart';
import 'package:news/features/presentation/pages/feed/tab_page/bussiness_page.dart';
import 'package:news/features/presentation/pages/feed/tab_page/technology_page.dart';
import 'package:news/features/presentation/pages/feed/tab_page/trending_page.dart';


class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen>
    with TickerProviderStateMixin {
  late NewsBloc newsBloc;

  @override
  void initState() {
    super.initState();
    newsBloc = NewsBloc(repository: NewsRepoImpl(NewsService(Dio())));
    newsBloc.fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
    TextEditingController _textEditController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                controller: _textEditController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFFF00),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                  hintText: "Search News...",
                  hintStyle: const TextStyle(
                    fontSize: 18,
                    color: AppColors.mGrey,
                  ),
                  suffixIcon: IconButton(onPressed: (){
                    _onSearchPressed(context, _textEditController.value.text);
                  }, icon: const Icon(
                    Icons.search,
                    size: 26,
                    color: AppColors.mGrey,
                  )),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(45.0),
                    borderSide: const BorderSide(
                      width: 2.0,
                      color: AppColors.mGrey,
                    ), // BorderSide
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(45.0),
                    borderSide: const BorderSide(
                      width: 2.0,
                      color: AppColors.mGreen,
                    ), // BorderSide
                  ), // OutlineInputBorder
                ), // InputDecoration
              ), // TextField
            ), // Expanded
          ],
        ), // Row
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
                controller: _tabController,
                isScrollable: true,
                labelPadding: const EdgeInsets.only(left: 20, right: 20),
                labelColor: Colors.white,
                unselectedLabelColor: AppColors.mGrey,
                // indicatorColor: Colors.transparent,
                dividerColor: Colors.transparent,
                indicator: CircleTabIndicator(
                    color: AppColors.mGreen, radius: 4),
                tabs: [
                  const Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("All"),
                  ),
                  const Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Tech"),
                  ),
                  const Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Bussiness"),
                  ),
                ]),
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              TrendingPage(),
              TechnologyPage(),
              BussinessPage()
            ]),
          ),
        ],
      ),
    );
  }

  void _onSearchPressed(BuildContext context, String keyword) {
    Navigator.pushNamed(context, '/Search', arguments: keyword);
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  final double radius;

  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final double radius;
  final Color color;

  _CirclePainter({required this.radius, required this.color});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    late Paint _paint;
    _paint = Paint()..color = color;
    _paint = _paint..isAntiAlias = true;
    final Offset circleOffset = offset +
        Offset(configuration.size!.width / 2,
            configuration.size!.height - radius / 4);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}
