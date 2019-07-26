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
    let teamate1 = TeamMate(name: "Horst", isOut: true, assingedTrackId: nil)
    let teamate2 = TeamMate(name: "Klaus", isOut: false, assingedTrackId: nil)
    let teamate3 = TeamMate(name: "Gerd", isOut: false, assingedTrackId: nil)
    let teamate4 = TeamMate(name: "Bernd", isOut: false , assingedTrackId: 1)
    let teamate5 = TeamMate(name: "Paul", isOut: false, assingedTrackId: 1)
    let teamate6 = TeamMate(name: "Heinrich", isOut: false, assingedTrackId: 2)
    let teamate7 = TeamMate(name: "Richard", isOut: false, assingedTrackId: 2)
    let teamate8 = TeamMate(name: "Ludwig", isOut: false, assingedTrackId: 3)
    
    var allTeamMates: Team = Team(team: [teamate1,teamate2,teamate3,teamate4,teamate5,teamate6,teamate7,teamate8])
    let team: Team = Team(team: [teamate1, teamate4, teamate8])
    var out: Team = Team(team: [teamate2,teamate3])
    
    // Tracks
    var track1 = Track(TrackId: 1, ContextOwner: teamate4, RotateInPerson: teamate5, TrackName: "Azure")
    var track2 = Track(TrackId: 2, ContextOwner: teamate6, RotateInPerson: teamate7, TrackName: "AWS")
    var track3 = Track(TrackId: 3, ContextOwner: teamate8, RotateInPerson: teamate3, TrackName: "Mongo")
    
    var tracks = [track1, track2, track3]
    
    router.get { req -> Future<View> in

        let board = Board(message: message, team: team, teamout: out, tracks: tracks)
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
        let indxOfTeamMate = allTeamMates.team.firstIndex(where: {$0.name == NewOwner})
        tmpTrack.ContextOwner = allTeamMates.team[indxOfTeamMate!]
        
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
        let indxOfTeamMate = allTeamMates.team.firstIndex(where: {$0.name == RotatIn})
        tmpTrack.RotateInPerson = allTeamMates.team[indxOfTeamMate!]
        
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
        let indxOfTeamMate = allTeamMates.team.firstIndex(where: {$0.name == teammateName})
        
        let teammate = allTeamMates.team[indxOfTeamMate!]
        print("log: \(teammate)")
        out.team.append(teammate)
        return req.future().map() {
            return req.redirect(to: "/")
        }
        
    }
    
}
