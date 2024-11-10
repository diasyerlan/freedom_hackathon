import 'dart:io';
import 'dart:typed_data';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:freedom_app/components/custom_app_bar.dart';
import 'package:image_picker/image_picker.dart';

class GeminiPage extends StatefulWidget {
  const GeminiPage({super.key});

  @override
  State<GeminiPage> createState() => _GeminiPageState();
}

class _GeminiPageState extends State<GeminiPage> {
  final currentAuthUser = FirebaseAuth.instance.currentUser!;
  final Gemini gemini = Gemini.instance;
  ChatUser currentUser = ChatUser(id: '0', firstName: 'User');

  ChatUser geminiUser =
      ChatUser(id: '1', firstName: 'HR Bot', profileImage: 'assets/3.png');

  List<ChatMessage> messages = [];

  @override
  void initState() {
    super.initState();

    // Send the initial message when the page is loaded
    _sendInitialMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GradientAppBar(
          title: const Text(
            "Умный ассистент",
            style: TextStyle(
                fontFamily: 'Aldrich', color: Colors.white),
          ),
        ),
        body: _buildUI());
  }

  Widget _buildUI() {
    return DashChat(
        inputOptions: InputOptions(trailing: [
          IconButton(
              onPressed: _sendMediaMessage, icon: const Icon(Icons.image))
        ]),
        currentUser: currentUser,
        onSend: _sendMessage,
        messages: messages);
  }

  // Method to send the first message
  void _sendInitialMessage() {
    ChatMessage initialMessage = ChatMessage(
      user: geminiUser,
      createdAt: DateTime.now(),
      text:
          "Здравствуйте, ${currentAuthUser.email!.split('@')[0]}!\n\nЯ — ваш новый помощник по подбору персонала, созданный для того, чтобы упростить и ускорить процесс найма! 🎉\n\nЯ могу:\nПроводить первичный отбор кандидатов, анализируя резюме и ответы на опросы,\nПомогать с сортировкой и приоритизацией кандидатов по заданным критериям,\nОтвечать на часто задаваемые вопросы кандидатов,\nЗаписывать и анализировать ключевые моменты интервью и собеседований,\nСобирать и систематизировать обратную связь от команды.\nДля начала работы вы можете загрузить информацию о вакансиях, критерии отбора или предоставить список задач, с которыми нужна помощь. Также я готов ответить на любые вопросы о том, как я могу поддержать вас на каждом этапе подбора.\nДавайте вместе сделаем процесс найма еще более эффективным! 🚀\n\nС нетерпением жду возможности приступить к работе!",
    );

    setState(() {
      messages = [initialMessage, ...messages];
    });
  }

  void _sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
    });

    try {
      String question =
          "${chatMessage.text}. Отвечайте, если это связано с профессиями. В противном случае отклоните вопрос и скажите, что не можете ответить так как ты не имеешь такую функциональность.";
      List<Uint8List>? images;
      if (chatMessage.medias?.isNotEmpty ?? false) {
        images = [File(chatMessage.medias!.first.url).readAsBytesSync()];
      }

      gemini.streamGenerateContent(question, images: images).listen((event) {
        ChatMessage? lastMessage = messages.firstOrNull;
        if (lastMessage != null && lastMessage.user == geminiUser) {
          lastMessage = messages.removeAt(0);
          String response = event.content?.parts?.fold(
                  "", (previous, current) => "$previous ${current.text}") ??
              "";
          lastMessage.text += response;
          setState(() {
            messages = [lastMessage!, ...messages];
          });
        } else {
          String response = event.content?.parts?.fold(
                  "", (previous, current) => "$previous${current.text}") ??
              "";
          ChatMessage message = ChatMessage(
              user: geminiUser, createdAt: DateTime.now(), text: response);
          setState(() {
            messages = [message, ...messages];
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void _sendMediaMessage() async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      ChatMessage message = ChatMessage(
          user: currentUser,
          createdAt: DateTime.now(),
          text:
              'Обьясни это фото если это связано с профессиями. В противном случае отклоните вопрос и скажите, что не можете ответить так как ты не имеешь такую функциональность.',
          medias: [
            ChatMedia(url: file.path, fileName: '', type: MediaType.image)
          ]);
      _sendMessage(message);
    }
  }
}
