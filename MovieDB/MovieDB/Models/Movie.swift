//
//  Movie.swift
//  MovieDB
//
//  Created by Sayalee Pote on 04/05/21.
//

import Foundation

struct Movie: Decodable {
    let title: String?
    let imageHref: String?
    let rating: Double?
    let releaseDate: String?
}

struct DecodedArray: Decodable {
    let movies: [Movie]
}
