//
//  File.swift
//  App
//
//  Created by Norman Sutorius on 29.04.20.
//

import Foundation
import SwiftGD
import Vapor

/*
 public static let jpeg = MediaType(type: "image", subType: "jpeg")
 /// PNG image.
 public static let png = MediaType(type: "image", subType: "png")
 */

class ImageResizer {
    func resizeImage(data: Data, mediaType: MediaType ) -> Data {
        var image:Image? = nil
        if mediaType.subType == "jpeg" {
          image = try! Image(data: data, as: .jpg)
        }
        if mediaType.subType == "png" {
          image = try! Image(data: data, as: .png)
        }
        
        let smallImage = image?.resizedTo(height: 250)
        let smallImageAsData = try! smallImage!.export()
        return smallImageAsData
    }
}
