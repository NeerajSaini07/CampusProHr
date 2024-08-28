import 'package:campus_pro/src/DATA/MODELS/userSchoolDetailModel.dart';
import 'package:campus_pro/src/drawerImages.dart';
import 'package:campus_pro/src/DATA/MODELS/drawerModel.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../CONSTANTS/stringConstants.dart';
import '../../DATA/userUtils.dart';
import '../../UTILS/appImages.dart';
import '../../globalBlocProvidersFile.dart';
import '../PAGES/log_in_screen.dart';
import 'package:campus_pro/src/drawerRouter.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:campus_pro/src/gotoWeb.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  String? userName = "";
  String? userSchool = "";
  String? userImage = "";
  String? currentType = "";

  // bool showExpansion = false;
  List<bool>? showExpansion = [];

  String? userType = "";

  int selected = 0;

  getUserType() async {
    final userData = await UserUtils.userTypeFromCache();
    setState(() {
      userType = userData!.ouserType;
    });
  }

  @override
  void initState() {
    WebView.platform = SurfaceAndroidWebView();
    getUserData();
    // getDrawerItems();
    super.initState();
  }

  getUserData() async {
    final accountTypeData = await UserUtils.accountTypeFromCache();
    print("$accountTypeData  useerrrtypeeeeeee");
    setState(() {
      currentType = accountTypeData!.userType;
    });
    if (accountTypeData!.userType.toLowerCase() == "s" ||
        accountTypeData.userType.toLowerCase() == "f") {
      final userData = await UserUtils.stuInfoDataFromCache();
      setState(() {
        userName = userData!.stName;
        userImage = userData.imageUrl;
      });
    } else {
      // final empData = await UserUtils.empInfoDataFromCache();
      // final userData = await UserUtils.userTypeFromCache();
      setState(() {
        userName = accountTypeData.employName;
        userSchool = accountTypeData.companyName;
        userImage = "";
      });
    }
    // print("$userType   userTypreeeeeee");
  }

  logout() async {
    UserUtils.logout().then((value) {
      Navigator.pushNamedAndRemoveUntil(
          context, LogInScreen.routeName, (route) => false);
    });
  }

  getDrawerItems() async {
    final userData = await UserUtils.userTypeFromCache();
    final drawerData = {
      "OrgId": userData!.organizationId!,
      "SchoolId": userData.schoolId!,
      "ID": "0",
      "UserType": userData.ouserType!,
      // "OrgId": "9998",
      // "SchoolId": "1",
      // "ID": "0",
      // "UserType": "S",
    };
    // context.read<DrawerCubit>().drawerCubitCall(drawerData); //TODO
  }

  gotoWeb({String? url, String? name}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.accountTypeFromCache();
    // final ids = await UserUtils.stuInfoDataFromCache();

    final sendingData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "CompanyId": userData.companyId,
      "YearId": userData.currentSessionId,
      "AppUrl": userData.appUrl,
      "PageUrl": url,
      "EmpId": userData.employId,
      "UserType": userData.userType,
      "Flag": "F",
      "PageName": name,
      //"ClassId": ids!.classId,
      //"SectionId": ids.classSectionId,
      //"StreamId": ids.streamId,
      //"YearId": ids.yearId,
      //"LogoImgPath": userData.logoImgPath,
      //https://app.campuspro.in/images/demo.png
    };
    // print("$url urllllllllll");
    // print("Sending data for goto web $sendingData");

    context.read<GotoWebAppCubit>().gotoWebAppCubitCall(sendingData);
  }

  Widget buildGotoSite(BuildContext context, String? gotoSiteUrl) {
    return WebView(
      javascriptMode: JavascriptMode.unrestricted,
      initialUrl: gotoSiteUrl,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      child: Drawer(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: MultiBlocListener(
            listeners: [
              BlocListener<GotoWebAppCubit, GotoWebAppState>(
                  listener: (context, state) {
                if (state is GotoWebAppLoadSuccess) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return GoToWeb(
                          url: state.url.split(",,")[0],
                          appBarName: state.url.split(",,")[1],
                        );
                      },
                    ),
                  );

                  ///
                }
                if (state is GotoWebAppLoadFail) {
                  if (state.failReason == "false") {
                    UserUtils.unauthorizedUser(context);
                  }
                }
              }),
            ],
            child: SafeArea(
              child: BlocConsumer<DrawerCubit, DrawerState>(
                listener: (context, state) {
                  if (state is DrawerLoadFail) {
                    if (state.failReason == "false") {
                      UserUtils.unauthorizedUser(context);
                    }
                  }
                  // if (state is DrawerLoadSuccess) {
                  //   print("drawerItem ${state.drawerItems.length}");
                  //   state.drawerItems.forEach((element) {
                  //     setState(() {
                  //       showExpansion!.add(false);
                  //     });
                  //   });
                  // }
                },
                builder: (context, state) {
                  if (state is DrawerLoadSuccess) {
                    return buildDrawerItems(context,
                        drawerItem: state.drawerItems);
                  } else if (state is DrawerLoadFail) {
                    return Center(child: Text(SOMETHING_WENT_WRONG));
                    // return Center(child: Text(state.failReason));
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                          backgroundColor: Colors.white),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  ScrollController _controller = ScrollController(keepScrollOffset: false);

  Column buildDrawerItems(BuildContext context,
      {List<DrawerModel>? drawerItem}) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          // color: Theme.of(context).backgroundColor,
          color: Colors.black,
          child: Transform.translate(
            offset: Offset(-16, 0),
            child: ListTile(
              leading: currentType!.toLowerCase() == "s" ||
                      currentType!.toLowerCase() == "f"
                  ? InkWell(
                      onTap: () async {
                        final userType = await UserUtils.userTypeFromCache();
                        if (userType!.ouserType!.toLowerCase() == "s" ||
                            userType.ouserType!.toLowerCase() == "f")
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return BlocProvider<ProfileStudentCubit>(
                              create: (_) => ProfileStudentCubit(
                                  ProfileStudentRepository(
                                      ProfileStudentApi())),
                              // child: ProfileStudent(),
                            );
                          }));
                        // Navigator.pushNamed(
                        //     context, ProfileStudent.routeName);
                      },
                      child: Transform.translate(
                        offset: Offset(-10, 0),
                        child: Stack(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 48,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 46,
                                backgroundImage: NetworkImage(userImage!),
                                // backgroundImage: AssetImage(AppImages.dummyImage),
                                onBackgroundImageError: (error, stackTrace) =>
                                    AssetImage(AppImages.dummyImage),
                              ),
                            ),
                            Positioned(
                              right: 20,
                              bottom: 0,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 10,
                                child: Icon(
                                  Icons.photo_camera,
                                  size: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Text(""),
              title: Transform.translate(
                offset: Offset(-30, 0),
                child: Text(
                  userName!,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              subtitle: currentType!.toLowerCase() == "s" ||
                      currentType!.toLowerCase() == "f"
                  ? BlocBuilder<UserSchoolDetailCubit, UserSchoolDetailState>(
                      builder: (context, state) {
                        if (state is UserSchoolDetailLoadInProgress) {
                          return Text("");
                        } else if (state is UserSchoolDetailLoadSuccess) {
                          return buildSchoolName(context,
                              schoolData: state.schoolData);
                        } else if (state is UserSchoolDetailLoadFail) {
                          return Text("");
                        } else {
                          return Text("");
                        }
                      },
                    )
                  : Transform.translate(
                      offset: Offset(-30, 0),
                      child: Text(
                        userSchool!,
                        style: GoogleFonts.quicksand(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white60),
                      ),
                    ),
            ),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: Expanded(
                  child: ListView.separated(
                      controller: _controller,
                      key: Key('Selected ${selected.toString()}'),
                      separatorBuilder: (context, index) => Divider(height: 0),
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: drawerItem!.length,
                      itemBuilder: (context, i) {
                        var item = drawerItem[i];
                        // print("${item.subMenu}  haaaannn aya");
                        if (item.menuID != "44" &&
                            item.menuID != "45" &&
                            item.menuID != "46" &&
                            item.menuID != "47") {
                          if (item.subMenu!.isNotEmpty) {
                            print("${item.subMenu}  haaaannn aya");
                            return buildExpansionTile(item, i);
                          } else {
                            print("object123");
                            return buildListTile(item, i);
                          }
                        } else {
                          return Container();
                        }
                      }),
                ),
              ),
            ],
          ),
        ),
        Divider(),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: Theme.of(context).colorScheme.background,
                    width: 8.0)),
          ),
          child: Center(
            child: Column(
              children: [
                // Text('Powered by Campus Pro ● V 1.0.0',
                Text('Powered by CampusPro',
                    // Text('Powered by $schoolName',
                    textScaleFactor: 1.0,
                    style: TextStyle(
                        fontSize: 11,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600)),
                SizedBox(height: 8),
                InkWell(
                  onTap: () async {
                    await UserUtils.logout().then((value) =>
                        Navigator.pushNamedAndRemoveUntil(
                            context, LogInScreen.routeName, (route) => false));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade300),
                        child: Icon(
                          Icons.logout,
                          color: Colors.red[400],
                          size: 20,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text('Logout',
                          textScaleFactor: 1.0,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red[400],
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Transform buildSchoolName(BuildContext context,
      {UserSchoolDetailModel? schoolData}) {
    return Transform.translate(
      offset: Offset(-30, 0),
      child: Text(
        schoolData!.schoolName!,
        style: GoogleFonts.quicksand(
            fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.white60),
      ),
    );
  }

  ListTile buildListTile(DrawerModel item, int i) {
    return ListTile(
        // leading: item.androidIcon != null && item.androidIcon != ""
        //     ? Image.network(item.androidIcon!,
        //         height: 24,
        //         width: 24,
        //         errorBuilder: (context, error, stackTrace) => Image.asset(
        //               AppImages.defaultDrawerImage,
        //               height: 24,
        //               width: 24,
        //             ))
        //     : Image.asset(
        //         AppImages.defaultDrawerImage,
        //         height: 24,
        //         width: 24,
        //       ),
        leading: Image.asset(
          DrawerImages.getImage(item.menuName!),
          height: 26,
          width: 26,
        ),
        title: Row(
          children: [
            Flexible(
              child: Text(
                item.menuName!,
                // "${item.menuName!} - ${item.menuID!}",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor),
              ),
            ),
          ],
        ),
        //Todo:Add condition soo that it can open in web view or in simple in our app.
        onTap: () {
          print("${item.menuFlag} hellcoooo F");
          print("${userType!} helloooo ");
          print("${item.menuURL} helloooo ");

          if (item.menuFlag == "F") {
            // print("${item.menuFlag!} helloooo Not ");

            // onSelected(context, userType: item.userType1, menuId: item.menuID);
          } else {
            // print("${userType!} helloooo Not ");

            if (userType!.toLowerCase() == "s") {
              gotoWeb(url: item.menuURL, name: item.menuName);
            } else if (userType!.toLowerCase() == "e") {
              gotoWeb(url: item.menuURL, name: item.menuName);
            } else if (userType!.toLowerCase() == "a") {
              gotoWeb(url: item.menuURL, name: item.menuName);
            } else if (userType!.toLowerCase() == "m") {
              gotoWeb(url: item.menuURL, name: item.menuName);
            } else if (userType!.toLowerCase() == "c") {
              gotoWeb(url: item.menuURL, name: item.menuName);
            } else if (userType!.toLowerCase() == "f") {
              gotoWeb(url: item.menuURL, name: item.menuName);
            } else {
              print("elseeeeeee");
              gotoWeb(url: item.menuURL, name: item.menuName);
            }
          }
        });
  }

  ExpansionTile buildExpansionTile(DrawerModel item, int i) {
    print("selected $selected");
    return ExpansionTile(
        key: Key(i.toString()),
        initiallyExpanded: i == selected,
        trailing: selected != i
            ? Icon(
                Icons.keyboard_arrow_right,
                color: Theme.of(context).primaryColor,
              )
            : Icon(
                Icons.keyboard_arrow_down,
                color: Theme.of(context).primaryColor,
              ),
        onExpansionChanged: ((state) {
          var posi = _controller.position.pixels;
          if (state) {
            setState(() {
              selected = i;
            });
          } else {
            setState(() {
              selected = -1;
            });
          }
          print("State : $state");
          Future.delayed(Duration(milliseconds: 300), () {
            _controller.animateTo(
                selected > 0 ? double.parse((posi).toString()) : 0,
                duration: Duration(milliseconds: 600),
                curve: Curves.easeIn);
          });
        }),
        collapsedIconColor: Colors.black87,
        iconColor: Colors.black87,
        backgroundColor: Colors.black12,
        textColor: Colors.orange,
        // leading: item.androidIcon != null && item.androidIcon != ""
        //     ? Image.network(
        //         item.androidIcon!,
        //         height: 24,
        //         width: 24,
        //         errorBuilder: (context, error, stackTrace) => Icon(
        //           Icons.disabled_by_default,
        //           color: Colors.black,
        //         ),
        //       )
        //     : Icon(
        //         Icons.disabled_by_default,
        //       ),
        leading: Image.asset(
          DrawerImages.getImage(item.menuName!),
          height: 26,
          width: 26,
        ),
        title: Row(
          children: [
            Flexible(
              child: Text(
                item.menuName!,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor),
              ),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: item.subMenu!.length,
              itemBuilder: (context, i) {
                var subitem = item.subMenu![i];
                return Container(
                  child: ListTile(
                      // leading: subitem.subAndroidIcon != null &&
                      //         subitem.subAndroidIcon != ""
                      //     ? Image.network(
                      //         subitem.subAndroidIcon!,
                      //         height: 24,
                      //         width: 24,
                      //         errorBuilder: (context, error, stackTrace) =>
                      //             Image.asset(
                      //           AppImages.defaultDrawerImage,
                      //           height: 24,
                      //           width: 24,
                      //         ),
                      //       )
                      //     : Image.asset(AppImages.defaultDrawerImage),
                      leading: Image.asset(
                        DrawerImages.getImage(subitem.subMenuName!.trim()),
                        height: 26,
                        width: 26,
                      ),
                      title: Row(
                        children: [
                          Flexible(
                            child: Text(
                              subitem.subMenuName!,
                              // subitem.subMenuName! + "- ${subitem.subMenuID}",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      //Todo:Add condition soo that it can open in web view or in simple in our app.
                      onTap: () {
                        print("${subitem.navigateURL} goto sir");
                        if (subitem.subMenuFlag != "F") {
                          if (userType!.toLowerCase() == "s") {
                            gotoWeb(
                                url: subitem.navigateURL,
                                name: subitem.subMenuName);
                          } else if (userType!.toLowerCase() == "e") {
                            gotoWeb(
                                url: subitem.navigateURL,
                                name: subitem.subMenuName);
                          } else if (userType!.toLowerCase() == "a") {
                            gotoWeb(
                                url: subitem.navigateURL,
                                name: subitem.subMenuName);
                          } else if (userType!.toLowerCase() == "m") {
                            gotoWeb(
                                url: subitem.navigateURL,
                                name: subitem.subMenuName);
                          } else if (userType!.toLowerCase() == "c") {
                            gotoWeb(
                                url: subitem.navigateURL,
                                name: subitem.subMenuName);
                          } else if (userType!.toLowerCase() == "f") {
                            gotoWeb(
                                url: subitem.navigateURL,
                                name: subitem.subMenuName);
                          } else {
                            gotoWeb(
                                url: subitem.navigateURL,
                                name: subitem.subMenuName);
                          }
                        } else {
                          // onSelected(context,
                          //     userType: subitem.userType1,
                          //     menuId: item.menuID,
                          //     subMenuId: subitem.subMenuID);
                        }

                        // DrawerRouter.onSelected(context,
                        //   userType: subitem.userType1,
                        //   menuId: item.menuID,
                        //   subMenuId: subitem.subMenuID);
                      }),
                );
              },
            ),
          ),
        ]);
  }

  Text buildText({String? title}) {
    return Text(
      title ?? "",
      textScaleFactor: 1.0,
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        // decoration: TextDecoration.underline,
      ),
    );
  }

  Padding buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Divider(color: Colors.grey),
    );
  }
}

class DrawerItem {
  String? itemName;
  String? icon;

  DrawerItem({this.itemName, this.icon});
}

// MediaQuery.removePadding(
//                 context: context,
//                 removeTop: true,
//                 child: Expanded(
//                   child: ListView.builder(
//                       shrinkWrap: true,
//                       physics: AlwaysScrollableScrollPhysics(),
//                       itemCount: drawerItem!.length,
//                       // separatorBuilder: (BuildContext context, int index) =>
//                       //     buildDivider(),
//                       itemBuilder: (context, i) {
//                         // var count = drawerItem
//                         //     .where((e) => e.menuID == "2")
//                         //     .toList()
//                         //     .length;
//                         // print("count - $count");
//                         if (drawerItem[i] != drawerItem.first) {
//                           if (drawerItem[i].menuID !=
//                               drawerItem[i - 1].menuID) {
//                             return buildListTile(drawerItem, i);
//                           } else {
//                             return buildExpansionTile(drawerItem, i);
//                           }
//                         } else {
//                           return buildListTile(drawerItem, i);
//                         }
//                       }),
//                 ),
//               ),
