class DbData {
  int? id;
  String? street;
  String? city;
  String? state;

  DbData({this.id, this.street, this.city, this.state});

  DbData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    street = json['street'];
    city = json['city'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['street'] = this.street;
    data['city'] = this.city;
    data['state'] = this.state;
    return data;
  }
}