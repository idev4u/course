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
    let tc = TrackController()
    var tracks = tc.tracks()
    
    router.get { req -> Future<View> in
        let board = Board(message: message, team: datasource.team, teamout: datasource.out, tracks: tracks)
        return try req.view().render("main", board )
    }
    // tracks
    // has to changed to put
    // "/tracks/<trackname>/update/owner/<ownername>
    router.group("tracks", String.parameter, "update" ) { group in
        group.get( "owner", String.parameter) { req -> Future<Response> in
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
        group.get("rotatein", String.parameter) { req -> Future<Response> in
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
    

    router.group("manage", "team") {group in
        group.get(){ req -> Future<View>in
            let allTeamMates = TeamMateDbModel.query(on: req).all()
            return allTeamMates.flatMap { mate in
                let content = ["teammatelist": mate]
                return try req.view().render("pages/manage/team/mates.leaf", content )
            }
            
        }
        group.get("mate"){ req -> Future<View> in
            let content = "hello"
            return try req.view().render("pages/add_teammates.leaf", content )
        }
        group.post("mate","add") { req -> Future<Response> in
            return try req.content.decode(TeamMate.self).map(to: Response.self) { teammate in
                print(teammate.name) // "Vapor"
                print(teammate.surename) // 3
                print(teammate.image?.filename ?? "ups no image") // Raw image data
                print(teammate.image?.data ?? "ups no image") // Raw image data
                print(teammate.isOut ?? true)
                let teamMateDidCreate = TeamMateDbModel.init(id: nil, name: teammate.name, surename: teammate.surename, image: teammate.image?.data.base64EncodedData(), isOut: false, assignedTrackId: nil)
                _ = teamMateDidCreate.create(on: req)
                return req.redirect(to: "/manage/team")
            }
            // FIXME: add error handling for files greater 1Mb
        
        }
        // mate/#(mate.id)/delete
        group.post("mate", TeamMateDbModel.parameter, "delete"){ req -> Future<Response> in
            return try req.parameters.next(TeamMateDbModel.self).flatMap { mate in
                return mate.delete(on: req).map { _ in
                    return req.redirect(to: "/manage/team")
                }
            }
        }
    }
    router.get("teamatesfromdb") { req in
        return TeamMateDbModel.query(on: req).all()
    }
}
