import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_intesco/commons/modals/photo_item.dart';
import 'package:test_intesco/commons/utils/datetime_utils.dart';
import 'package:test_intesco/pages/photo/bloc/photo_bloc.dart';
import 'package:test_intesco/widgets/view_image_page.dart';

class PhotosPage extends StatefulWidget {
  const PhotosPage({super.key});

  @override
  State<PhotosPage> createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> with AutomaticKeepAliveClientMixin {
  final PhotoBloc _photoBloc = PhotoBloc();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _photoBloc.init();
  }

  @override
  void dispose() {
    _photoBloc.dispose();
    super.dispose();
  }

  
  Widget _buildGridView(
      BuildContext context, String dateString, List<PhotoItem> items) {
    String title = '';
    if (DateTimeUtils.isToday(dateString)) {
      title = 'Hôm nay';
    } else if (DateTimeUtils.isYesterday(dateString)) {
      title = 'Hôm qua';
    } else {
      title = DateTimeUtils.toLocalWeekdayDate(dateString);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h,),
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.grey[500],
              fontWeight: FontWeight.w600
            ),
          ),
        ),
        SizedBox(height: 8.h,),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 4.r,
            mainAxisSpacing: 4.r,
            crossAxisCount: 4,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewImagePage(photoItems: items, initialIndex: index,),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(items[index].imageUrl),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<List<PhotoItem>>(
      stream: _photoBloc.photoItemsStream,
      builder: (context, snapshot) {
        final data = snapshot.data ?? [];
        final map = _photoBloc.convertToMap(data);
        return Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Column(
                  children: [
                   ...List.generate(map.length, 
                      (index) => _buildGridView(context, 
                          map.keys.elementAt(index), 
                          map.values.elementAt(index))),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 24.r,
              right: 24.r,
              child: FloatingActionButton(
                onPressed: () {
                  _photoBloc.uploadPhoto();
                },
                backgroundColor: Colors.white,
                child: Center(
                  child: Icon(
                    Icons.cloud_upload_outlined,
                    color: Theme.of(context).primaryColor,
                    size: 28.r,
                  )
                ),
              ),
            ),
          ],
        );
      }
    );
  }
}