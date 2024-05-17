import 'hyperlink_text.dart';
import '../../backend/api.dart';
import '../../helpers/helper.dart';
import 'documents_list_widget.dart';
import '../../models/document.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AllDocumentItemWidget extends StatelessWidget {
  final Document document;
  const AllDocumentItemWidget({Key? key, required this.document})
      : super(key: key);

  DocumentsListWidgetState? of(BuildContext context) =>
      context.findAncestorStateOfType<DocumentsListWidgetState>();

  Widget sheetBuilder(BuildContext context) => ListView.builder(
      itemBuilder: tileBuilder, itemCount: document.files.length);

  Widget tileBuilder(BuildContext context, int index) {
    final hp = Helper.of(context);
    return ListTile(
        title: HyperLinkText(
            text: document.files[index].split('/').last,
            onTap: () {
              hp.goBack(result: document.files[index]);
            }),
        leading: Icon(Icons.description, color: hp.theme.secondaryHeaderColor));
  }

  @override
  Widget build(BuildContext context) {
    final hp = Helper.of(context);
    return Card(
      child: Padding(
          padding: EdgeInsets.only(left: hp.width / 40, top: hp.height / 50),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Name: ${document.docName}', style: hp.textTheme.bodyText2),
            Padding(
                padding: EdgeInsets.symmetric(vertical: hp.height / 64),
                child: Text('Type: ${document.type.type}',
                    style: hp.textTheme.bodyText2)),
            Text('Expiry Date: ${document.expiryDate}',
                style: hp.textTheme.bodyText2),
            SizedBox(
              height: document.files.length * 45,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: document.files.length,
                itemBuilder: (context, index) => GestureDetector(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text('View Document',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: hp.theme.focusColor)),
                      ],
                    ),
                    onTap: () async {
                      if (await launchUrl(
                          Uri.tryParse(document.sharedurl /*+ document.files[index]*/) ?? Uri())) {
                        log('Welcome');
                      }
                    }),
              ),
            ),
            SizedBox(
              height: document.files.length * 45,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: document.files.length,
                itemBuilder: (context, index) => GestureDetector(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text('Download a Copy',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: hp.theme.focusColor)),
                      ],
                    ),
                    onTap: () async {
                      if (document.files.length == 1) {
                        final p = await launchUrl(
                            Uri.tryParse(
                                document.sharedurl /*+  document.files.single*/) ?? Uri());
                        log(p ? 'Hi' : 'Bye');
                      } else {
                        final uri = await showModalBottomSheet<String>(
                                context: context, builder: sheetBuilder) ??
                            '';
                        if (uri.isNotEmpty) {
                          final r = await launchUrl(Uri.tryParse(uri) ?? Uri());
                          if (r) log(uri);
                        }
                      }
                    }),
              ),
            ),
          ])),
    );
  }
}

class AllDocumentItemWidget2 extends StatelessWidget {
  final Document document;
  const AllDocumentItemWidget2({Key? key, required this.document})
      : super(key: key);

  DocumentsListWidgetState? of(BuildContext context) =>
      context.findAncestorStateOfType<DocumentsListWidgetState>();

  Widget sheetBuilder(BuildContext context) => ListView.builder(
      itemBuilder: tileBuilder, itemCount: document.files.length);

  Widget tileBuilder(BuildContext context, int index) {
    final hp = Helper.of(context);
    return ListTile(
        title: HyperLinkText(
            text: document.files[index].split('/').last,
            onTap: () {
              hp.goBack(result: document.files[index]);
            }),
        leading: Icon(Icons.description, color: hp.theme.secondaryHeaderColor));
  }

  @override
  Widget build(BuildContext context) {
    final hp = Helper.of(context);
    return Card(
      child: Padding(
          padding: EdgeInsets.only(left: hp.width / 40, top: hp.height / 50),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Name: ${document.docName}', style: hp.textTheme.bodyText2),
            Padding(
                padding: EdgeInsets.symmetric(vertical: hp.height / 64),
                child: Text('Type: ${document.type.type}',
                    style: hp.textTheme.bodyText2)),
            Text('Expiry Date: ${document.expiryDate}',
                style: hp.textTheme.bodyText2),
            Row(
              children: [
                HyperLinkText(
                    text: 'View Document',
                    onTap: () {
                      docs.value = document;
                      document.onChange();
                      hp.goTo('/document_details', args: document.address);
                    }),
                HyperLinkText(
                    text: 'Download a copy',
                    onTap: () async {
                      if (document.files.length == 1) {
                        final p = await launchUrl(
                            Uri.tryParse(
                                document.sharedurl /*+ document.files.single*/) ?? Uri());
                        log(p ? 'Hi' : 'Bye');
                      } else {
                        final uri = await showModalBottomSheet<String>(
                                context: context, builder: sheetBuilder) ??
                            '';
                        if (uri.isNotEmpty) {
                          final r = await launchUrl(Uri.tryParse(uri) ?? Uri());
                          if (r) log(uri);
                        }
                      }
                    })
              ],
            )
          ])),
    );
  }

  // Widget tableStructure() {

  //   return Text('dfas');
  // }

}
