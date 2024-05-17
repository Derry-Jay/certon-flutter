import '../../models/faq.dart';
import 'package:flutter/material.dart';

class FAQItemWidget extends StatelessWidget {
  final FrequentlyAskedQuestion faq;
  final int index;
  const FAQItemWidget({Key? key, required this.faq, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('${index + 1}. ${faq.question}\n${faq.answer}\n');
  }
}
