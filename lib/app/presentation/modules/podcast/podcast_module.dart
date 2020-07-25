import 'package:inkcast/app/presentation/modules/podcast/podcast_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:inkcast/app/presentation/modules/podcast/player_page.dart';

class PodcastModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => PodcastBloc()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => PlayerPage()),
      ];

  static Inject get to => Inject<PodcastModule>.of();
}
