// import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_intesco/commons/l10n/generated/l10n.dart';
import 'package:test_intesco/pages/auth/bloc/auth_bloc.dart';
import 'package:test_intesco/pages/photo/views/photos_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  AppBar _buildAppBar(BuildContext context) {
    AuthBloc authBloc = Provider.of<AuthBloc>(context, listen: false);
    Widget avatarWidget = authBloc.user == null || authBloc.user?.avatar == null
        ? IconButton(
            onPressed: () {}, 
            icon: Icon(
              Icons.account_circle_outlined,
              size: 24.r,
              color: Colors.grey,),
          )
        : GestureDetector(
            // onDoubleTap: () {
            //   authBloc.logout();
            // },
            child: Container(
                width: 32.r,
                height: 32.r,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(authBloc.user!.avatar!) ,fit: BoxFit.contain),
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
          );
    return AppBar(
        title: Text(
          S.of(context).app_name,
          style: TextStyle(
            fontSize: 24.sp,
            color: Theme.of(context).primaryColor,
          ),
        ),
        backgroundColor: Colors.white,
        bottom: _buildTabBar(context),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: avatarWidget,
          )
        ],
      );
  }

  TabBar _buildTabBar(BuildContext context) {
    return TabBar(
      controller: _tabController,
      indicatorColor: Theme.of(context).primaryColor,
      tabs: [
        Tab( 
          height: 60.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.photo_outlined,
                color: Colors.grey,
                size: 28.r,
              ),
              SizedBox(height: 8.h),
              Text(
                'Photos',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600
                ),
              ),
            ],
          ),
        ),
        Tab(
          height: 60.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.folder_copy_outlined,
                color: Colors.grey,
                size: 28.r,
              ),
              SizedBox(height: 8.h),
              Text(
                'Albums',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: TabBarView(
        controller: _tabController,
        children: [
          PhotosPage(),
          Center(
            child: Icon(
              Icons.folder_copy_outlined,
              size: 240.r,
              color: Colors.grey[200],
            )
          ),
        ],
      )
    );
  }

  
}