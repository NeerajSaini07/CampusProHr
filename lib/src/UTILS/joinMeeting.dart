import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/userTypeModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class JoinMeeting {
  checkPlatform({String? meetingSubject, String? meetingId}) async {
    final stuData = await UserUtils.stuInfoDataFromCache();
    final userTypeData = await UserUtils.userTypeFromCache();
    final meetingPlatFormId = await getPlatformId(userTypeData);
    final String? path;

    //TODO - use dynamic Domain name
    final String? domainName = 'https://app.campuspro.in';
    try {
      if (meetingPlatFormId == '0') {
        //Creating Path Manually to View in App
        // path = domainName! + "/JoinMeeting.aspx?MID=" + meetingId!;
        path = meetingSubject!.split("\r\n")[1];
        print('meeting manual path $path');
        // print("${meetingSubject.split("\n")[1]}");
      } else {
        //Use Real Path to view in Original Meeting Platform
        path = meetingSubject!.split('\r\n')[1];
        print('meeting original path $path');
      }
      _launchMeetingPlatform(path);
    } catch (e) {
      toast(SOMETHING_WENT_WRONG);
      print('joinMeeting Error : $e');
    }
  }

  Future<String?> getPlatformId(UserTypeModel? userTypeData) async {
    final String? platFormId;
    if (userTypeData!.ouserType!.toLowerCase() != 's') {
      platFormId = userTypeData.empJoinOnPlatformApp == ""
          ? "0"
          : userTypeData.empJoinOnPlatformApp;
      return platFormId;
    } else {
      platFormId = userTypeData.stuJoinOnPlatformApp == ""
          ? "0"
          : userTypeData.stuJoinOnPlatformApp;
      return platFormId;
    }
  }

  Future<void> _launchMeetingPlatform(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
