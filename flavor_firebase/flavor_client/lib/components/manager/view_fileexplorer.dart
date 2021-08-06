import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flavor/components/manager/repo_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/all.dart';

List<Widget> filesToUploadUI(ffm, items) => List.generate(
      ffm.filesUploadQueue.length,
      (index) => ListTile(
        title: Text('${ffm.filesUploadQueue[index].fileInfo.name}'),
        subtitle: ffm.filesUploadQueue[index].uploadtask != null
            ? StreamBuilder<TaskSnapshot>(
                stream: ffm.filesUploadQueue[index].uploadtask.asStream(),
                builder: (BuildContext context,
                    AsyncSnapshot<TaskSnapshot> snapshot) {
                  return snapshot.hasData
                      ? LinearProgressIndicator(
                          value: .5,
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        );
                })
            : FutureBuilder(
                // future: filesUploadQueue[index],
                future: Future.delayed(Duration(seconds: 1)),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text('${snapshot.data}');
                  }
                  return Container();
                }),
        trailing: IconButton(
          onPressed: () => {},
          icon: Icon(Icons.mode_edit),
        ),
      ),
    );

class ManagerDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}

class ManagerUploadPage extends StatelessWidget {
  final FlavorFileManager ffm;

  ManagerUploadPage(this.ffm);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload'),
      ),
      // floatingActionButton: ElevatedButton.icon(
      //   onPressed: pickFiles,
      //   label: Text('Add Files'),
      //   icon: Icon(Icons.add),
      // ),
      body: ffm.filesUploadQueue != null
          ? Container(
              // color: Colors.amber,
              child: ListView(
                  // children: filesToUploadUI(ffm, ffm.filesUploadQueue),
                  ),
            )
          : Container(
              child: Center(
                child: ElevatedButton.icon(
                  onPressed: pickFiles,
                  label: Text('Add Files'),
                  icon: Icon(Icons.add),
                ),
              ),
            ),
    );
  }

  void pickFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        withData: true,
      );
      // print('result.files[0]:: ${result.files[0].name}');
      if (result != null) {
        List<FlavorFile> newList = [];
        for (var i = 0; i < result.files.length; i++) {
          var p = result.files[i];
          var ff = FlavorFile(fileInfo: p);
          newList.add(ff);
        }

        ffm.filesUploadQueue = newList;

        // Future.delayed(Duration(microseconds: 0)).then((value) => setState(() {
        //       ffm.filesUploadQueue = newList;
        //     }));
        // //beginUploads();

      } else {
        print('pickFiles - canceled');
      }
    } on PlatformException catch (e) {
      print("pickFiles - Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
  }
}
