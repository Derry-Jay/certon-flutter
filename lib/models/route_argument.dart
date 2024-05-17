class RouteArgument {
  final int? id;
  final String? tag, content;
  final dynamic params;
  RouteArgument({this.id, this.tag, this.content, this.params});

  @override
  String toString() {
    // TODO: implement toString
    return 'ID: $id, Tag: $tag, Content: $content, Params: $params';
  }
}
