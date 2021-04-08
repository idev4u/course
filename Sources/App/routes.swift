import Vapor
import Fluent


struct Board: Encodable {
    let message: String
    let team: Team
    let unassigned: Team
    let teamout: Team
    let tracks: [Track]
    let parkingLotTopcis: [ParkingLotTopic]
}

/// Register your application's routes here.
public func routes(_ app: Application) throws {
    // "It works" page
//    let message = "Course"
////    var datasource = TeamDataSource()
//    let tc = TrackController()
////    var tracks = tc.tracksA()
    app.get("info"){ req -> String in
        return "huhu"
    }
    app.get() { req -> EventLoopFuture<View> in
        //Fetch mates from DB
        
        let allTeamMates = TeamMateDbModel.query(on: req.db).all()
        let allTeamMatesOut = TeamMateDbModel.query(on: req.db).filter(\.$isOut == true).all()
        let unassignedMates = TeamMateDbModel.query(on: req.db).filter(\.$isOut == false).filter(\.$assignedTrackId == nil).all() //
       // transfer to View model
//        let uM:Array = unassignedMates.map { tdbmodel in
//            return []
//        }
//        let teamUnassigned = Team(team: uM)
//        let teamIn = Team(team: allTeamMates)
//        let teamOut = Team(team: allTeamMatesOut)
//        // fetch Tracks
//        let tracks = tc.tracksFromDB(req: req)
//        // fetch Parking Lot Topics
//        let parkingLotTopics = ParkingLotTopic.query(on: req.db).sort(\.$id, .ascending).all()
//        // prepare View Rendere Model
////        let board = Board(message: message,team: teamIn, unassigned: teamUnassigned , teamout: teamOut, tracks: tracks, parkingLotTopcis: parkingLotTopics)
//        let board = Board(message: message,team: teamIn, unassigned: teamUnassigned , teamout: teamOut, tracks: tracks, parkingLotTopcis: parkingLotTopics)
//        let b = Board(message: "String", team: Team(team: allTeamMates), unassigned: Team(team: unassignedMates), teamout: Team(team: allTeamMatesOut), tracks: [], parkingLotTopcis: [])
////
//        return req.view.render("main", b)
        return allTeamMates.and(unassignedMates).flatMap { aTM, uAM in
            let b = Board(message: "String", team: Team(team: aTM), unassigned: Team(team: uAM), teamout: Team(team: []), tracks: [], parkingLotTopcis: [])
            return req.view.render("main", b)
        }
    }
    // tracks
    // has to changed to put
    // "/tracks/<trackname>/update/owner/<ownername>
//    app.group("tracks", ":trackname", "update" ) { group in
//        group.get( "owner", ":ownername") { req -> EventLoopFuture<Response> in
//            //TrackIdentifier
//            return try req.parameters.next(Track.self).flatMap { track in
//                return try req.parameters.next(TeamMateDbModel.self).flatMap { mate in
//                    var updateTrack = track
//                    var updateMate = mate
//                    updateMate.isOut = false
//                    var oldContextOnwer = track.ContextOwner
//                    oldContextOnwer?.assignedTrackId = nil
//                    oldContextOnwer?.save(on: req)
//                    let mateReferenzId = updateMate.assignedTrackId ?? 0 // if there is no track assigned this will 0
//                    // delete referenz
//
//                    // If the Trackreferenz is not 0, then delete the predecessor references
//                    if mateReferenzId != 0 && mateReferenzId != updateTrack.id {
//                        let trackWhereUserIsAssgined = Track.find(mateReferenzId, on: req)
//                        _ = trackWhereUserIsAssgined.map(to: Track.self){ trackWithMateReferenz in
//                            var trackWithoutMateReferenz = trackWithMateReferenz
//                            if trackWithMateReferenz?.ContextOwner?.id == mate.id {
//                                trackWithoutMateReferenz?.ContextOwner = nil
//                            }
//                            if trackWithMateReferenz?.RotateInPerson?.id == mate.id {
//                                trackWithoutMateReferenz?.RotateInPerson = nil
//                            }
//                            trackWithoutMateReferenz?.save(on: req)
//                            return trackWithoutMateReferenz!
//                        }
//                    }
//
//                    // remove rotate in referenz, cause mate is now owenr for the same track
//                    if updateMate.assignedTrackId == updateTrack.id {
//                        print("huhu")
//                        updateTrack.ContextOwner = updateMate
//                        if updateTrack.RotateInPerson?.id == updateMate.id {
//                            print("huhu take the ownership")
//                            updateTrack.RotateInPerson = nil
//                        }
//                    }
//
//                    // update referenz
//                    updateMate.assignedTrackId = updateTrack.id
//                    updateMate.save(on: req)
//                    updateTrack.ContextOwner = updateMate
//                    return updateTrack.update(on: req).map { mate in
//                        return req.redirect(to: "/#pairs")
//                    }
//                }
//
//            }
//
//        }
//        group.get("rotatein", TeamMateDbModel.parameter) { req -> EventLoopFuture<Response> in
//            return try req.parameters.next(Track.self).flatMap { track in
//                return try req.parameters.next(TeamMateDbModel.self).flatMap { mate in
//                    var updateTrack = track
//                    var updateMate = mate
//                    updateMate.isOut = false
//                    var oldRotateIn = track.RotateInPerson
//                    oldRotateIn?.assignedTrackId = nil
//                    oldRotateIn?.save(on: req)
//
//                    let mateReferenzId = updateMate.assignedTrackId ?? 0 // if there is no track assigned this will 0
//                    // delete referenz
//
//                    // If the Trackreferenz is not 0, then delete the predecessor references
//                    if mateReferenzId != 0 && mateReferenzId != updateTrack.id {
//                        let trackWhereUserIsAssgined = Track.find(mateReferenzId, on: req)
//                        _ = trackWhereUserIsAssgined.map(to: Track.self){ trackWithMateReferenz in
//                            var trackWithoutMateReferenz = trackWithMateReferenz
//                            if trackWithMateReferenz?.ContextOwner?.id == mate.id {
//                                trackWithoutMateReferenz?.ContextOwner = nil
//                            }
//                            if trackWithMateReferenz?.RotateInPerson?.id == mate.id {
//                                trackWithoutMateReferenz?.RotateInPerson = nil
//                            }
//                            let result = trackWithoutMateReferenz?.save(on: req)
//                            print(result.debugDescription)
//                            return trackWithoutMateReferenz!
//                        }
//                    }
//                    // remove rotate in referenz, cause mate is now owenr for the same track
//                    if updateMate.assignedTrackId == updateTrack.id {
//                        print("huhu")
//                        updateTrack.RotateInPerson = updateMate
//                        if updateTrack.ContextOwner?.id == updateMate.id {
//                            print("huhu take the ownership")
//                            updateTrack.ContextOwner = nil
//                        }
//                    }
//                    // update referenz
//                    updateMate.assignedTrackId = updateTrack.id
//                    updateMate.save(on: req)
//                    updateTrack.RotateInPerson = mate
//                    return updateTrack.update(on: req).map { mate in
//                        return req.redirect(to: "/#pairs")
//                    }
//                }
//            }
//        }
//    }
//
//    // out view
//    app.get("team", "mate", TeamMateDbModel.parameter, "out") { req -> EventLoopFuture<Response> in
//        // mark the mate that he is out
//        // TDOO: Remove Trackid
//        return try req.parameters.next(TeamMateDbModel.self).flatMap { mate in
//            var updateMate = mate
//            updateMate.isOut = true
//            let trackReferenzId = updateMate.assignedTrackId ?? 0 // if there is no track assigned this will 0
//
//            // If the Trackreferenz is not 0, then delete the predecessor references
//            if trackReferenzId != 0 {
//                let trackWhereUserIsAssgined = Track.find(trackReferenzId, on: req)
//                _ = trackWhereUserIsAssgined.map(to: Track.self){ trackWithMateReferenz in
//                    var trackWithoutMateReferenz = trackWithMateReferenz
//                    if trackWithMateReferenz?.ContextOwner?.id == mate.id {
//                        trackWithoutMateReferenz?.ContextOwner = nil
//                    }
//                    if trackWithMateReferenz?.RotateInPerson?.id == mate.id {
//                        trackWithoutMateReferenz?.RotateInPerson = nil
//                    }
//                    let result = trackWithoutMateReferenz?.save(on: req)
//                    print(result.debugDescription)
//                    return trackWithoutMateReferenz!
//                }
//            }
//            return updateMate.update(on: req).map { mate in
//                return req.redirect(to: "/")
//            }
//        }
//
//    }
//
//
//    app.group("manage", "team") {group in
//        group.get(){ req -> EventLoopFuture<View>in
//            let allTeamMates = TeamMateDbModel.query(on: req.db).all()
//            return try req.view.render("pages/manage/team/mates/list.leaf", allTeamMates )
////            return allTeamMates.flatMap { mate in
////                let content = ["teammatelist": mate]
////                return try req.view.render("pages/manage/team/mates/list.leaf", content )
//////                return req.view.render("hello", ["name": "Leaf"])
////            }
//
//        }
//        group.get("mate"){ req -> EventLoopFuture<View> in
//            let content = "hello"
//            return try req.view().render("pages/manage/team/mates/add.leaf", content )
//        }
//        group.post("mate","add") { req -> EventLoopFuture<Response> in
//            return try req.content.decode(TeamMate.self).map(to: Response.self) { teammate in
//                print(teammate.name) // "Vapor"
//                print(teammate.surename) // 3
//                print(teammate.image?.filename ?? "ups no image") // Raw image data
//                print(teammate.image?.data ?? "ups no image") // Raw image data
//                print(teammate.image?.contentType ?? "ups no image")
//                print(teammate.isOut ?? true)
//                // Resize the image to
//                let ir = ImageResizer()
//                let smalldata = ir.resizeImage(data: teammate.image!.data, mediaType: (teammate.image?.contentType)! )
//
//                let teamMateDidCreate = TeamMateDbModel.init(id: nil, name: teammate.name, surename: teammate.surename, image: smalldata.base64EncodedData(), isOut: false, assignedTrackId: nil)
//                _ = teamMateDidCreate.create(on: req)
//                return req.redirect(to: "/manage/team")
//            }
//        }
//        // mate/#(mate.id)/delete
//        group.post("mate", TeamMateDbModel.parameter, "delete"){ req -> EventLoopFuture<Response> in
//            return try req.parameters.next(TeamMateDbModel.self).flatMap { mate in
//
//                let trackRemoveMate = Track.query(on: req).filter(\.id == mate.assignedTrackId).first()
//                _ = trackRemoveMate.map { track in
//                    var ut = track
//                    if (ut?.ContextOwner?.id == mate.id) {
//                        ut?.ContextOwner = nil
//                    } else {
//                        ut?.RotateInPerson = nil
//                    }
//                    _ = ut?.update(on: req)
//                }
//                return mate.delete(on: req).map { _ in
//                    return req.redirect(to: "/manage/team")
//                }
//            }
//        }
//    }
//
//    // Manage Tracks
//    app.group("manage","tracks") {group in
//        group.get() { req -> EventLoopFuture<View> in
//            let allTracks = Track.query(on: req).all()
//            return allTracks.flatMap { track in
//                let tracks = ["tracklist": track]
//                return try req.view().render("pages/manage/tracks/tracks.leaf", tracks)
//            }
//
//        }
//        group.post("add"){req -> EventLoopFuture<Response> in
//            return try req.content.decode(Track.self).map(to: Response.self) { track in
//                let didCreateTrack = track.create(on: req)
//                print(didCreateTrack)
//                return req.redirect(to: "/manage/tracks")
//            }
//
//        }
//        // track/#(mate.id)/delete
//        group.post("track", Track.parameter, "delete"){ req -> EventLoopFuture<Response> in
//            return try req.parameters.next(Track.self).flatMap { track in
//                var co = track.ContextOwner
//                var ri = track.RotateInPerson
//                co?.assignedTrackId = nil
//                ri?.assignedTrackId = nil
//                _ = co?.update(on: req)
//                _ = ri?.update(on: req)
//                return track.delete(on: req).map { _ in
//                    return req.redirect(to: "/manage/tracks")
//                }
//            }
//        }
//    }
//    // Parking Lot
//    app.group("parkinglot","topics") {group in
//
//        group.post("topic","add"){req -> EventLoopFuture<Response> in
//            return try req.content.decode(ParkingLotTopic.self).map(to: Response.self) { topic in
//                print(topic.topic!)
//                var newTopic = topic
//                newTopic.state = false
//                let didCreateTrack = newTopic.create(on: req)
//                print(didCreateTrack)
//                return req.redirect(to: "/#parkinglot")
//            }
//
//        }
//        group.post("topic", ParkingLotTopic.parameter, "update"){ req -> EventLoopFuture<Response> in
//            return try req.parameters.next(ParkingLotTopic.self).flatMap { topic in
//                var updateTopic = topic
//                if topic.state! {
//                    updateTopic.state = false
//                } else {
//                    updateTopic.state = true
//                }
//                return updateTopic.update(on: req).map { _ in
//                    return req.redirect(to: "/#parkinglot")
//                }
//            }
//        }
//
//        group.post("topic", ParkingLotTopic.parameter, "delete"){ req -> EventLoopFuture<Response> in
//            return try req.parameters.next(ParkingLotTopic.self).flatMap { topic in
//                return topic.delete(on: req).map { _ in
//                    return req.redirect(to: "/#parkinglot")
//                }
//            }
//        }
//        group.post("delete"){ req -> EventLoopFuture<Response> in
//            return ParkingLotTopic.query(on: req.db).delete().map { _ in
//                    return req.redirect(to: "/#parkinglot")
//                }
//
//        }
//    }
    
}
