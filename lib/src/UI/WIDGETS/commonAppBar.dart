import 'package:campus_pro/src/DATA/MODELS/studentInfoModel.dart';
import 'package:campus_pro/src/UTILS/appImages.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../globalBlocProvidersFile.dart';

AppBar commonAppBar(
  BuildContext context, {
  String? title,
  Widget? icon,
  Widget? icon2,
  Color? shadowColor,
  bool? centerTitle,
  TextStyle? style,
  Widget? leadingIcon,
  Color? backgroundColor,
  bool automaticallyImplyLeading = true,
  GlobalKey<ScaffoldState>? scaffoldKey,
  bool? showMenuIcon = false,
     VoidCallback? onTap,
}) {
  return AppBar(
    shadowColor: shadowColor ?? null,
    backgroundColor: backgroundColor ?? null,
    automaticallyImplyLeading: automaticallyImplyLeading,
    // backwardsCompatibility: true,
    systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
    centerTitle: centerTitle ?? null,
    leading: leadingIcon != null
        ? leadingIcon
        : !showMenuIcon!
            ? InkResponse(
                onTap: onTap,
                child: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
              )
            : GestureDetector(
                onTap: () {
                  print("drawer tapped");
                  scaffoldKey!.currentState!.openDrawer();
                },
                child: buildLeadingIcon(context),
              ),
    title: Text(title!,
        style: style ??
            GoogleFonts.quicksand(
                fontWeight: FontWeight.bold, color: Colors.white)),
    actions: [
      icon ?? Container(),
      icon2 ?? Container(),
    ],
  );
}

buildLeadingIcon(BuildContext context) {
  return BlocProvider<EmployeeInfoCubit>(
    create: (_) => EmployeeInfoCubit(EmployeeInfoRepository(EmployeeInfoApi())),
    child: BlocProvider<StudentInfoCubit>(
      create: (_) => StudentInfoCubit(StudentInfoRepository(StudentInfoApi())),
      child: Builder(
        builder: (BuildContext context) {
          return MultiBlocListener(
            listeners: [
              BlocListener<StudentInfoCubit, StudentInfoState>(
                listener: (context, state) {
                  if (state is StudentInfoLoadSuccess) {
                    buildIcon(state.studentInfoData.imageUrl!);
                    // setState(() {
                    // });
                  }
                },
              ),
              BlocListener<EmployeeInfoCubit, EmployeeInfoState>(
                listener: (context, state) {
                  if (state is EmployeeInfoLoadSuccess) {
                    buildIcon("");
                    // setState(() {
                    // });
                  }
                },
              )
            ],
            child: Icon(
              Icons.dehaze,
              color: Colors.white,
            ),
          );
        },
      ),
    ),
  );
}

Widget buildIcon(String? imageUrl) {
  return Stack(
    children: [
      Positioned(
        top: 12,
        left: 12,
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 20,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 20,
            backgroundImage: NetworkImage(imageUrl!),
            onBackgroundImageError: (error, stackTrace) =>
                AssetImage(AppImages.dummyImage),
          ),
        ),
      ),
      Positioned(
        right: 0,
        bottom: 0,
        child: CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 9,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 8,
            child: Icon(
              Icons.dehaze,
              size: 10,
              color: Colors.black,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget buildCustomIcon(BuildContext context, {StudentInfoModel? studentInfo}) {
  return Padding(
    padding: const EdgeInsets.only(left: 12, top: 12),
    child: Stack(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 20,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 20,
            backgroundImage: NetworkImage(studentInfo!.imageUrl!),
            onBackgroundImageError: (error, stackTrace) =>
                AssetImage(AppImages.dummyImage),
          ),
        ),
        Positioned(
          right: 4,
          bottom: 2,
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 9,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 8,
              child: Icon(
                Icons.dehaze,
                size: 10,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
