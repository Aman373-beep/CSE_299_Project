import 'dart:convert';

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
    Data({
        required this.apiKey,
        required this.count,
        required this.next,
        this.previous,
        required this.results,
    });

    String apiKey;
    int count;
    String next;
    dynamic previous;
    List<Result> results;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        apiKey: json["apiKey"],
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "apiKey": apiKey,
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Result {
    Result({
        required this.id,
        required this.title,
        required this.authors,
        required this.translators,
        required this.subjects,
        required this.bookshelves,
        required this.languages,
        required this.copyright,
        required this.mediaType,
        required this.formats,
        required this.downloadCount,
    });

    int id;
    String title;
    List<Author> authors;
    List<dynamic> translators;
    List<String> subjects;
    List<dynamic> bookshelves;
    List<String> languages;
    bool copyright;
    String mediaType;
    Formats formats;
    int downloadCount;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        title: json["title"],
        authors: List<Author>.from(json["authors"].map((x) => Author.fromJson(x))),
        translators: List<dynamic>.from(json["translators"].map((x) => x)),
        subjects: List<String>.from(json["subjects"].map((x) => x)),
        bookshelves: List<dynamic>.from(json["bookshelves"].map((x) => x)),
        languages: List<String>.from(json["languages"].map((x) => x)),
        copyright: json["copyright"],
        mediaType: json["media_type"],
        formats: Formats.fromJson(json["formats"]),
        downloadCount: json["download_count"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "authors": List<dynamic>.from(authors.map((x) => x.toJson())),
        "translators": List<dynamic>.from(translators.map((x) => x)),
        "subjects": List<dynamic>.from(subjects.map((x) => x)),
        "bookshelves": List<dynamic>.from(bookshelves.map((x) => x)),
        "languages": List<dynamic>.from(languages.map((x) => x)),
        "copyright": copyright,
        "media_type": mediaType,
        "formats": formats.toJson(),
        "download_count": downloadCount,
    };
}

class Author {
    Author({
        required this.name,
        required this.birthYear,
        required this.deathYear,
    });

    String name;
    int birthYear;
    int deathYear;

    factory Author.fromJson(Map<String, dynamic> json) => Author(
        name: json["name"],
        birthYear: json["birth_year"],
        deathYear: json["death_year"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "birth_year": birthYear,
        "death_year": deathYear,
    };
}

class Formats {
    Formats({
        required this.applicationXMobipocketEbook,
        required this.applicationEpubZip,
        required this.textHtml,
        required this.applicationOctetStream,
        required this.imageJpeg,
        required this.textPlain,
        required this.textPlainCharsetUsAscii,
        required this.applicationRdfXml,
    });

    String applicationXMobipocketEbook;
    String applicationEpubZip;
    String textHtml;
    String applicationOctetStream;
    String imageJpeg;
    String textPlain;
    String textPlainCharsetUsAscii;
    String applicationRdfXml;

    factory Formats.fromJson(Map<String, dynamic> json) => Formats(
        applicationXMobipocketEbook: json["application/x-mobipocket-ebook"],
        applicationEpubZip: json["application/epub+zip"],
        textHtml: json["text/html"],
        applicationOctetStream: json["application/octet-stream"],
        imageJpeg: json["image/jpeg"],
        textPlain: json["text/plain"],
        textPlainCharsetUsAscii: json["text/plain; charset=us-ascii"],
        applicationRdfXml: json["application/rdf+xml"],
    );

    Map<String, dynamic> toJson() => {
        "application/x-mobipocket-ebook": applicationXMobipocketEbook,
        "application/epub+zip": applicationEpubZip,
        "text/html": textHtml,
        "application/octet-stream": applicationOctetStream,
        "image/jpeg": imageJpeg,
        "text/plain": textPlain,
        "text/plain; charset=us-ascii": textPlainCharsetUsAscii,
        "application/rdf+xml": applicationRdfXml,
    };
}