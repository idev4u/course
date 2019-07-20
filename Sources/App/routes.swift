import Vapor

struct Board: Encodable {
    let message: String
    let team: Team
    let teamout: Team
    let tracks: [Track]
    
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
        let teamate4 = TeamMate(name: "Bernd", isOut: false)
        let teamate5 = TeamMate(name: "Paul", isOut: false)
        let teamate6 = TeamMate(name: "Heinrich", isOut: false)
        let teamate7 = TeamMate(name: "Richard", isOut: false)
        
        let team: Team = Team(team: [teamate1])
        let out: Team = Team(team: [teamate2,teamate3])
        
        // Tracks
        
        let track1 = Track(Owner: teamate4, NewMate: teamate5, TrackName: "Azure")
        let track2 = Track(Owner: teamate6, NewMate: teamate7, TrackName: "AWS")
        let board = Board(message: message, team: team, teamout: out, tracks: [track1,track2])
        return try req.view().render("main", board )
    }
    
    // Says hello
    router.get("hello", String.parameter) { req -> Future<View> in
        return try req.view().render("hello", [
            "name": req.parameters.next(String.self)
        ])
    }
}
