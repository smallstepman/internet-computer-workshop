actor TestMe {
    public func greet(name : Text) : async Text {
        return "Hello, " # name # "!";
    };
};
