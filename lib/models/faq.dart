class FrequentlyAskedQuestion {
  final String question, answer;
  FrequentlyAskedQuestion(this.question, this.answer);
  factory FrequentlyAskedQuestion.fromMap(Map<String, dynamic> json) {
    return FrequentlyAskedQuestion(json['questions'], json['answers']);
  }
}
