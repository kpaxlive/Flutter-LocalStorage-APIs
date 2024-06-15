
class UserData {
  final int? id;
  final String? name;
  final String? surname;
  final int? age;
  final String? mail;
  final String? favoriteColor;

  UserData(
      {this.id,
      required this.name,
      required this.surname,
      required this.age,
      required this.mail,
      required this.favoriteColor});

  Map<String, Object?> toMap() {
    return {
      'name': name,
      'surname': surname,
      'age': age,
      'mail': mail,
      'favorite_color': favoriteColor,
    };
  }
}
