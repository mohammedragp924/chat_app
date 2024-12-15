import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/pages/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scholar_chat/widgets/chat_buble.dart';
import 'package:scholar_chat/models/message_model.dart';
import 'package:scholar_chat/widgets/custom_title.dart';

class ChatPage extends StatefulWidget {
  static String id = 'ChatPage';

  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ScrollController _controller = ScrollController();
  final CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessageCollections);
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)?.settings.arguments as String?;
    if (email == null) {
      return const Scaffold(
        body: Center(
          child: Text('No email provided'),
        ),
      );
    }

    return StreamBuilder<QuerySnapshot>(
      stream: messages
          .orderBy(
            kCreatedAt,
            descending: true,
          )
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (var doc in snapshot.data!.docs) {
            messagesList.add(Message.fromJson(doc));
          }
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 40,
              backgroundColor: kPrimaryColor,
              title: titleMethod(),
              centerTitle: true,
              automaticallyImplyLeading: false,
              leading: InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    LoginPage.id,
                    arguments: email,
                  );
                },
                child: const Icon(
                  Icons.arrow_back,
                  size: 24,
                  color: Colors.white,
                ),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _controller,
                    reverse: true,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      bool isOwner = messagesList[index].id == email;

                      return GestureDetector(
                        onDoubleTap: isOwner
                            ? () {
                                _showEditDialog(context, messagesList[index],
                                    snapshot.data!.docs[index].id);
                              }
                            : null,
                        child: isOwner
                            ? chatBuble(
                                message: messagesList[index],
                              )
                            : chatBubleForFriend(
                                message: messagesList[index],
                              ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    height: 35,
                    child: TextField(
                      controller: controller,
                      onSubmitted: (data) {
                        _sendMessage(data, email);
                      },
                      decoration: InputDecoration(
                        hintText: 'Send Message',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.send,
                            color: kPrimaryColor,
                            size: 16,
                          ),
                          onPressed: () {
                            _sendMessage(controller.text, email);
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: kPrimaryColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: kPrimaryColor),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  void _sendMessage(String data, String email) {
    if (data.trim().isEmpty) return;

    messages.add(
      {
        kMessage: data.trim(),
        kCreatedAt: DateTime.now(),
        'id': email,
      },
    );

    controller.clear();
    _controller.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }

  void _showEditDialog(BuildContext context, Message message, String docId) {
    TextEditingController editController =
        TextEditingController(text: message.message);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Message"),
          content: TextField(
            controller: editController,
            decoration: const InputDecoration(
              hintText: "Enter new message",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog without saving
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                messages.doc(docId).update({
                  kMessage: editController.text.trim(),
                }).then((_) {
                  Navigator.pop(context); // Close dialog
                }).catchError((error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error updating message: $error")),
                  );
                });
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }
}
