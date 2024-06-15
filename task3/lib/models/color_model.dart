

class ColorsAll {
    int? page;
    int? perPage;
    int? total;
    int? totalPages;
    List<ColorModel>? data;
    Support? support;

    ColorsAll({
        this.page,
        this.perPage,
        this.total,
        this.totalPages,
        this.data,
        this.support,
    });

}

class ColorModel {
    int? id;
    String? name;
    int? year;
    String? color;
    String? pantoneValue;

    ColorModel({
        this.id,
        this.name,
        this.year,
        this.color,
        this.pantoneValue,
    });

}

class Support {
    String? url;
    String? text;

    Support({
        this.url,
        this.text,
    });

}
