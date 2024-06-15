// To parse this JSON data, do
//
//     final artist = artistFromJson(jsonString);
//     final album = albumFromJson(jsonString);
//     final characterModel = characterModelFromJson(jsonString);

import 'dart:convert';

Artist artistFromJson(String str) => Artist.fromJson(json.decode(str));

String artistToJson(Artist data) => json.encode(data.toJson());

Album albumFromJson(String str) => Album.fromJson(json.decode(str));

String albumToJson(Album data) => json.encode(data.toJson());

CharacterModel characterModelFromJson(String str) => CharacterModel.fromJson(json.decode(str));

String characterModelToJson(CharacterModel data) => json.encode(data.toJson());

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

class CharacterModel {
    Info? info;
    List<Result>? results;

    CharacterModel({
        this.info,
        this.results,
    });

    factory CharacterModel.fromJson(Map<String, dynamic> json) => CharacterModel(
        info: json["info"] == null ? null : Info.fromJson(json["info"]),
        results: json["results"] == null ? [] : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "info": info?.toJson(),
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
    };
}

class Info {
    int? count;
    int? pages;
    String? next;
    dynamic prev;

    Info({
        this.count,
        this.pages,
        this.next,
        this.prev,
    });

    factory Info.fromJson(Map<String, dynamic> json) => Info(
        count: json["count"],
        pages: json["pages"],
        next: json["next"],
        prev: json["prev"],
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "pages": pages,
        "next": next,
        "prev": prev,
    };
}

class Result {
    int? id;
    String? name;
    Status? status;
    Species? species;
    String? type;
    Gender? gender;
    Location? origin;
    Location? location;
    String? image;
    List<String>? episode;
    String? url;
    DateTime? created;

    Result({
        this.id,
        this.name,
        this.status,
        this.species,
        this.type,
        this.gender,
        this.origin,
        this.location,
        this.image,
        this.episode,
        this.url,
        this.created,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        status: statusValues.map[json["status"]]!,
        species: speciesValues.map[json["species"]]!,
        type: json["type"],
        gender: genderValues.map[json["gender"]]!,
        origin: json["origin"] == null ? null : Location.fromJson(json["origin"]),
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
        image: json["image"],
        episode: json["episode"] == null ? [] : List<String>.from(json["episode"]!.map((x) => x)),
        url: json["url"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": statusValues.reverse[status],
        "species": speciesValues.reverse[species],
        "type": type,
        "gender": genderValues.reverse[gender],
        "origin": origin?.toJson(),
        "location": location?.toJson(),
        "image": image,
        "episode": episode == null ? [] : List<dynamic>.from(episode!.map((x) => x)),
        "url": url,
        "created": created?.toIso8601String(),
    };
}

enum Gender {
    FEMALE,
    MALE,
    UNKNOWN
}

final genderValues = EnumValues({
    "Female": Gender.FEMALE,
    "Male": Gender.MALE,
    "unknown": Gender.UNKNOWN
});

class Location {
    String? name;
    String? url;

    Location({
        this.name,
        this.url,
    });

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
    };
}

enum Species {
    ALIEN,
    HUMAN
}

final speciesValues = EnumValues({
    "Alien": Species.ALIEN,
    "Human": Species.HUMAN
});

enum Status {
    ALIVE,
    DEAD,
    UNKNOWN
}

final statusValues = EnumValues({
    "Alive": Status.ALIVE,
    "Dead": Status.DEAD,
    "unknown": Status.UNKNOWN
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
