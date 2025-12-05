class GameData {
  final String id;
  final String title;
  final String creator;
  final String imageUrl;
  final String likes;
  final String activePlayers;

  const GameData({
    required this.id,
    required this.title,
    required this.creator,
    required this.imageUrl,
    required this.likes,
    required this.activePlayers,
  });
}

class MockData {
  static const List<GameData> games = [
    GameData(
      id: '1',
      title: 'Brookhaven 🏡RP',
      creator: 'Wolfpaq',
      imageUrl: 'https://tr.rbxcdn.com/c72e0974352a9754e207d0b7d7175173/768/432/Image/Png', // Placeholder logic in UI
      likes: '94%',
      activePlayers: '345k',
    ),
    GameData(
      id: '2',
      title: 'Adopt Me!',
      creator: 'DreamCraft',
      imageUrl: 'placeholder',
      likes: '91%',
      activePlayers: '120k',
    ),
    GameData(
      id: '3',
      title: 'Blox Fruits',
      creator: 'Gamer Robot Inc',
      imageUrl: 'placeholder',
      likes: '98%',
      activePlayers: '600k',
    ),
    GameData(
      id: '4',
      title: 'Tower of Hell',
      creator: 'YXCeptional Studios',
      imageUrl: 'placeholder',
      likes: '85%',
      activePlayers: '45k',
    ),
    GameData(
      id: '5',
      title: 'MeepCity',
      creator: 'alexnewtron',
      imageUrl: 'placeholder',
      likes: '88%',
      activePlayers: '30k',
    ),
    GameData(
      id: '6',
      title: 'Murder Mystery 2',
      creator: 'Nikilis',
      imageUrl: 'placeholder',
      likes: '92%',
      activePlayers: '85k',
    ),
  ];

  static const List<String> friends = [
    'NoobMaster69',
    'Builderman',
    'Roblox',
    'Guest 666',
    'CoolGamer',
  ];
}
