import Vapor
import Fluent

struct Board: Encodable {
    let message: String
    let team: Team
    let unassigned: Team
    let teamout: Team
    let tracks: Future<[Track]>
    let parkingLotTopcis: Future<[ParkingLotTopic]>
}

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // "It works" page
    let message = "Course"
//    var datasource = TeamDataSource()
    let tc = TrackController()
//    var tracks = tc.tracksA()
    
    router.get { req -> Future<View> in
        
        //Fetch mates from DB
        let allTeamMates = TeamMateDbModel.query(on: req).all()
        let allTeamMatesOut = TeamMateDbModel.query(on: req).filter(\.isOut, .equal, true).all()
        let unassignedMates = TeamMateDbModel.query(on: req).filter(\.isOut, .equal, false).filter(\.assignedTrackId, .is, nil).all()
        // transfer to View model
        let teamUnassigned = Team(team: unassignedMates)
        let teamIn = Team(team: allTeamMates)
        let teamOut = Team(team: allTeamMatesOut)
        // fetch Tracks
        let tracks = tc.tracksFromDB(req: req)
        // fetch Parking Lot Topics
        let parkingLotTopics = ParkingLotTopic.query(on: req).all()
        // prepare View Rendere Model
        let board = Board(message: message,team: teamIn, unassigned: teamUnassigned , teamout: teamOut, tracks: tracks, parkingLotTopcis: parkingLotTopics)
        return try req.view().render("main", board )
    }
    // tracks
    // has to changed to put
    // "/tracks/<trackname>/update/owner/<ownername>
    router.group("tracks", Track.parameter, "update" ) { group in
        group.get( "owner", TeamMateDbModel.parameter) { req -> Future<Response> in
            //TrackIdentifier
            return try req.parameters.next(Track.self).flatMap { track in
                return try req.parameters.next(TeamMateDbModel.self).flatMap { mate in
                    var updateTrack = track
                    var updateMate = mate
                    updateMate.isOut = false
                    var oldContextOnwer = track.ContextOwner
                    oldContextOnwer?.assignedTrackId = nil
                    oldContextOnwer?.save(on: req)
                    let mateReferenzId = updateMate.assignedTrackId ?? 0 // if there is no track assigned this will 0
                    // delete referenz
                    
                    // If the Trackreferenz is not 0, then delete the predecessor references
                    if mateReferenzId != 0 && mateReferenzId != updateTrack.id {
                        let trackWhereUserIsAssgined = Track.find(mateReferenzId, on: req)
                        _ = trackWhereUserIsAssgined.map(to: Track.self){ trackWithMateReferenz in
                            var trackWithoutMateReferenz = trackWithMateReferenz
                            if trackWithMateReferenz?.ContextOwner?.id == mate.id {
                                trackWithoutMateReferenz?.ContextOwner = nil
                            }
                            if trackWithMateReferenz?.RotateInPerson?.id == mate.id {
                                trackWithoutMateReferenz?.RotateInPerson = nil
                            }
                            trackWithoutMateReferenz?.save(on: req)
                            return trackWithoutMateReferenz!
                        }
                    }
                    
                    // remove rotate in referenz, cause mate is now owenr for the same track
                    if updateMate.assignedTrackId == updateTrack.id {
                        print("huhu")
                        updateTrack.ContextOwner = updateMate
                        if updateTrack.RotateInPerson?.id == updateMate.id {
                            print("huhu take the ownership")
                            updateTrack.RotateInPerson = nil
                        }
                    }
                    
                    // update referenz
                    updateMate.assignedTrackId = updateTrack.id
                    updateMate.save(on: req)
                    updateTrack.ContextOwner = updateMate
                    return updateTrack.update(on: req).map { mate in
                        return req.redirect(to: "/")
                    }
                }
                
            }
            
        }
        group.get("rotatein", TeamMateDbModel.parameter) { req -> Future<Response> in
            return try req.parameters.next(Track.self).flatMap { track in
                return try req.parameters.next(TeamMateDbModel.self).flatMap { mate in
                    var updateTrack = track
                    var updateMate = mate
                    updateMate.isOut = false
                    var oldRotateIn = track.RotateInPerson
                    oldRotateIn?.assignedTrackId = nil
                    oldRotateIn?.save(on: req)
                    
                    let mateReferenzId = updateMate.assignedTrackId ?? 0 // if there is no track assigned this will 0
                    // delete referenz
                    
                    // If the Trackreferenz is not 0, then delete the predecessor references
                    if mateReferenzId != 0 && mateReferenzId != updateTrack.id {
                        let trackWhereUserIsAssgined = Track.find(mateReferenzId, on: req)
                        _ = trackWhereUserIsAssgined.map(to: Track.self){ trackWithMateReferenz in
                            var trackWithoutMateReferenz = trackWithMateReferenz
                            if trackWithMateReferenz?.ContextOwner?.id == mate.id {
                                trackWithoutMateReferenz?.ContextOwner = nil
                            }
                            if trackWithMateReferenz?.RotateInPerson?.id == mate.id {
                                trackWithoutMateReferenz?.RotateInPerson = nil
                            }
                            let result = trackWithoutMateReferenz?.save(on: req)
                            print(result.debugDescription)
                            return trackWithoutMateReferenz!
                        }
                    }
                    // remove rotate in referenz, cause mate is now owenr for the same track
                    if updateMate.assignedTrackId == updateTrack.id {
                        print("huhu")
                        updateTrack.RotateInPerson = updateMate
                        if updateTrack.ContextOwner?.id == updateMate.id {
                            print("huhu take the ownership")
                            updateTrack.ContextOwner = nil
                        }
                    }
                    // update referenz
                    updateMate.assignedTrackId = updateTrack.id
                    updateMate.save(on: req)
                    updateTrack.RotateInPerson = mate
                    return updateTrack.update(on: req).map { mate in
                        return req.redirect(to: "/")
                    }
                }
            }
        }
    }

    // out view
    router.get("team", "mate", TeamMateDbModel.parameter, "out") { req -> Future<Response> in
        // mark the mate that he is out
        // TDOO: Remove Trackid
        return try req.parameters.next(TeamMateDbModel.self).flatMap { mate in
            var updateMate = mate
            updateMate.isOut = true
            let trackReferenzId = updateMate.assignedTrackId ?? 0 // if there is no track assigned this will 0
                        
            // If the Trackreferenz is not 0, then delete the predecessor references
            if trackReferenzId != 0 {
                let trackWhereUserIsAssgined = Track.find(trackReferenzId, on: req)
                _ = trackWhereUserIsAssgined.map(to: Track.self){ trackWithMateReferenz in
                    var trackWithoutMateReferenz = trackWithMateReferenz
                    if trackWithMateReferenz?.ContextOwner?.id == mate.id {
                        trackWithoutMateReferenz?.ContextOwner = nil
                    }
                    if trackWithMateReferenz?.RotateInPerson?.id == mate.id {
                        trackWithoutMateReferenz?.RotateInPerson = nil
                    }
                    let result = trackWithoutMateReferenz?.save(on: req)
                    print(result.debugDescription)
                    return trackWithoutMateReferenz!
                }
            }
            return updateMate.update(on: req).map { mate in
                return req.redirect(to: "/")
            }
        }

    }
    

    router.group("manage", "team") {group in
        group.get(){ req -> Future<View>in
            let allTeamMates = TeamMateDbModel.query(on: req).all()
            return allTeamMates.flatMap { mate in
                let content = ["teammatelist": mate]
                return try req.view().render("pages/manage/team/mates/list.leaf", content )
            }
            
        }
        group.get("mate"){ req -> Future<View> in
            let content = "hello"
            return try req.view().render("pages/manage/team/mates/add.leaf", content )
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
    
    // Manage Tracks
    router.group("manage","tracks") {group in
        group.get() { req -> Future<View> in
            let allTracks = Track.query(on: req).all()
            return allTracks.flatMap { track in
                let tracks = ["tracklist": track]
                return try req.view().render("pages/manage/tracks/tracks.leaf", tracks)
            }
            
        }
        group.post("add"){req -> Future<Response> in
            return try req.content.decode(Track.self).map(to: Response.self) { track in
                let didCreateTrack = track.create(on: req)
                print(didCreateTrack)
                return req.redirect(to: "/manage/tracks")
            }

        }
        // track/#(mate.id)/delete
        group.post("track", Track.parameter, "delete"){ req -> Future<Response> in
            return try req.parameters.next(Track.self).flatMap { track in
                return track.delete(on: req).map { _ in
                    return req.redirect(to: "/manage/tracks")
                }
            }
        }
    }
    // Parking Lot
    router.group("parkinglot","topics") {group in
//        group.get() { req -> Future<View> in
//            let allTracks = ParkingLotTopic.query(on: req).all()
//            return allTracks.flatMap { track in
//                let tracks = ["tracklist": track]
//                return try req.view().render("pages/manage/tracks/tracks.leaf", tracks)
//            }
//
//        }
        group.post("topic","add"){req -> Future<Response> in
            return try req.content.decode(ParkingLotTopic.self).map(to: Response.self) { topic in
                print(topic.topic!)
                let didCreateTrack = topic.create(on: req)
                print(didCreateTrack)
                return req.redirect(to: "/")
            }

        }
        // track/#(mate.id)/delete
        group.post("topic", ParkingLotTopic.parameter, "delete"){ req -> Future<Response> in
            return try req.parameters.next(ParkingLotTopic.self).flatMap { topic in
                return topic.delete(on: req).map { _ in
                    return req.redirect(to: "/")
                }
            }
        }
    }
    
}
