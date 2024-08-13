import 'package:campus_pro/src/UI/WIDGETS/drawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

class GoToWeb extends StatefulWidget {
  static const routeName = "/Go-To-Web";
  final String? url;
  final String? appBarName;

  const GoToWeb({Key? key, required, this.url, this.appBarName}) : super(key: key);

  @override
  _GoToWebState createState() => _GoToWebState();
}

class _GoToWebState extends State<GoToWeb> {
  getPermission() async {
    await Permission.camera.request();
    await Permission.microphone.request();
  }

  @override
  void initState() {
    getPermission();
    super.initState();
//if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  InAppWebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("${widget.appBarName ?? ""}"),
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
// commonAppBar(context,
//     title: "${widget.appBarName != null ? widget.appBarName : ""}"),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: InAppWebView(
                initialUrlRequest: URLRequest(url: Uri.parse("${widget.url!}")),
                initialOptions: InAppWebViewGroupOptions(
                  android: AndroidInAppWebViewOptions(useHybridComposition: true),
                  crossPlatform: InAppWebViewOptions(
// debuggingEnabled: true,
                      useOnDownloadStart: true),
                ),
                onWebViewCreated: (InAppWebViewController controller) {
                  webViewController = controller;
                },
                onLoadStart: (InAppWebViewController controller, Uri? url) {},
                onLoadStop: (InAppWebViewController controller, Uri? url) async {
                  await controller.evaluateJavascript(
                      source: "window.localStorage.setItem('key', 'localStorage value!')");
// await controller.evaluateJavascript(
//     source: "alert(window.localStorage.getItem('key'))");
                },
                onDownloadStartRequest: (
                  controller,
                  url,
                ) async {
// print("onDownloadStart $url");
                  print("urll ${url.url}");
                  final String _urlFiles = "${url.url}";
                  void _launchURLFiles() async => await canLaunchUrl(Uri.parse(_urlFiles))
                      ? await launchUrl(Uri.parse(_urlFiles))
                      : throw 'Could not launch $_urlFiles';
                  _launchURLFiles();
                },
// onDownloadStart: (controller, url) async {
//   print("onDownloadStart $url");
//   final taskId = await FlutterDownloader.enqueue(
//     url: url.path,
//     savedDir: (await getExternalStorageDirectory())!.path,
//     showNotification:
//         true, // show download progress in status bar (for Android)
//     openFileFromNotification:
//         true, // click on notification to open downloaded file (for Android)
//   );
// },
              ),
            ),
          ],
        ),
      ),
// body:  WebviewScaffold(
//   url: widget.url!,
//   withLocalStorage: true,
//   allowFileURLs: true,
//   withLocalUrl: true,
// ),
    );
  }
}
