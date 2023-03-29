import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../common/constants/app_spacing.dart';
import '../card/user.dart';

// class PagingView extends StatefulWidget {
//   const PagingView({super.key});

//   @override
//   State<PagingView> createState() => _PagingViewState();
// }

// class _PagingViewState extends State<PagingView> {
//   final _controller = Get.put(ProductController());
//   final _pagingController =
//       PagingController<int, ProductModel>(firstPageKey: 1);
//   static const _pageSize = 30;

//   @override
//   void initState() {
//     super.initState();

//     _pagingController.addPageRequestListener((pageKey) {
//       fetchPage(
//         pagingController: _pagingController,
//         pageSize: _pageSize,
//         fetchData: _controller.getAll,
//         pageKey: pageKey,
//       );
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();

//     _pagingController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: widthDevice(context),
//       height: heightDevice(context) - 400,
//       child: PagedListView<int, ProductModel>(
//         pagingController: _pagingController,
//         builderDelegate: PagedChildBuilderDelegate<ProductModel>(
//           itemBuilder: (context, item, index) => Padding(
//             padding: EdgeInsets.symmetric(vertical: sp8),
//             child: ProductItem(
//               product: item,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



class PagingView extends StatelessWidget {
  const PagingView({required this.pagingController, super.key});

  final PagingController<int, dynamic> pagingController;

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, dynamic>(
        pagingController: pagingController,
        builderDelegate: PagedChildBuilderDelegate<dynamic>(
          itemBuilder: (context, item, index) => Padding(
            padding: EdgeInsets.symmetric(vertical: sp8),
            child: UserItem(item),
          ),
        ),
    );
  }
}
