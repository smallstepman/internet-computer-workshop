actor {
    public func location(cities : [Text]) : async Text {
        return "Hello, " # (debug_show cities) # "!";
    };

    public func location_pretty(cities : [Text]) : async Text {
        var str = "hello from ";
        for (city in cities.vals()) {
            str := str # city #", ";
        };
        return str # "bon voyage!";
    }
};
