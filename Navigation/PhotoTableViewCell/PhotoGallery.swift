//
//  FotoGallery.swift
//  Navigation
//
//  Created by new owner on 04.03.2023.
//

import UIKit

struct PhotoGallery {

    static func setupGallery() -> [ImageGallery] {
        [
            .init(id: 1, imageName: "van gog house and plowman"),
            .init(id: 2, imageName: "shishkin mishki"),
            .init(id: 3, imageName: "sezanne"),
            .init(id: 4, imageName: "serov"),
            .init(id: 5, imageName: "renoir"),
            .init(id: 6, imageName: "renoir girl"),
            .init(id: 7, imageName: "pissaro"),
            .init(id: 8, imageName: "piero and arlekin"),
            .init(id: 9, imageName: "pereda"),
            .init(id: 10, imageName: "mone"),
            .init(id: 11, imageName: "matisse wooman"),
            .init(id: 12, imageName: "malevich"),
            .init(id: 13, imageName: "levitan"),
            .init(id: 14, imageName: "lemoh"),
            .init(id: 15, imageName: "kustodiev"),
            .init(id: 16, imageName: "kranah"),
            .init(id: 17, imageName: "kent"),
            .init(id: 18, imageName: "karavajo"),
            .init(id: 19, imageName: "kandinckyVl"),
            .init(id: 20, imageName: "kandincky"),
            .init(id: 21, imageName: "gogen"),
            .init(id: 22, imageName: "geinsboro"),
            .init(id: 23, imageName: "boticelli"),
            .init(id: 24, imageName: "aivazovskiy"),
            .init(id: 25, imageName: "absent"),
            .init(id: 26, imageName: "matisse"),
        ]
    }

    static func randomPhotos(with count: Int) -> [ImageGallery] {
        return (0..<count).map { _ in setupGallery().randomElement()! }
    }
}

struct ImageGallery {
    let id: Int
    let imageName: String
}

struct SectionPhoto {
    let sectionName: String
    var photos: [ImageGallery]
}
