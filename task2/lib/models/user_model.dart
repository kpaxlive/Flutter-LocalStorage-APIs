// To parse this JSON data, do
//
//     final artist = artistFromJson(jsonString);
//     final album = albumFromJson(jsonString);
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

Artist artistFromJson(String str) => Artist.fromJson(json.decode(str));

String artistToJson(Artist data) => json.encode(data.toJson());

Album albumFromJson(String str) => Album.fromJson(json.decode(str));

String albumToJson(Album data) => json.encode(data.toJson());

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class Album {
    String? name;
    Artist? artist;
    List<Track>? tracks;

    Album({
        this.name,
        this.artist,
        this.tracks,
    });

    factory Album.fromJson(Map<String, dynamic> json) => Album(
        name: json["name"],
        artist: json["artist"] == null ? null : Artist.fromJson(json["artist"]),
        tracks: json["tracks"] == null ? [] : List<Track>.from(json["tracks"]!.map((x) => Track.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "artist": artist?.toJson(),
        "tracks": tracks == null ? [] : List<dynamic>.from(tracks!.map((x) => x.toJson())),
    };
}

class Artist {
    String? name;
    int? founded;
    List<String>? members;

    Artist({
        this.name,
        this.founded,
        this.members,
    });

    factory Artist.fromJson(Map<String, dynamic> json) => Artist(
        name: json["name"],
        founded: json["founded"],
        members: json["members"] == null ? [] : List<String>.from(json["members"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "founded": founded,
        "members": members == null ? [] : List<dynamic>.from(members!.map((x) => x)),
    };
}

class Track {
    String? name;
    int? duration;

    Track({
        this.name,
        this.duration,
    });

    factory Track.fromJson(Map<String, dynamic> json) => Track(
        name: json["name"],
        duration: json["duration"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "duration": duration,
    };
}

class UserModel {
    int? page;
    int? perPage;
    int? total;
    int? totalPages;
    List<UserData>? data;
    Support? support;

    UserModel({
        this.page,
        this.perPage,
        this.total,
        this.totalPages,
        this.data,
        this.support,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        page: json["page"],
        perPage: json["per_page"],
        total: json["total"],
        totalPages: json["total_pages"],
        data: json["data"] == null ? [] : List<UserData>.from(json["data"]!.map((x) => UserData.fromJson(x))),
        support: json["support"] == null ? null : Support.fromJson(json["support"]),
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "per_page": perPage,
        "total": total,
        "total_pages": totalPages,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "support": support?.toJson(),
    };
}

class UserData {
    int? id;
    String? email;
    String? firstName;
    String? lastName;
    String? avatar;

    UserData({
        this.id,
        this.email,
        this.firstName,
        this.lastName,
        this.avatar,
    });

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
    };
}

class Support {
    String? url;
    String? text;

    Support({
        this.url,
        this.text,
    });

    factory Support.fromJson(Map<String, dynamic> json) => Support(
        url: json["url"],
        text: json["text"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "text": text,
    };
}
