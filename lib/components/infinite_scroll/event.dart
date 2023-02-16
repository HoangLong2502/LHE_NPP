import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

Future<void> fetchPage({
  required PagingController pagingController,
  required int pageSize,
  required fetchData,
  required int pageKey,
}) async {
  try {
    final newItems = await fetchData(pageKey);
    final isLastPage = newItems.length < pageSize;
    if (isLastPage) {
      pagingController.appendLastPage(newItems);
    } else {
      final nextPageKey = pageKey + 1;
      pagingController.appendPage(newItems, nextPageKey);
    }
  } catch (e) {
    print('err is : $e');
    pagingController.error = e;
  }
}
