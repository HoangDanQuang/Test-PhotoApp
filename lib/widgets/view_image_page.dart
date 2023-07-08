import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_intesco/commons/modals/photo_item.dart';
import 'package:test_intesco/widgets/photo_detail_page.dart';

class ViewImagePage extends StatefulWidget {
  const ViewImagePage({super.key, 
      required this.photoItems, this.initialIndex = 0});

  final List<PhotoItem> photoItems;
  final int initialIndex;

  @override
  _ViewImagePageState createState() => _ViewImagePageState();
}

class _ViewImagePageState extends State<ViewImagePage> {
  late int index;
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    index = widget.initialIndex;
    _controller = PageController(initialPage: index);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 200.h,
                child: PageView(
                  controller: _controller,
                  onPageChanged: (int val) {
                    setState(() {
                      index = val;
                    });
                  },
                  scrollDirection: Axis.horizontal,
                  children: [...renderImages(widget.photoItems)]),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios_rounded, size: 24.r, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    IconButton(
                      icon: Icon(Icons.more_vert, size: 24.r, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
              )
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.favorite_outline, size: 24.r, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    SizedBox(width: 48.w,),
                    IconButton(
                      icon: Icon(Icons.info_outline, size: 24.r, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PhotoDetailPage(photoItem: widget.photoItems[index]),
                          ),
                        );
                      },
                    ),
                    SizedBox(width: 48.w,),
                    IconButton(
                      icon: Icon(Icons.delete_outline, size: 24.r, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }

  List<Widget> renderImages(List<PhotoItem> photoItems) {
    List<Widget> results = [];

    for (var item in photoItems) {
      results.add(
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.contain,
              image: NetworkImage(item.imageUrl),
            ),
          ),
        )
        // CachedNetworkImage(
        //   placeholder: (context, url) => Center(
        //     child: Container(
        //       height: 48.r,
        //       width: 48.r,
        //       child: CircularProgressIndicator(
        //         color: Colors.grey[300],
        //       )
        //     )
        //   ),
        //   imageUrl: item.imageUrl,
        //   fit: BoxFit.contain,
        // ),
      );
    }

    return results;
  }
}