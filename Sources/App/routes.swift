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
    var datasource = TeamDataSource()
    let teammates = TeamMates()
    
    // Init Data
        
    // Tracks
    var track1 = Track(TrackId: 1, ContextOwner: teammates.teamate4, RotateInPerson: teammates.teamate5, TrackName: "Azure")
    var track2 = Track(TrackId: 2, ContextOwner: teammates.teamate6, RotateInPerson: teammates.teamate7, TrackName: "AWS")
    var track3 = Track(TrackId: 3, ContextOwner: teammates.teamate8, RotateInPerson: teammates.teamate3, TrackName: "Mongo")
    
    var tracks = [track1, track2, track3]
    
    router.get { req -> Future<View> in

        let board = Board(message: message, team: datasource.team, teamout: datasource.out, tracks: tracks)
        return try req.view().render("main", board )
    }
    
    // has to changed to put
    // "/<trackname>/update/owner/<ownername>
    router.get(String.parameter, "update", "owner", String.parameter) { req -> Future<Response> in
        //TrackIdentifier
        let trackname = try req.parameters.next(String.self)
        print("Log: trackname \(trackname)")
        print("Log: tracks \(tracks.debugDescription)")
        //array.filter {$0.eventID == id}.first?.added = value
        let idx:Int = tracks.firstIndex(where: { $0.TrackName == trackname})!
        
        // Load track from tracks array
        print("index of azure \(idx)")
        var tmpTrack = tracks[idx]
        //update Owner
        let NewOwner = try req.parameters.next(String.self)
        let indxOfTeamMate = datasource.allTeamMates.team.firstIndex(where: {$0.name == NewOwner})
        tmpTrack.ContextOwner = datasource.allTeamMates.team[indxOfTeamMate!]
        
        // Update new written track item
        tracks.remove(at: idx)
        tracks.insert(tmpTrack, at: idx)
        
        print("Log: after update tracks \(tracks.debugDescription)")
        
        // Return to main view
        return req.future().map() {
            return req.redirect(to: "/")
        }
    }
    
    // "/<trackname>/update/newmate/<ownername>
    router.get(String.parameter, "update", "rotatein", String.parameter) { req -> Future<Response> in
        //TrackIdentifier
        let trackname = try req.parameters.next(String.self)
        print("Log: trackname \(trackname)")
        print("Log: tracks \(tracks.debugDescription)")
        //array.filter {$0.eventID == id}.first?.added = value
        let idx:Int = tracks.firstIndex(where: { $0.TrackName == trackname})!
        
        // Load track from tracks array
        print("index of azure \(idx)")
        var tmpTrack = tracks[idx]
        //update Owner
        let RotatIn = try req.parameters.next(String.self)
        let indxOfTeamMate = datasource.allTeamMates.team.firstIndex(where: {$0.name == RotatIn})
        tmpTrack.RotateInPerson = datasource.allTeamMates.team[indxOfTeamMate!]
        
        // Update new written track item
        tracks.remove(at: idx)
        tracks.insert(tmpTrack, at: idx)
        
        print("Log: after update tracks \(tracks.debugDescription)")
        
        // Return to main view
        return req.future().map() {
            return req.redirect(to: "/")
        }
    }
    
    router.get("team", "mate", String.parameter, "out") { req -> Future<Response> in
        let teammateName = try req.parameters.next(String.self)
        let indxOfTeamMate = datasource.allTeamMates.team.firstIndex(where: {$0.name == teammateName})
        
        let teammate = datasource.allTeamMates.team[indxOfTeamMate!]
        print("log: \(teammate)")
        datasource.out.team.append(teammate)
        return req.future().map() {
            return req.redirect(to: "/")
        }
        
    }
    
}
