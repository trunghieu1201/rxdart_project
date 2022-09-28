import 'package:flutter/foundation.dart' show immutable;
import 'package:rxdart_project/models/thing.dart';

@immutable
abstract class SearchResult {
  const SearchResult();
}

class SearchResultLoading implements SearchResult {
  const SearchResultLoading();
}

@immutable
class SearchResultHasError implements SearchResult {
  final Object error;
  const SearchResultHasError (this.error);
}
@immutable
class SearchResultWithResults implements SearchResult {
  final List<Thing> results;
  const SearchResultWithResults (this.results);
}
