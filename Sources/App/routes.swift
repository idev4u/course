import Vapor

struct Board: Encodable {
    let message: String
    let team: [String]
}

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // "It works" page
    router.get { req -> Future<View> in
        let message = "Welcome to Course"
        let board = Board(message: message,team: ["Horst","Klaus","Gert"])
        return try req.view().render("main", board )
    }
    
    // Says hello
    router.get("hello", String.parameter) { req -> Future<View> in
        return try req.view().render("hello", [
            "name": req.parameters.next(String.self)
        ])
    }
}
