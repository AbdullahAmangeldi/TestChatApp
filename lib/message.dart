
class Message {
  Message(this.message, this.dateSent, this.isRead, this.isSender, {this.isDivider = false});
  final String message;
  final DateTime? dateSent;
  final bool isRead;
  final bool isSender;
  final bool isDivider;


}