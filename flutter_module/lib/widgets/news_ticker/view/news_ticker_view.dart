import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_module/widgets/news_ticker/bloc/news_ticker_bloc.dart';
import 'package:flutter_module/widgets/news_ticker/model/model.dart';

class NewsTickerView extends StatelessWidget {
  final NewsRepo repository;
  final Function(NewsItem? item)? onItemClick;
  final Function(NewsItem? item)? onMoreClick;
  late final NewsTickerBloc _bloc;

  NewsTickerView(
      {required this.repository, this.onItemClick, this.onMoreClick}) {
    _bloc = NewsTickerBloc(repository: repository);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewsTickerBloc>(
      create: (context) => _bloc..add(RefreshNewsTicker()),
      child: Container(
        width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.width * 45 / 375,
        color: Colors.white,
        child: Column(
          children: [
            Center(
              child: BlocBuilder<NewsTickerBloc, NewsTickerState>(
                builder: (context, state) {
                  if (state is NewsTickerError) {
                    return Text(state.msg);
                  } else if (state is NewsTickerLoaded) {
                    return CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        viewportFraction: 1,
                        aspectRatio: 375 / 45,
                        scrollDirection: Axis.vertical,
                      ),
                      items: state.list
                          .map(
                            (item) => InkWell(
                              onTap: () {
                                if (onItemClick != null) onItemClick!(item);
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  SizedBox(width: 12),
                                  Icon(
                                    Icons.flash_on,
                                    color: const Color(0xFF2B64A3),
                                    size: 20,
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                        '[${(item.type == NewsType.Type1) ? 'Good News' : 'Bad News'}] ${item.title}',
                                      style: Theme.of(context).textTheme.subtitle2,),
                                  ),
                                  SizedBox(width: 5),
                                  InkWell(
                                    onTap: () {
                                      if (onMoreClick != null)
                                        onMoreClick!(item);
                                    },
                                    child: Text('more >', style: Theme.of(context).textTheme.bodyText2,),
                                  ),
                                  SizedBox(width: 12),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    );
                  } else {
                    //if (state is NewsTickerLoading){
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
            Divider(
              color: const Color(0xFFE8E8E8),
              height: 2,
              thickness: 1,
              indent: 15,
              endIndent: 15,
            ),
          ],
        ),
      ),
    );
  }

  void refresh() {
    _bloc.add(RefreshNewsTicker());
  }
}
