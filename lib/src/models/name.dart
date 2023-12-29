import 'package:azlistview/azlistview.dart';

class Name extends ISuspensionBean {
  final int id;
  final String name;
  final String meaning;
  final String gender;
  final String origin;

   Name(
      {required this.id,
      required this.name,
      required this.meaning,
      required this.gender,
      required this.origin});



  Name.fromMap(Map<String, dynamic> result)
   : id = result["id"],
   name = result["name"],
   meaning = result["meaning"],
   gender = result["gender"],
   origin = result["origin"] ?? '';

   Map<String, Object> toMap() {
    return{
      'id':id,
      'name': name,
      'meaning':meaning,
      'gender': gender,
      'origin': origin 
    };
   } 

    @override
  String getSuspensionTag() {
    // TODO: implement getSuspensionTag
    return name[0];
  }
}
