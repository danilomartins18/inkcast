import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inkcast/app/domain/entities/podcast.dart';
import 'package:inkcast/app/shared/constants.dart';
import 'package:audioplayers/audioplayers.dart';

enum PlayerState { stopped, playing, paused }
enum PlayingRouteState { speakers, earpiece }

class PlayerPage extends StatefulWidget {
  final Podcast podcast;
  final String title;
  const PlayerPage({Key key, this.podcast, this.title = "Podcast"})
      : super(key: key);

  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  bool _isLiked = false;

  AudioPlayer _audioPlayer;
  Duration _duration;
  Duration _position;

  PlayerState _playerState = PlayerState.stopped;
  StreamSubscription _durationSubscription;
  StreamSubscription _positionSubscription;
  StreamSubscription _playerCompleteSubscription;
  StreamSubscription _playerErrorSubscription;
  StreamSubscription _playerStateSubscription;

  get _isPlaying => _playerState == PlayerState.playing;
  get _durationText => _duration?.toString()?.split('.')?.first ?? '';
  get _positionText => _position?.toString()?.split('.')?.first ?? '';

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  void _initAudioPlayer() {
    _audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);

    _durationSubscription = _audioPlayer.onDurationChanged.listen((duration) {
      setState(() => _duration = duration);

      // TODO implemented for iOS, waiting for android impl
      if (Theme.of(context).platform == TargetPlatform.iOS) {
        // (Optional) listen for notification updates in the background
        _audioPlayer.startHeadlessService();

        // set at least title to see the notification bar on ios.
        _audioPlayer.setNotification(
            title: 'App Name',
            artist: 'Artist or blank',
            albumTitle: 'Name or blank',
            imageUrl: 'url or blank',
            forwardSkipInterval: const Duration(seconds: 30), // default is 30s
            backwardSkipInterval: const Duration(seconds: 30), // default is 30s
            duration: duration,
            elapsedTime: Duration(seconds: 0));
      }
    });

    _positionSubscription =
        _audioPlayer.onAudioPositionChanged.listen((p) => setState(() {
              _position = p;
            }));

    _playerCompleteSubscription =
        _audioPlayer.onPlayerCompletion.listen((event) {
      _onComplete();
      setState(() {
        _position = _duration;
      });
    });

    _playerErrorSubscription = _audioPlayer.onPlayerError.listen((msg) {
      print('audioPlayer error : $msg');
      setState(() {
        _playerState = PlayerState.stopped;
        _duration = Duration(seconds: 0);
        _position = Duration(seconds: 0);
      });
    });
  }

  Future<int> _play() async {
    final url = "https://luan.xyz/files/audio/ambient_c_motion.mp3";
    final playPosition = (_position != null &&
            _duration != null &&
            _position.inMilliseconds > 0 &&
            _position.inMilliseconds < _duration.inMilliseconds)
        ? _position
        : null;
    final result = await _audioPlayer.play(url, position: playPosition);
    if (result == 1) setState(() => _playerState = PlayerState.playing);

    // default playback rate is 1.0
    // this should be called after _audioPlayer.play() or _audioPlayer.resume()
    // this can also be called everytime the user wants to change playback rate in the UI
    _audioPlayer.setPlaybackRate(playbackRate: 1.0);

    return result;
  }

  Future<int> _pause() async {
    final result = await _audioPlayer.pause();
    if (result == 1) setState(() => _playerState = PlayerState.paused);
    return result;
  }

  Future<int> _stop() async {
    final result = await _audioPlayer.stop();
    if (result == 1) {
      setState(() {
        _playerState = PlayerState.stopped;
        _position = Duration();
      });
    }
    return result;
  }

  void _onComplete() {
    setState(() => _playerState = PlayerState.stopped);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerErrorSubscription?.cancel();
    _playerStateSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black87,
          onPressed: () {
            _stop();
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.slidersH),
            color: Colors.black87,
            onPressed: () => Navigator.pop(context),
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            color: Colors.black87,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 25.0),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  image: DecorationImage(
                    image: AssetImage(widget.podcast.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 35.0),
            Text(
              widget.podcast.title,
              style: inkTitleStyle.copyWith(fontSize: 20.0),
            ),
            SizedBox(height: 15.0),
            Text(
              widget.podcast.artist,
              style: inkSubtitleStyle,
            ),
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    _isLiked ? Icons.favorite : Icons.favorite_border,
                    size: 25.0,
                    color: inkLightColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _isLiked = !_isLiked;
                    });
                  },
                ),
                SizedBox(width: 15.0),
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.commentAlt,
                    size: 25.0,
                    color: inkLightColor,
                  ),
                  onPressed: () {},
                ),
                SizedBox(width: 15.0),
                IconButton(
                  icon: Icon(
                    Icons.file_download,
                    size: 25.0,
                    color: inkLightColor,
                  ),
                  onPressed: () {},
                ),
                SizedBox(width: 15.0),
                IconButton(
                  icon: Icon(
                    Icons.share,
                    size: 25.0,
                    color: inkLightColor,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            Slider(
              activeColor: inkLightColor,
              onChanged: (v) {
                final position = v * _duration.inMilliseconds;
                _audioPlayer.seek(Duration(milliseconds: position.round()));
              },
              value: (_position != null &&
                      _duration != null &&
                      _position.inMilliseconds > 0 &&
                      _position.inMilliseconds < _duration.inMilliseconds)
                  ? _position.inMilliseconds / _duration.inMilliseconds
                  : 0.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: <Widget>[
                  Text(
                    _positionText,
                    style: inkTitleStyle.copyWith(fontSize: 12.0),
                  ),
                  Spacer(),
                  Text(
                    _durationText,
                    style: inkTitleStyle.copyWith(fontSize: 12.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset(
                    "assets/images/backward.svg",
                    width: 25.0,
                  ),
                  Spacer(),
                  GestureDetector(
                    //onTap: _isPlaying ? _pause() : () => _play(),
                    onTap: () {
                      if (_isPlaying) {
                        _pause();
                      } else {
                        _play();
                      }
                    },
                    child: Container(
                      width: 50.0,
                      height: 50.0,
                      padding: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: inkLightColor,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          _isPlaying
                              ? "assets/images/resume.svg"
                              : "assets/images/play.svg",
                          width: 25.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  SvgPicture.asset(
                    "assets/images/forward.svg",
                    width: 25.0,
                  ),
                ],
              ),
            ),
            SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }
}
