import 'hyperlink_text.dart';
import '../../backend/api.dart';
import '../../helpers/helper.dart';
import '../../models/document.dart';
import 'documents_list_widget.dart';
import 'package:flutter/material.dart';

class DocumentItemWidget extends StatelessWidget {
  final Document document;
  const DocumentItemWidget({Key? key, required this.document})
      : super(key: key);
  DocumentsListWidgetState? of(BuildContext context) =>
      context.findAncestorStateOfType<DocumentsListWidgetState>();
  @override
  Widget build(BuildContext context) {
    log(document.docName);
    log(document.type.type);
    final hp = Helper.of(context);
    return Card(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        HyperLinkText(
            text: document.docName,
            onTap: () {
              docs.value = document;
              document.onChange();
              hp.goTo('/document_details', args: document.address);
            }),
        Padding(
            padding:
                EdgeInsets.only(left: hp.width / 20, bottom: hp.height / 50),
            child: Text(document.type.type)),
        // HyperLinkText(
        //     text: 'Request Access Permission',
        //     onTap: () {
        //       // docs.value = document;
        //       // document.onChange();
        //       // hp.goTo('/document_details');
        // }),
      ]),
    );
  }
}
