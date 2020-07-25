import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Podcast extends Equatable {
  final String title;
  final String artist;
  final String image;
  final String genre;
  

  Podcast({
    @required this.title,
    @required this.artist,
    @required this.image,
    @required this.genre,
  });

  @override
  List<Object> get props => [title, artist, image, genre];
}
