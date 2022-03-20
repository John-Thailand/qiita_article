import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:qiita_article/viewModels/article_view_model.dart';
import 'package:qiita_article/views/article_detail_page.dart';
import 'package:qiita_article/views/article_search_setting_page.dart';

class ArticlesPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ArticleSearchSettingPage(),
                  fullscreenDialog: true,
                ),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: _Articles(),
    );
  }
}

class _Articles extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(articleViewModel.notifier);
    final state = ref.watch(articleViewModel.notifier).state;

    if (state.articles.length == 0) {
      if (!state.hasNext) return Text('検索結果なし');
      return const LinearProgressIndicator();
    }

    return RefreshIndicator(
        child: ListView.builder(
          itemCount: state.articles.length,
          itemBuilder: (context, int index) {
            if (index == (state.articles.length - 1) && state.hasNext) {
              viewModel.getArticles();
              return const LinearProgressIndicator();
            }
            return _articleItem(context, state.articles[index]);
          },
        ),
        onRefresh: () async {
          await viewModel.refreshArticles();
        });
  }

  Widget _articleItem(BuildContext context, article) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
            color: Color(0x1e33333),
            width: 1,
          )),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _articleUser(article.user),
            SizedBox(height: 10.0),
            Text(article.title),
            SizedBox(height: 10.0),
            Wrap(
              spacing: 7.5,
              children: [
                for (int i = 0; i < article.tags.length; i++)
                  _articleTag(article.tag[i])
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            _articleCreatedAt(article.createdAt),
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ArticleDetailPage(
              article: article,
            ),
          ),
        );
      },
    );
  }

  Widget _articleUser(user) {
    final userId = user.id;
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(user.profileImageUrl),
          radius: 12.0,
          child: Text(''),
        ),
        SizedBox(width: 8.0),
        Text('@$userId'),
      ],
    );
  }

  Widget _articleTag(tag) {
    return GestureDetector(
        child: Container(
          child: Text(
            tag['name'],
            style: const TextStyle(
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        onTap: () {
          print(tag['name']);
        });
  }

  Widget _articleCreatedAt(createdAt) {
    DateFormat format = DateFormat('yyyy-MM-dd');
    String date = format.format(DateTime.parse(createdAt).toLocal());

    return Container(
      width: double.infinity,
      child: Text(
        '$dateに投稿',
        textAlign: TextAlign.right,
      ),
    );
  }
}
