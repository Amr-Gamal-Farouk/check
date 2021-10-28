import 'dart:convert';

List<EmployeeModel> employeeModelFromJson(String str) =>
    List<EmployeeModel>.from(
        json.decode(str).map((x) => EmployeeModel.fromJson(x)));

String employeeModelToJson(EmployeeModel data) => json.encode(data.toJson());

class EmployeeModel {
  EmployeeModel({
    required this.ext,
    required this.fuLlName,
    required this.email,
    required this.branch,
    required this.jobTitle,
    required this.mobile,
    required this.dirPhone,
  });

  String ext;
  String fuLlName;
  String email;
  String branch;
  String jobTitle;
  String mobile;
  String dirPhone;

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
        ext: (json["EXT"] == null) ? "Not Available" : json["EXT"],
        fuLlName:
            (json["FuLL_Name"] == null) ? "Not Available" : json["FuLL_Name"],
        email: (json["Email"] == null)
            ? "Not Available"
            : (json["Email"].toString().isEmpty)
                ? "Not Available"
                : json["Email"],
        branch: (json["Branch"] == null)
            ? "Not Available"
            : (json["Branch"].toString().isEmpty)
                ? "Not Available"
                : json["Branch"],
        jobTitle:
            (json["Job_Title"] == null) ? "Not Available" : json["Job_Title"],
        mobile: (json["Mobile"] == null)
            ? "Not Available"
            : (json["Mobile"].toString().isEmpty)
                ? "Not Available"
                : json["Mobile"],
        dirPhone:
            (json["Dir_Phone"] == null) ? "Not Available" : json["Dir_Phone"],
      );

  Map<String, dynamic> toJson() => {
        "EXT": ext,
        "FuLL_Name": fuLlName,
        "Email": email,
        "Branch": branch,
        "Job_Title": jobTitle,
        "Mobile": mobile,
        "Dir_Phone": dirPhone,
      };
}
