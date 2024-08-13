import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/CONSTANTS/themeData.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/header_token_api.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/header_token_cubit/header_token_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/models.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/header_token_repository.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/PAGES/dashboard_web.dart';
import 'package:campus_pro/src/UI/PAGES/restrictionPage.dart';
import 'package:campus_pro/src/UI/PAGES/log_in_screen.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:campus_pro/src/globalBlocProvidersFile.dart';

class AccountTypeScreen extends StatefulWidget {
  static const routeName = "/user-type";

  @override
  _AccountTypeScreenState createState() => _AccountTypeScreenState();
}

class _AccountTypeScreenState extends State<AccountTypeScreen> {
  int _currentIndex = -1;
  String dashboardType = "f";
  String? flag = "";
  String? url = "";

  @override
  void initState() {
    super.initState();
    getAccountTypes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(toolbarHeight: 0.0, backgroundColor: Colors.white),
      body: MultiBlocListener(
        listeners: [
          BlocListener<FcmTokenStoreCubit, FcmTokenStoreState>(
              listener: (context, state) {
            if (state is FcmTokenStoreLoadFail) {
              removeAccountTypesData();
            }
          }),
          BlocListener<CheckAppRestrictionCubit, CheckAppRestrictionState>(
            listener: (ctx, state) {
              if (state is CheckAppRestrictionLoadSuccess) {
                if (state.status) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return BlocProvider<AppConfigSettingCubit>(
                          create: (_) => AppConfigSettingCubit(
                            (AppConfigSettingRepository(AppConfigSettingApi())),
                          ),
                          child: BlocProvider<RestrictionPageCubit>(
                            create: (_) => RestrictionPageCubit(
                              RestrictionPageRepository(RestrictionPageApi()),
                            ),
                            child: RestrictionPage(),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  navigateToDashboard(ctx);
                }
              }
              if (state is CheckAppRestrictionLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(ctx);
                }
              }
            },
          ),
        ],
        child: Card(
          elevation: 10,
          color: Colors.white,
          surfaceTintColor: Colors.white,
          margin: EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/account_type_bg.jpg'),
                fit: BoxFit.fitHeight,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                buildTopBar(context),
                SizedBox(height: 10),
                BlocConsumer<AccountTypeCubit, AccountTypeState>(
                  listener: (ctx, state) {
                    if (state is AccountTypeLoadFail) {
                      ScaffoldMessenger.of(ctx).showSnackBar(
                        commonSnackBar(
                            title: '${state.failReason}',
                            duration: Duration(seconds: 1)),
                      );
                    }
                  },
                  builder: (ctx, state) {
                    if (state is AccountTypeLoadSuccess) {
                      return buildUserTypeBody(ctx,
                          accountTypes: state.userTypeList);
                    } else if (state is AccountTypeLoadFail) {
                      if (state.failReason == "App_Under_Maintenance") {
                        return Expanded(
                          child: Container(
                            child: Center(
                              child: Text("App Under Maintenance"),
                            ),
                          ),
                        );
                      } else {
                        return Expanded(
                          child: Container(
                            child: Center(
                              child: Text(
                                NO_RECORD_FOUND,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                            ),
                          ),
                        );
                      }
                    } else {
                      return Expanded(
                          child: Container(
                              child:
                                  Center(child: CircularProgressIndicator())));
                    }
                  },
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getAccountTypes() async {
    final uid = await UserUtils.idFromCache();
    final numberPass = await UserUtils.phoneNumberPassFromCache();

    print("number pass $numberPass");

    final data = {
      "OUserId": uid!,
      "MobileNo": numberPass!.split(",")[0].trim(),
      "Password": numberPass.split(",")[1].trim(),
    };

    print("sending data for accountTypes $data");

    context.read<AccountTypeCubit>().accountTypeCubitCall(data);
  }

  void removeAccountTypesData() async =>
      await UserUtils.removeAccountTypesData();

  navigateToDashboard(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return BlocProvider<StudentInfoCubit>(
            create: (_) =>
                StudentInfoCubit(StudentInfoRepository(StudentInfoApi())),
            child: BlocProvider<DrawerCubit>(
              create: (_) => DrawerCubit(DrawerRepository(DrawerApi())),
              child: BlocProvider<NotifyCounterCubit>(
                create: (_) => NotifyCounterCubit(
                    NotifyCounterRepository(NotifyCounterApi())),
                // child: flag?.toLowerCase() == "f" ? Dashboard(userType: userType) : DashboardWeb(url: url),
                child: BlocProvider<HeaderTokenCubit>(
                  create: (_) =>
                      HeaderTokenCubit(HeaderTokenRepository(HeaderTokenApi())),
                  // child: flag?.toLowerCase() == "f" ? Dashboard(userType: userType) : DashboardWeb(url: url),
                  child: DashboardWeb(url: url),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _onRefresh() async => await Future.delayed(Duration(milliseconds: 1000))
      .then((value) => getAccountTypes());

  Widget buildUserTypeBody(BuildContext context,
      {List<AccountType>? accountTypes}) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () => _onRefresh(),
        child: accountTypes!.length > 0
            ? ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: accountTypes.length + 1,
                itemBuilder: (BuildContext context, int i) {
                  if (i == accountTypes.length) {
                    return Image.asset(
                      'assets/images/logo_rugerp.png',
                      width: 200,
                      height: 100,
                    );
                  }
                  var item = accountTypes[i];
                  return InkWell(
                    onTap: () async {
                      flag = item.flag;
                      url = item.url;
                      setState(() => _currentIndex = i);
                      await UserUtils.cacheAccountTypeData(item);
                      navigateToDashboard(context);
                    },
                    child: Card(
                      elevation: 10,
                      color: Colors.white,
                      surfaceTintColor: Colors.white,
                      margin: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: MediaQuery.of(context).size.width * .05,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0.0, vertical: 10.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                item.userType == 'E'
                                    ? 'assets/images/employee_role.png'
                                    : item.userType == 'A'
                                        ? 'assets/images/admin.png'
                                        : item.userType == 'M'
                                            ? 'assets/images/app_manager.png'
                                            : 'assets/images/logo_rugerp.png',
                                width: MediaQuery.of(context).size.width * .3,
                                height: 150,
                              ),
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * .05),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .45,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.employName,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 2,
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    item.userName,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    item.companyName,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: Text(
                  "$NO_RECORD_FOUND",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
      ),
    );
  }

  Container buildTopBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Choose Profile",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w900,
              color: primaryColor,
              fontFamily: 'OpenSans',
            ),
          ),
          IconButton(
            onPressed: () async {
              await UserUtils.logout().then((value) =>
                  Navigator.pushNamedAndRemoveUntil(
                      context, LogInScreen.routeName, (route) => false));
            },
            icon: Icon(Icons.logout, color: primaryColor),
          ),
        ],
      ),
    );
  }
}
