class University {
  String? name;
  String? alphaTwoCode;
  String? country;
  List<String>? webPages;
  Null? stateProvince;
  List<String>? domains;

  University(
      {this.name,
        this.alphaTwoCode,
        this.country,
        this.webPages,
        this.stateProvince,
        this.domains});

  University.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    alphaTwoCode = json['alpha_two_code'];
    country = json['country'];
    webPages = json['web_pages'].cast<String>();
    stateProvince = json['state-province'];
    domains = json['domains'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['alpha_two_code'] = this.alphaTwoCode;
    data['country'] = this.country;
    data['web_pages'] = this.webPages;
    data['state-province'] = this.stateProvince;
    data['domains'] = this.domains;
    return data;
  }
}