import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_intesco/commons/modals/photo_item.dart';
import 'package:test_intesco/commons/utils/datetime_utils.dart';

class PhotoDetailPage extends StatelessWidget {
  final PhotoItem photoItem;

  const PhotoDetailPage({super.key, required this.photoItem});

  Widget _buildDetailItem(
    BuildContext context, {
    required IconData iconData,
    required String text,
    int? textMaxLines = 2,
    String? subText,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 18.h),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            iconData,
            size: 24.r,
            color: Colors.grey,
          ),
          SizedBox(width: 24.w,),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: textMaxLines,
                ),
                if (subText != null) Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Text(
                    subText,
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
          
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Chi tiết',
          style: TextStyle(
            fontSize: 24.sp,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, size: 24.r, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildDetailItem(context,
                iconData: Icons.calendar_month_outlined,
                text: DateTimeUtils.toLocalDateTimeString(photoItem.createdAt),
              ),
              _buildDetailItem(context,
                iconData: Icons.photo_outlined,
                text: photoItem.name ?? 'Chưa cập nhật',
                subText: '${photoItem.width} x ${photoItem.height}'
              ),
              if (photoItem.description?.isNotEmpty ?? false) 
                _buildDetailItem(context,
                  iconData: Icons.description_outlined,
                  text: photoItem.description ?? '',
                  textMaxLines: 8,
                ),
            ],
          ),
        ),
      ),
    );
  }
}