import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:simpleblue/model/bluetooth_device.dart';
import 'package:simpleblue/simpleblue.dart';
import 'package:nahleh_net/widget/constant.dart';

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_spinkit/flutter_spinkit.dart';

import './get_codes.dart';
import '../globals.dart' as globals;

class AZConnectionPage extends StatefulWidget {
  const AZConnectionPage({Key? key}) : super(key: key);

  @override
  State<AZConnectionPage> createState() => _AZConnectionPageState();
}

const serviceUUID = null;
const scanTimeout = 15000;

class _AZConnectionPageState extends State<AZConnectionPage> {
  final _simplebluePlugin = Simpleblue();

  var devices = <String, BluetoothDevice>{};
  String azResult = '';
  String receivedData = '';
  bool waitForIndicator = false;
  String AZDeviceUUID = '';
  bool AZSearchISloading = false;

  void DeleteErrors() {
    _simplebluePlugin.write(
        AZDeviceUUID, Uint8List.fromList(utf8.encode("04" + "\r\n")).toList());
  }

  void getPermissions() async {
    final isBluetoothGranted = Platform.isIOS ||
        (await Permission.bluetooth.status) == PermissionStatus.granted ||
        (await Permission.bluetooth.request()) == PermissionStatus.granted;

    if (isBluetoothGranted) {
      print("azBluetooth permission granted");
    }

    // For new android version
    try {
      print('AZ: Looking for permissions on new android version');
      await Permission.bluetoothScan.request();
      await Permission.bluetoothConnect.request();
      await Permission.bluetoothAdvertise.request();
    } catch (e) {
      print('AZ: Probablly an old android version');
    }

    final isLocationGranted = Platform.isIOS ||
        (await Permission.location.status) == PermissionStatus.granted ||
        (await Permission.location.request()) == PermissionStatus.granted;
    if (isLocationGranted) {
      print("azLocation permission granted");
    }
  }

  @override
  void initState() {
    super.initState();
    print('0 azLis is : ' + globals.azIsListening.toString());
    if (globals.azIsListening == false) {
      print('1 azLis is : ' + globals.azIsListening.toString());
      globals.azIsListening = true;
      print('2 azLis is : ' + globals.azIsListening.toString());
      _simplebluePlugin.listenConnectedDevice().listen((connectedDevice) {
        debugPrint("Connected device: $connectedDevice");

        if (connectedDevice != null) {
          setState(() {
            devices[connectedDevice.uuid] = connectedDevice;
          });
        }

        connectedDevice?.stream?.listen((received) {
          print(utf8.decode(received.cast<int>()));
          if (waitForIndicator == false) {
            setState(() {
              azResult += utf8.decode(received.cast<int>());
              receivedData +=
                  "${DateTime.now().toString()}: ${utf8.decode(received.cast<int>())}\n";
            });
          } else {
            setState(() {
              String newData = utf8.decode(received.cast<int>());
              if (newData.contains(">")) {
                // When Everything Is Done
                azResult += utf8.decode(received.cast<int>());
                azResult = azResult.replaceAll("SEARCHING...", "");
                azResult = azResult.replaceAll(">", "");
                receivedData = azResult;

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return AZGetCodes(
                          AZCodes: azResult,
                          AZDevice: _simplebluePlugin,
                          AZUUID: AZDeviceUUID);
                    },
                  ),
                );

                AZSearchISloading = false;
                azResult = "";
                receivedData = "";
              } else {
                azResult += utf8.decode(received.cast<int>());
                receivedData = azResult;
              }
            });
          }
        });
      }).onError((err) {
        debugPrint(err);
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scan();
    });

    _simplebluePlugin.getDevices().then((value) => setState(() {
          for (var device in value) {
            devices[device.uuid] = device;
          }
        }));
  }

  void scan() async {
    final isBluetoothGranted = Platform.isIOS ||
        (await Permission.bluetooth.status) == PermissionStatus.granted ||
        (await Permission.bluetooth.request()) == PermissionStatus.granted;

    if (isBluetoothGranted) {
      print("Bluetooth permission granted");

      final isLocationGranted = Platform.isIOS ||
          (await Permission.location.status) == PermissionStatus.granted ||
          (await Permission.location.request()) == PermissionStatus.granted;

      if (isLocationGranted) {
        print("Location permission granted");
        _simplebluePlugin
            .scanDevices(serviceUUID: serviceUUID, timeout: scanTimeout)
            .listen((event) {
          setState(() {
            for (var device in event) {
              devices[device.uuid] = device;
            }
          });
        });
      }
    } else {
      try {
        print('AZ: Looking for permissions on new android version');
        await Permission.bluetoothScan.request();
        await Permission.bluetoothConnect.request();
        await Permission.bluetoothAdvertise.request();
        print('AZ : New Android Permission Granted');
        final isLocationGranted = Platform.isIOS ||
            (await Permission.location.status) == PermissionStatus.granted ||
            (await Permission.location.request()) == PermissionStatus.granted;
        if (isLocationGranted) {
          print("AZ : Location permission granted");
        }
      } catch (e) {
        print('AZ: Probablly an old android version');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return !AZSearchISloading
        ? Column(children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(firstColor)),
                  child: Text('قائمة الاجهزة'),
                  onPressed: () {
                    _simplebluePlugin.getDevices().then((value) {
                      setState(() {
                        for (var device in value) {
                          devices[device.uuid] = device;
                        }
                      });
                    });
                  }),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(firstColor)),
                  child: Text('البحث عن الاجهزة'),
                  onPressed: () {
                    scan();
                  }),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.58,
              width: MediaQuery.of(context).size.width,
              child: buildDevices(),
            ),
            SizedBox(
                height: 200,
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      receivedData,
                      style: const TextStyle(fontSize: 10),
                    )))
          ])
        : Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SpinKitFadingCircle(
                    color: firstColor,
                    size: 100,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'جاري فحص المركبة',
                    style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 22,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          );
  }

  final _connectingUUIDs = <String>[];

  Widget buildDevices() {
    final devList = devices.values.toList();
    return ListView.builder(
        itemCount: devList.length,
        itemBuilder: (context, index) {
          final device = devList[index];

          return ListTile(
            onTap: () {
              if (device.isConnected) {
                _simplebluePlugin.disconnect(device.uuid);
              } else {
                setState(() {
                  _connectingUUIDs.add(device.uuid);
                });
                _simplebluePlugin.connect(device.uuid).then((value) {
                  setState(() {
                    _connectingUUIDs.remove(device.uuid);
                  });
                });
              }
            },
            leading: _connectingUUIDs.contains(device.uuid)
                ? Icon(Icons.bluetooth, color: Colors.orange)
                : (device.isConnected
                    ? Icon(Icons.bluetooth_connected, color: Colors.blue)
                    : Icon(
                        Icons.bluetooth,
                        color: Colors.grey.shade300,
                      )),
            title: Text('${device.name ?? 'No name'}\n${device.uuid}'),
            subtitle: device.isConnected
                ? Row(
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(firstColor)),
                          child: Text('بدء عملية الفحص'),
                          onPressed: () async {
                            setState(() {
                              AZSearchISloading = true;
                            });
                            // Set AZDevice UUID [FOR DELETE 04]
                            AZDeviceUUID = device.uuid;
                            _simplebluePlugin.write(
                                device.uuid,
                                Uint8List.fromList(utf8.encode("ATZ" + "\r\n"))
                                    .toList());
                            await Future.delayed(Duration(seconds: 2));
                            _simplebluePlugin.write(
                                device.uuid,
                                Uint8List.fromList(utf8.encode("ATL0" + "\r\n"))
                                    .toList());
                            await Future.delayed(Duration(seconds: 2));
                            _simplebluePlugin.write(
                                device.uuid,
                                Uint8List.fromList(utf8.encode("ATE0" + "\r\n"))
                                    .toList());
                            await Future.delayed(Duration(seconds: 2));
                            _simplebluePlugin.write(
                                device.uuid,
                                Uint8List.fromList(utf8.encode("ATH0" + "\r\n"))
                                    .toList());
                            await Future.delayed(Duration(seconds: 2));
                            _simplebluePlugin.write(
                                device.uuid,
                                Uint8List.fromList(
                                        utf8.encode("ATAT1" + "\r\n"))
                                    .toList());
                            await Future.delayed(Duration(seconds: 2));
                            _simplebluePlugin.write(
                                device.uuid,
                                Uint8List.fromList(utf8.encode("ATS0" + "\r\n"))
                                    .toList());
                            await Future.delayed(Duration(seconds: 2));
                            _simplebluePlugin.write(
                                device.uuid,
                                Uint8List.fromList(
                                        utf8.encode("ATSP0" + "\r\n"))
                                    .toList());
                            await Future.delayed(Duration(seconds: 4));
                            setState(() {
                              receivedData = '';
                              azResult = '';
                              waitForIndicator = true;
                            });
                            _simplebluePlugin.write(
                                device.uuid,
                                Uint8List.fromList(utf8.encode("03" + "\r\n"))
                                    .toList());
                          })
                    ],
                  )
                : null,
          );
        });
  }
}
