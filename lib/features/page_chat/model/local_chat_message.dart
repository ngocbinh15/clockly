class LocalChatMessage {
  final String text;
  final bool isSender;
  final bool isTaskCard;
  final Map<String, dynamic>? taskData;

  LocalChatMessage({
    required this.text,
    required this.isSender,
    this.isTaskCard = false,
    this.taskData,
  });
}
