//
//  YoutubeSearchResponse.swift
//  NetflixClone
//
//  Created by Vo Le Dinh Nghi on 11/04/2023.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [videoElement]
}

struct videoElement: Codable{
    let id: IdVideoElement
}

struct IdVideoElement: Codable{
    let kind: String
    let videoId: String
}
