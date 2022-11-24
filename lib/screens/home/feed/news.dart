import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webrtc_conference/common/api_errors.dart';
import 'package:webrtc_conference/models/news_post.dart';

import '../../../common/helpers.dart';
import '../../../common/route.dart';

import '../../../cubits/news.dart';

class NewsScreen extends StatelessWidget {
  Route<T> getRoute<T>() {
    return buildRoute<T>(
      '/News',
      builder: (_) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NewsList(),
    );
  }
}

class NewsList extends StatefulWidget {
  NewsList({
    this.frontPage = false,
  });
  final bool frontPage;

  @override
  State<StatefulWidget> createState() => _NewsListState(
    frontPage: frontPage
  );
}

class _NewsListState extends State<NewsList> {
  _NewsListState({
    this.frontPage = false,
  });
  final bool frontPage;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    load(() => context.read<NewsCubit>().load());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, NewsState>(
      builder: (BuildContext context, NewsState state) {
        final cases = {
          NewsStatus.initial: () => Container(),
          NewsStatus.loading: () =>
          const Center(child: CircularProgressIndicator()),
          NewsStatus.error: () {
            return Center(
                child: FloatingActionButton(
                  onPressed: () {
                    BotToast.cleanAll();
                    _load();
                  },
                  child: const Icon(Icons.replay),
                )
            );
          },
          NewsStatus.ready: () =>
            frontPage
                ? NewsHorizontalListImpl(news: state.news!.take(3))
                : NewsListImpl(news: state.news!)
        };
        assert(cases.length == NewsStatus.values.length);
        return cases[state.status]!();
      },
    );
  }
}

class NewsHorizontalListImpl extends StatelessWidget {
  NewsHorizontalListImpl({
    required this.news,
  });
  final Iterable<NewsPostModel> news;

  _launchURL(String? url) async {
    if (url == null) {
      BotToast.showNotification(
        title: (_) => const Text('No link provided'),
      );
      return;
    }
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: news.length,
      separatorBuilder: (c, i) => const SizedBox(width: 20),
      itemBuilder: (context, index) {
        final newsPost = news.elementAt(index);
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAlias,
          width: 260,
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: newsPost.imageLink,
                height: 200,
                width: double.infinity,
                fit: BoxFit.fitWidth,
                progressIndicatorBuilder: (context, url, loadingProgress) =>
                    Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.progress,
                      ),
                    ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 4),
                          spreadRadius: 1,
                          blurRadius: 3
                      )
                    ]
                ),
                constraints: const BoxConstraints(
                    minWidth: double.infinity
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            newsPost.title,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                            )
                        ),
                        newsPost.subtitle != null
                            ? Text(
                            newsPost.subtitle!,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14
                            )
                        )
                            : Container() ,
                      ],
                    ),
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _launchURL(newsPost.postLink),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class NewsListImpl extends StatelessWidget {
  NewsListImpl({
    required this.news,
  });
  final Iterable<NewsPostModel> news;

  _launchURL(String? url) async {
    if (url == null) {
      BotToast.showNotification(
        title: (_) => const Text('No link provided'),
      );
      return;
    }
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 140),
      itemCount: news.length,
      separatorBuilder: (context, index) =>
        const Divider(
          height: 10,
          color: Colors.transparent,
        ),
      itemBuilder: (context, index) {
        final newsPost = news.elementAt(index);
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAlias,
          width: 260,
          height: 200,
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: newsPost.imageLink,
                height: 200,
                width: double.infinity,
                fit: BoxFit.fitWidth,
                progressIndicatorBuilder: (context, url, loadingProgress) =>
                    Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.progress,
                      ),
                    ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 4),
                          spreadRadius: 1,
                          blurRadius: 3
                      )
                    ]
                ),
                constraints: const BoxConstraints(
                    minWidth: double.infinity
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            newsPost.title,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                            )
                        ),
                        newsPost.subtitle != null
                         ? Text(
                            newsPost.subtitle!,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14
                            )
                        )
                        : Container(),
                      ],
                    ),
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _launchURL(newsPost.postLink),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
