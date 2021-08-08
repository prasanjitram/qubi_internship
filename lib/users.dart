class UserDetails{
  String name;
  String email;
  String phone;
  String profession;
  UserDetails({required this.name,required this.email,required this.phone,required this.profession});
  Map<String, dynamic> toJson() {
    return {
      "Name": name,
      "Email": email,
      "Phone No.": phone,
      "Profession": profession
    };
  }
}