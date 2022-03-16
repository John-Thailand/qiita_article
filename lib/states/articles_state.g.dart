// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'articles_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ArticlesState _$_$_ArticlesStateFromJson(Map<String, dynamic> json) {
  return _$_ArticlesState(
    articles: json['articles'] ?? [],
    hasNext: json['hasNext'] as bool? ?? true,
    keyword: json['keyword'] as String? ?? '',
  );
}

Map<String, dynamic> _$_$_ArticlesStateToJson(_$_ArticlesState instance) =>
    <String, dynamic>{
      'articles': instance.articles,
      'hasNext': instance.hasNext,
      'keyword': instance.keyword,
    };
