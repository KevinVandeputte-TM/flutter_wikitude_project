class ARModelResponse{
  String modelname;

  ARModelResponse({required this.modelname});

  factory ARModelResponse.fromJson(Map<String, dynamic> json){
    return ARModelResponse(
      modelname: json['modelname']
    );
  }
}