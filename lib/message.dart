import 'dart:io';

class Message {
  Message(this.message, this.dateSent, this.isRead, this.isSender,
      {this.imageFile, this.isDivider = false, this.voiceFile});

  final String message;
  final DateTime? dateSent;
  final bool isRead;
  final bool isSender;
  final File? imageFile;
  final bool isDivider;
  final File? voiceFile;

  Message.divider(

      {

        required this.message,
        this.dateSent ,
        this.isRead = false,
        this.isSender = false,
        this.isDivider = true,
        this.imageFile,
        this.voiceFile});
}
