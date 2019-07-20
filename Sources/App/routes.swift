import Vapor

struct Board: Encodable {
    let message: String
    let team: Team
}

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // "It works" page
    router.get { req -> Future<View> in
        let message = "Welcome to Course"
        
        // Init Data
        let teamate1 = TeamMate(name: "Horst", isOut: true)
        let teamate2 = TeamMate(name: "Klaus", isOut: false)
        let teamate3 = TeamMate(name: "Gerd", isOut: false)
        let team: Team = Team(team: [teamate1,teamate2,teamate3])
        let board = Board(message: message, team: team)
        return try req.view().render("main", board )
    }
    
    // Says hello
    router.get("hello", String.parameter) { req -> Future<View> in
        return try req.view().render("hello", [
            "name": req.parameters.next(String.self)
        ])
    }
}
