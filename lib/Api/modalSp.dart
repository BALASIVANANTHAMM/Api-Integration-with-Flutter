class ModalSp {
  int? eid;
  String? place;
  String? role;
  int? salery;

  ModalSp({this.eid, this.place, this.role, this.salery});

  ModalSp.fromJson(Map<String, dynamic> json) {
    eid = json['eid'];
    place = json['place'];
    role = json['role'];
    salery = json['salery'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eid'] = this.eid;
    data['place'] = this.place;
    data['role'] = this.role;
    data['salery'] = this.salery;
    return data;
  }
}