import 'faq.dart';
import 'reply.dart';

class FAQBase {
  final Reply reply;
  final List<FrequentlyAskedQuestion> faqs;
  FAQBase(this.reply, this.faqs);
  factory FAQBase.fromMap(Map<String, dynamic> json) {
    final data = List<Map<String, dynamic>>.from(
        json['mobilequestion'] ?? <Map<String, dynamic>>[]);
    return FAQBase(
        Reply.fromMap(json),
        json['mobilequestion'] == null || data.isEmpty
            ? <FrequentlyAskedQuestion>[]
            : data.map(FrequentlyAskedQuestion.fromMap).toList());
  }
}
