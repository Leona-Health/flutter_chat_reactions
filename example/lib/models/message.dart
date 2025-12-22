class Message {
  String id;
  String message;
  String timeSent;
  List<String> reactions;
  bool isMe;

  Message({
    required this.id,
    required this.message,
    required this.timeSent,
    required this.reactions,
    required this.isMe,
  });

  // list of messages
  static List<Message> messages = [
    Message(
      id: '1',
      message: 'Hello',
      timeSent: '10:00 AM',
      reactions: ['😍'],
      isMe: false,
    ),
    Message(
      id: '2',
      message: 'Hi',
      timeSent: '10:01 AM',
      reactions: ['😂'],
      isMe: true,
    ),
    Message(
      id: '3',
      message: 'How are you?',
      timeSent: '10:02 AM',
      reactions: ['👍', '❤️'],
      isMe: false,
    ),
    Message(
      id: '4',
      message: 'I am fine, thank you',
      timeSent: '10:03 AM',
      reactions: ['👍', '❤️', '😂', '😮', '😢', '😠'],
      isMe: true,
    ),
    Message(
      id: '5',
      message: 'What about you?',
      timeSent: '10:04 AM',
      reactions: ['👍', '❤️', '😂', '😮'],
      isMe: false,
    ),
    Message(
      id: '6',
      message: 'I am also fine',
      timeSent: '10:05 AM',
      reactions: ['👍', '❤️', '😂'],
      isMe: true,
    ),
    Message(
      id: '7',
      message: 'Good to hear that',
      timeSent: '10:06 AM',
      reactions: ['👍'],
      isMe: false,
    ),
    Message(
      id: '8',
      message: 'Yes',
      timeSent: '10:07 AM',
      reactions: ['❤️'],
      isMe: true,
    ),
    Message(
      id: '9',
      message: 'Bye',
      timeSent: '10:08 AM',
      reactions: ['👍', '💗', '😂'],
      isMe: false,
    ),
    Message(
      id: '10',
      message: 'Goodbye',
      timeSent: '10:09 AM',
      reactions: [
        '👍',
      ],
      isMe: true,
    ),
    Message(
      id: '10',
      message: 'la bla Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam fringilla quis arcu vel lacinia. Fusce volutpat accumsan bibendum.  la bla Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam fringilla quis arcu vel lacinia. Fusce volutpat accumsan bibendum.  la bla Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam fringilla quis arcu vel lacinia. Fusce volutpat accumsan bibendum. la bla Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam fringilla quis arcu vel lacinia. Fusce volutpat accumsan bibendum. la bla Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam fringilla quis arcu vel lacinia. Fusce volutpat accumsan bibendum. Bla bla Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam fringilla quis arcu vel lacinia. Fusce volutpat accumsan bibendum. Proin sollicitudin dapibus massa, non sodales nisi tristique malesuada. Fusce eleifend diam sit amet ultrices ultricies. Donec vitae nisl in mauris semper dapibus. Praesent sodales, ante placerat porttitor efficitur, nulla lorem sollicitudin ipsum, blandit dictum ipsum ipsum ac purus. Morbi vel turpis nisi. Phasellus porta consequat mattis. Etiam metus lectus, tincidunt rutrum mi nec, condimentum vulputate libero. Sed leo magna, dignissim non dapibus sed, varius sed erat. Donec euismod, sapien consectetur tempor volutpat, nisl ligula dictum neque, et vestibulum eros eros sed nisi. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. In placerat lobortis tellus, et egestas leo vehicula vel. Proin ac felis mi. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.',
      timeSent: '10:09 AM',
      reactions: [
        '👍',
      ],
      isMe: true,
    ),
    Message(
      id: '10',
      message: 'la bla Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam fringilla quis arcu vel lacinia. Fusce volutpat accumsan bibendum.  la bla Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam fringilla quis arcu vel lacinia. Fusce volutpat accumsan bibendum.  la bla Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam fringilla quis arcu vel lacinia. Fusce volutpat accumsan bibendum. la bla Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam fringilla quis arcu vel lacinia. Fusce volutpat accumsan bibendum. la bla Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam fringilla quis arcu vel lacinia. Fusce volutpat accumsan bibendum. Bla bla Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam fringilla quis arcu vel lacinia. Fusce volutpat accumsan bibendum. Proin sollicitudin dapibus massa, non sodales nisi tristique malesuada. Fusce eleifend diam sit amet ultrices ultricies. Donec vitae nisl in mauris semper dapibus. Praesent sodales, ante placerat porttitor efficitur, nulla lorem sollicitudin ipsum, blandit dictum ipsum ipsum ac purus. Morbi vel turpis nisi. Phasellus porta consequat mattis. Etiam metus lectus, tincidunt rutrum mi nec, condimentum vulputate libero. Sed leo magna, dignissim non dapibus sed, varius sed erat. Donec euismod, sapien consectetur tempor volutpat, nisl ligula dictum neque, et vestibulum eros eros sed nisi. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. In placerat lobortis tellus, et egestas leo vehicula vel. Proin ac felis mi. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.',
      timeSent: '10:09 AM',
      reactions: [
        '👍',
      ],
      isMe: false,
    ),
  ];
}
