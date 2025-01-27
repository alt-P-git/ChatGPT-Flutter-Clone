class Chat {
  String? message;
  String type;
  List<String> attachments;

  Chat({
    this.message,
    required this.type,
    this.attachments = const [],
  });
}
