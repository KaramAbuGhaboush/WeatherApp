import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapApi {
  CameraPosition? _initialCameraPosition;
  GoogleMapController? _controller;
  Marker? _marker;

  GoogleMapApi() {
    _initialCameraPosition = const CameraPosition(
      target: LatLng(31.7683, 35.2137),
      zoom: 11.5,
    );
  }

  CameraPosition? getInitialCameraPosition() {
    return _initialCameraPosition;
  }

  void setController(GoogleMapController controller) {
    _controller = controller;
  }

  void setMarker(Marker marker) {
    _marker = marker;
  }

  Future<void> animateCameraToPosition(CameraPosition cameraPosition) async {
    await _controller!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  Future<void> animateCameraToMarker(Marker marker) async {
    await _controller!.animateCamera(CameraUpdate.newLatLng(marker.position));
  }

  Future<void> animateCameraToLatLng(LatLng latLng) async {
    await _controller!.animateCamera(CameraUpdate.newLatLng(latLng));
  }
}
