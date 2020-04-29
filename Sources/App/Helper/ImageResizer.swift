//
//  File.swift
//  App
//
//  Created by Norman Sutorius on 29.04.20.
//

import Foundation
import SwiftGD

class ImageResizer {
    func resizeImage(data: Data, mimeType: String ) -> Data {
        let image = try! Image(data: data, as: .jpg)
        let smallImage = image.resizedTo(height: 200)
        let smallImageAsData = try! smallImage!.export()
        return smallImageAsData
    }
}
