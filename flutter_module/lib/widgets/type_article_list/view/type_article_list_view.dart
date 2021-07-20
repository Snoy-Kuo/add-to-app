import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_module/l10n/l10n.dart';
import 'package:flutter_module/models/news/news_item.dart';
import 'package:flutter_module/widgets/news_ticker/model/model.dart';
import 'package:flutter_module/widgets/type_article_list/bloc/type_article_list_bloc.dart';
import 'package:flutter_module/widgets/type_article_list/model/model.dart';

class TypeArticleListView extends StatelessWidget {
  final Function(NewsItem? item)? onItemClick;

  TypeArticleListView({required this.onItemClick});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TypeArticleListBloc, TypeArticleListState>(
      builder: (context, state) {
        if (state is TypeArticleListError) {
          return Text(state.msg);
        } else if (state is TypeArticleListLoaded) {
          return Container(
            width: MediaQuery.of(context).size.width,
            // height: state.list.length * 30,
            child: ListView.builder(
              padding: EdgeInsets.all(0),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.list.isEmpty ? 1 : state.list.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  // return the header
                  return Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 12,
                        height: 48,
                      ),
                      Icon(
                        Icons.lightbulb,
                        color: const Color(0xFF2B64A3),
                        size: 20,
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          '${(state.type == NewsType.TypeVeteran) ? l10n(context).veteran : l10n(context).rookie} ${l10n(context).articles}',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    ],
                  );
                }
                index -= 1;

                // return row
                var item = state.list[index];
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        if (onItemClick != null) onItemClick!(item);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            width: 12,
                            height: 24,
                          ),
                          Expanded(
                            child: Text(
                              item.title,
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      indent: 12,
                      endIndent: 12,
                      thickness: 1,
                    ),
                  ],
                );
              },
            ),
          );
        } else {
          //if (state is Loading){
          return CircularProgressIndicator();
        }
      },
    );
  }
}
