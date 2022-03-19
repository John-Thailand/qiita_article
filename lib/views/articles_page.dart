import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
