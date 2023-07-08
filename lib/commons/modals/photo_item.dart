class PhotoItem {
  final String id;
  final String imageUrl;
  final String? name;
  final String? description;
  final int? width;
  final int? height;
  final String? mimeType;
  final String? createdAt;

  PhotoItem({
    required this.id,
    required this.imageUrl,
    this.name,
    this.description,
    this.width,
    this.height,
    this.mimeType,
    this.createdAt
  });

  factory PhotoItem.fromMap(Map<String, dynamic> map) {
    return PhotoItem(
      id: map['id'] ?? '',
      imageUrl: map['baseUrl'] ?? '',
      name: map['filename'] ?? '',
      description: map['description'] ?? '',
      width: map['mediaMetadata']['width'] != null
          ? int.tryParse(map['mediaMetadata']['width'])
          : null,
      height: map['mediaMetadata']['height'] != null
          ? int.tryParse(map['mediaMetadata']['height'])
          : null,
      mimeType: map['mimeType'],
      createdAt: map['mediaMetadata']['creationTime'],
    );
  }

}