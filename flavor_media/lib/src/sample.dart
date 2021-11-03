import 'dart:io';
import 'dart:ui' as ui;
import 'dart:convert';
import 'package:flavor_media/src/flavor_video/flavor_video.dart';
import 'package:flutter/material.dart';
import 'package:dart_vlc/dart_vlc.dart';

import 'settings/settings_controller.dart';

//
class DartVLCExample extends StatefulWidget {
  const DartVLCExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DartVLCExampleState();
}

class DartVLCExampleState extends State<DartVLCExample> {
  TextEditingController controller = TextEditingController();
  TextEditingController metasController = TextEditingController();

  // @override
  // Future<void> didChangeDependencies() async {
  //   super.didChangeDependencies();
  //   _mediaController.devices = Devices.all;
  //   Equalizer equalizer = Equalizer.createMode(EqualizerMode.live);
  //   equalizer.setPreAmp(10.0);
  //   equalizer.setBandAmp(31.25, 10.0);
  //   _mediaController.player.setEqualizer(equalizer);
  //   setState(() {});
  // }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SettingsController _mediaController =
        FlavorVideoAdapter.of(context).controller;

    bool isTablet;
    bool isPhone;

    final double devicePixelRatio = ui.window.devicePixelRatio;
    final ui.Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    print('devicePixelRatio::$size');

    if (devicePixelRatio < 2 && (width >= 650)) {
      isTablet = true;
      isPhone = false;
    } else {
      isTablet = false;
      isPhone = true;
    }

    // if (_mediaController == null) {
    //   return const Scaffold(
    //     body: Center(
    //       child: CircularProgressIndicator(),
    //     ),
    //   );
    // }
    // return Container();
    return Scaffold(
      backgroundColor: _mediaController.themeMode == ThemeMode.dark
          ? Colors.red
          : Colors.redAccent,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              _mediaController.toggleThemeMode();
            },
            icon: const Icon(Icons.lightbulb_outline_rounded)),
        title: const Text('flavor_dart_vlc'),
        centerTitle: true,
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8.0),
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                clipBehavior: Clip.antiAlias,
                elevation: 8.0,
                child: Video(
                  showControls: false,
                  player: _mediaController.player,
                  width: isPhone ? 320 : 640,
                  height: isPhone ? 240 : 480,
                  volumeThumbColor: Colors.red,
                  volumeActiveColor: Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isPhone) _controls(context, isPhone),
                    Card(
                      elevation: 2.0,
                      margin: const EdgeInsets.all(4.0),
                      child: Container(
                        margin: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                                const Text('Playlist creation.'),
                                const Divider(
                                  height: 8.0,
                                  color: Colors.transparent,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: controller,
                                        cursorWidth: 1.0,
                                        autofocus: true,
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                        ),
                                        decoration:
                                            const InputDecoration.collapsed(
                                          hintStyle: TextStyle(
                                            fontSize: 14.0,
                                          ),
                                          hintText: 'Enter Media path.',
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 152.0,
                                      child: DropdownButton<MediaType>(
                                        value: _mediaController.mediaType,
                                        onChanged: (mediaType) => setState(
                                            () => mediaType = mediaType!),
                                        items: [
                                          DropdownMenuItem<MediaType>(
                                            value: MediaType.file,
                                            child: Text(
                                              MediaType.file.toString(),
                                              style: const TextStyle(
                                                fontSize: 14.0,
                                              ),
                                            ),
                                          ),
                                          DropdownMenuItem<MediaType>(
                                            value: MediaType.network,
                                            child: Text(
                                              MediaType.network.toString(),
                                              style: const TextStyle(
                                                fontSize: 14.0,
                                              ),
                                            ),
                                          ),
                                          DropdownMenuItem<MediaType>(
                                            value: MediaType.asset,
                                            child: Text(
                                              MediaType.asset.toString(),
                                              style: const TextStyle(
                                                fontSize: 14.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          if (_mediaController.mediaType ==
                                              MediaType.file) {
                                            _mediaController.medias.add(
                                              Media.file(File(controller.text
                                                  .replaceAll('"', ''))),
                                            );
                                          } else if (_mediaController
                                                  .mediaType ==
                                              MediaType.network) {
                                            _mediaController.medias.add(
                                              Media.network(controller.text),
                                            );
                                          }
                                          setState(() {});
                                        },
                                        child: const Text(
                                          'Add to Playlist',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  height: 12.0,
                                ),
                                const Divider(
                                  height: 8.0,
                                  color: Colors.transparent,
                                ),
                                const Text('Playlist'),
                              ] +
                              _mediaController.medias
                                  .map(
                                    (media) => ListTile(
                                      title: Text(
                                        media.resource,
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      subtitle: Text(
                                        media.mediaType.toString(),
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList() +
                              <Widget>[
                                const Divider(
                                  height: 8.0,
                                  color: Colors.transparent,
                                ),
                                Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () => setState(() {
                                        _mediaController.player.open(
                                          Playlist(
                                              medias: _mediaController.medias,
                                              playlistMode:
                                                  PlaylistMode.single),
                                        );
                                      }),
                                      child: const Text(
                                        'Open into Player',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12.0),
                                    ElevatedButton(
                                      onPressed: () => setState(() {
                                        _mediaController.medias.clear();
                                      }),
                                      child: const Text(
                                        'Clear the list',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 2.0,
                      margin: EdgeInsets.all(4.0),
                      child: Container(
                        margin: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Playback event listeners.'),
                            Divider(
                              height: 12.0,
                              color: Colors.transparent,
                            ),
                            Divider(
                              height: 12.0,
                            ),
                            Text('Playback position.'),
                            Divider(
                              height: 8.0,
                              color: Colors.transparent,
                            ),
                            Slider(
                                min: 0,
                                max: _mediaController
                                        .position.duration?.inMilliseconds
                                        .toDouble() ??
                                    1.0,
                                value: _mediaController
                                        .position.position?.inMilliseconds
                                        .toDouble() ??
                                    0.0,
                                onChanged: (double position) =>
                                    _mediaController.player.seek(Duration(
                                        milliseconds: position.toInt()))),
                            Text('Event streams.'),
                            Divider(
                              height: 8.0,
                              color: Colors.transparent,
                            ),
                            Table(
                              children: [
                                TableRow(children: [
                                  Text(
                                      '_mediaController!.player.general.volume'),
                                  Text('${_mediaController.general.volume}')
                                ]),
                                TableRow(children: [
                                  Text('_mediaController!.player.general.rate'),
                                  Text('${_mediaController.general.rate}')
                                ]),
                                TableRow(children: [
                                  Text(
                                      '_mediaController!.player.position.position'),
                                  Text('${_mediaController.position.position}')
                                ]),
                                TableRow(children: [
                                  Text(
                                      '_mediaController!.player.position.duration'),
                                  Text('${_mediaController.position.duration}')
                                ]),
                                TableRow(children: [
                                  Text(
                                      '_mediaController!.player.playback.isCompleted'),
                                  Text(
                                      '${_mediaController.playback.isCompleted}')
                                ]),
                                TableRow(children: [
                                  Text(
                                      '_mediaController!.player.playback.isPlaying'),
                                  Text('${_mediaController.playback.isPlaying}')
                                ]),
                                TableRow(children: [
                                  Text(
                                      '_mediaController!.player.playback.isSeekable'),
                                  Text(
                                      '${_mediaController.playback.isSeekable}')
                                ]),
                                TableRow(children: [
                                  Text(
                                      '_mediaController!.player.current.index'),
                                  Text('${_mediaController.current.index}')
                                ]),
                                TableRow(children: [
                                  Text(
                                      '_mediaController!.player.current.media'),
                                  Text('${_mediaController.current.media}')
                                ]),
                                TableRow(children: [
                                  Text(
                                      '_mediaController!.player.current.medias'),
                                  Text('${_mediaController.current.medias}')
                                ]),
                                TableRow(children: [
                                  Text(
                                      '_mediaController!.player.videoDimensions'),
                                  Text('${_mediaController.videoDimensions}')
                                ]),
                                TableRow(children: [
                                  Text(
                                      '_mediaController!.player.bufferingProgress'),
                                  Text('${_mediaController.bufferingProgress}')
                                ]),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 2.0,
                      margin: EdgeInsets.all(4.0),
                      child: Container(
                        margin: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                                Text('Playback devices.'),
                                Divider(
                                  height: 12.0,
                                  color: Colors.transparent,
                                ),
                                Divider(
                                  height: 12.0,
                                ),
                              ] +
                              _mediaController.devices
                                  .map(
                                    (device) => ListTile(
                                      title: Text(
                                        device.name,
                                        style: TextStyle(
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      subtitle: Text(
                                        device.id,
                                        style: TextStyle(
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      onTap: () => _mediaController.player
                                          .setDevice(device),
                                    ),
                                  )
                                  .toList(),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 2.0,
                      margin: EdgeInsets.all(4.0),
                      child: Container(
                        margin: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Metas parsing.'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: metasController,
                                    cursorWidth: 1.0,
                                    autofocus: true,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                    decoration: InputDecoration.collapsed(
                                      hintStyle: TextStyle(
                                        fontSize: 14.0,
                                      ),
                                      hintText: 'Enter Media path.',
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 152.0,
                                  child: DropdownButton<MediaType>(
                                    value: _mediaController.mediaType,
                                    onChanged: (mediaType) =>
                                        setState(() => mediaType = mediaType!),
                                    items: [
                                      DropdownMenuItem<MediaType>(
                                        value: MediaType.file,
                                        child: Text(
                                          MediaType.file.toString(),
                                          style: TextStyle(
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                      DropdownMenuItem<MediaType>(
                                        value: MediaType.network,
                                        child: Text(
                                          MediaType.network.toString(),
                                          style: TextStyle(
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                      DropdownMenuItem<MediaType>(
                                        value: MediaType.asset,
                                        child: Text(
                                          MediaType.asset.toString(),
                                          style: TextStyle(
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 16.0),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (_mediaController.mediaType ==
                                          MediaType.file) {
                                        _mediaController.metasMedia =
                                            Media.file(
                                                File(metasController.text),
                                                parse: true);
                                      } else if (_mediaController.mediaType ==
                                          MediaType.network) {
                                        _mediaController.metasMedia =
                                            Media.network(metasController.text,
                                                parse: true);
                                      }
                                      setState(() {});
                                    },
                                    child: Text(
                                      'Parse',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              height: 12.0,
                            ),
                            Divider(
                              height: 8.0,
                              color: Colors.transparent,
                            ),
                            Text(
                              JsonEncoder.withIndent('    ')
                                  .convert(_mediaController.metasMedia?.metas),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (isPhone) _playlist(context),
                  ],
                ),
              ),
              if (isTablet)
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _controls(context, isPhone),
                      _playlist(context),
                    ],
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }

  Widget _controls(BuildContext context, bool isPhone) {
    SettingsController _mediaController =
        FlavorVideoAdapter.of(context).controller;

    return Card(
      elevation: 2.0,
      margin: EdgeInsets.all(4.0),
      child: Container(
        margin: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Playback controls.'),
            Divider(
              height: 8.0,
              color: Colors.transparent,
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => _mediaController.player.play(),
                  child: Text(
                    'play',
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ),
                SizedBox(width: 12.0),
                ElevatedButton(
                  onPressed: () => _mediaController.player.pause(),
                  child: Text(
                    'pause',
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ),
                SizedBox(width: 12.0),
                ElevatedButton(
                  onPressed: () => _mediaController.player.playOrPause(),
                  child: Text(
                    'playOrPause',
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ),
                SizedBox(width: 12.0),
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => _mediaController.player.stop(),
                  child: Text(
                    'stop',
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ),
                SizedBox(width: 12.0),
                ElevatedButton(
                  onPressed: () => _mediaController.player.next(),
                  child: Text(
                    'next',
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ),
                SizedBox(width: 12.0),
                ElevatedButton(
                  onPressed: () => _mediaController.player.back(),
                  child: Text(
                    'back',
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              height: 12.0,
              color: Colors.transparent,
            ),
            Divider(
              height: 12.0,
            ),
            Text('Volume control.'),
            Divider(
              height: 8.0,
              color: Colors.transparent,
            ),
            Slider(
              min: 0.0,
              max: 1.0,
              value: _mediaController.player.general.volume,
              onChanged: (volume) {
                _mediaController.player.setVolume(volume);
                setState(() {});
              },
            ),
            Text('Playback rate control.'),
            Divider(
              height: 8.0,
              color: Colors.transparent,
            ),
            Slider(
              min: 0.5,
              max: 1.5,
              value: _mediaController.player.general.rate,
              onChanged: (rate) {
                _mediaController.player.setRate(rate);
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _playlist(BuildContext context) {
    SettingsController _mediaController =
        FlavorVideoAdapter.of(context).controller;

    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 16.0, top: 16.0),
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Playlist manipulation.'),
                Divider(
                  height: 12.0,
                  color: Colors.transparent,
                ),
                Divider(
                  height: 12.0,
                ),
              ],
            ),
          ),
          Container(
            height: 456.0,
            child: ReorderableListView(
              shrinkWrap: true,
              onReorder: (int initialIndex, int finalIndex) async {
                /// 🙏🙏🙏
                /// In the name of God,
                /// With all due respect,
                /// I ask all Flutter engineers to please fix this issue.
                /// Peace.
                /// 🙏🙏🙏
                ///
                /// Issue:
                /// https://github.com/flutter/flutter/issues/24786
                /// Prevention:
                /// https://stackoverflow.com/a/54164333/12825435
                ///
                if (finalIndex > _mediaController.current.medias.length)
                  finalIndex = _mediaController.current.medias.length;
                if (initialIndex < finalIndex) finalIndex--;

                _mediaController.player.move(initialIndex, finalIndex);
                setState(() {});
              },
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              children: List.generate(
                _mediaController.current.medias.length,
                (int index) => ListTile(
                  key: Key(index.toString()),
                  leading: Text(
                    index.toString(),
                    style: TextStyle(fontSize: 14.0),
                  ),
                  title: Text(
                    _mediaController.current.medias[index].resource,
                    style: TextStyle(fontSize: 14.0),
                  ),
                  subtitle: Text(
                    _mediaController.current.medias[index].mediaType.toString(),
                    style: TextStyle(fontSize: 14.0),
                  ),
                ),
                growable: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
