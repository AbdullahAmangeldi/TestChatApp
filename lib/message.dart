import 'dart:io';
class Message {
  Message(this.message, this.dateSent, this.isRead, this.isSender, {this.isDivider = false, this.imageFile});
  final String message;
  final DateTime? dateSent;
  final bool isRead;
  final bool isSender;
  final bool isDivider;
  final File? imageFile;

  Message.divider(

      {

        required this.message,
        this.dateSent ,
        this.isRead = false,
        this.isSender = false,
        this.isDivider = true,
        this.imageFile
        });

}