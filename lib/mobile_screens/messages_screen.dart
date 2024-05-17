import 'dart:convert';
import '../helpers/helper.dart';
import '../widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class MyScreen extends StatelessWidget {
  const MyScreen({Key? key}) : super(key: key);

  Widget getWidget(Stream<RemoteMessage>? e) {
    Widget itemBuilder(
        BuildContext context, AsyncSnapshot<RemoteMessage> message) {
      return SelectableText(message.hasData && !message.hasError
          ? jsonEncode(message.data?.data)
          : 'Hi');
    }

    try {
      return StreamBuilder<RemoteMessage>(builder: itemBuilder, stream: e);
    } catch (e) {
      sendAppLog(e);
      return const EmptyWidget();
    }
  }

  Widget titleBuilder(BuildContext context, AsyncSnapshot<String> text) {
    try {
      return text.hasData && !text.hasError
          ? SelectableText(text.data ?? '')
          : const EmptyWidget();
    } catch (e) {
      sendAppLog(e);
      return const EmptyWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    final hp = Helper.of(context);
    return SafeArea(
        child: Scaffold(
            body: SizedBox(
                height: hp.height,
                width: hp.width,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Stream<RemoteMessage>?>[rms1, rms2]
                        .map<Widget>(getWidget)
                        .toList())),
            appBar: AppBar(
                title: StreamBuilder<String>(
                    initialData: '',
                    builder: titleBuilder,
                    stream: FirebaseMessaging.instance.onTokenRefresh))));
  }
}
