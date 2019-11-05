class GuideBean {
	String path;
	int id;

	GuideBean({this.path, this.id});

	GuideBean.fromJson(Map<String, dynamic> json) {
		path = json['path'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['path'] = this.path;
		data['id'] = this.id;
		return data;
	}
}
