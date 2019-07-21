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
    let message = "Welcome to Course"
    
    // Init Data
    
    // Team
    let teamate1 = TeamMate(name: "Horst", isOut: true)
    let teamate2 = TeamMate(name: "Klaus", isOut: false)
    let teamate3 = TeamMate(name: "Gerd", isOut: false)
    let teamate4 = TeamMate(name: "Bernd", isOut: false)
    let teamate5 = TeamMate(name: "Paul", isOut: false)
    let teamate6 = TeamMate(name: "Heinrich", isOut: false)
    let teamate7 = TeamMate(name: "Richard", isOut: false)
    let teamate8 = TeamMate(name: "Ludwig", isOut: false)
    
    let team: Team = Team(team: [teamate1, teamate4, teamate8])
    let out: Team = Team(team: [teamate2,teamate3])
    
    // Tracks
    var track1 = Track(Owner: teamate4, NewMate: teamate5, TrackName: "Azure")
    var track2 = Track(Owner: teamate6, NewMate: teamate7, TrackName: "AWS")
    
    var tracks = [track1, track2]
    
    router.get { req -> Future<View> in

        let board = Board(message: message, team: team, teamout: out, tracks: tracks)
        return try req.view().render("main", board )
    }
    
    // has to changed to put
    router.get("track", "owner", "update", String.parameter) { req -> Future<Response> in
        track1.Owner = teamate8
        
        print("Log: tracks \(tracks.debugDescription)")
        //array.filter {$0.eventID == id}.first?.added = value
        let idx:Int = tracks.firstIndex(where: { $0.TrackName == "Azure"})!
        print("index of azure \(idx)")
        tracks.remove(at: idx)
        tracks.insert(track1, at: idx)
        
        print("Log: after update tracks \(tracks.debugDescription)")
        
        print("Log: \(try req.parameters.next(String.self))")
        return req.future().map() {
            return req.redirect(to: "/")
        }
    }
    
}
