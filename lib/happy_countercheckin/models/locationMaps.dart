class LocationGoogleMaps {
  String mapId;
  String mapLoactionname;
  String mapLat;
  String mapLng;
  String mapRadius;
  String mapDistance;
  String mapCreatedate;
  String mapEditdate;
  String mapActive;

  LocationGoogleMaps(
      {this.mapId,
      this.mapLoactionname,
      this.mapLat,
      this.mapLng,
      this.mapRadius,
      this.mapDistance,
      this.mapCreatedate,
      this.mapEditdate,
      this.mapActive});

  LocationGoogleMaps.fromJson(Map<String, dynamic> json) {
    mapId = json['map_id'];
    mapLoactionname = json['map_loactionname'];
    mapLat = json['map_lat'];
    mapLng = json['map_lng'];
    mapRadius = json['map_radius'];
    mapDistance = json['map_distance'];
    mapCreatedate = json['map_createdate'];
    mapEditdate = json['map_editdate'];
    mapActive = json['map_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['map_id'] = this.mapId;
    data['map_loactionname'] = this.mapLoactionname;
    data['map_lat'] = this.mapLat;
    data['map_lng'] = this.mapLng;
    data['map_radius'] = this.mapRadius;
    data['map_distance'] = this.mapDistance;
    data['map_createdate'] = this.mapCreatedate;
    data['map_editdate'] = this.mapEditdate;
    data['map_active'] = this.mapActive;
    return data;
  }
}
