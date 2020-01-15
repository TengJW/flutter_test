import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends StatelessWidget {
  final baseUrl;
  final title;
  WebViewController _webViewController;

  MyWebView(this.baseUrl, {Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('baseUrl=$baseUrl   title=$title ');
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(fontSize: 15),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: new WebView(
        initialUrl: baseUrl,
        javascriptMode: JavascriptMode.unrestricted,
        javascriptChannels: <JavascriptChannel>[
          _toasterJavascriptChannel(context),
        ].toSet(),
        onWebViewCreated: (WebViewController webViewController) {
          // 在WebView创建完成后会产生一个 webViewController
          _webViewController = webViewController;
        },
        navigationDelegate: (NavigationRequest request) {
          // 判断URL  拦截URL
          if (request.url.startsWith('https://www.baidu.com')) {
            // 做一些事情
            // 阻止进入登录页面
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
        onPageFinished:(_){
          _webViewController.evaluateJavascript("Toaster.postMessage('...');");
        } ,
      ),
    );
  }

  //JS调用Flutter 定义方法
  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });

    // JS调用方法
    //  Toaster.postMessage('...');
  }

//Flutter调用JS
// 之后可以调用 _webViewController 的 evaluateJavascript 属性来注入JS
//  _webViewController.evaluateJavascript("Toaster.postMessage('...');");

}
