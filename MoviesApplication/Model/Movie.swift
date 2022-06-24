//
//  Languages.swift
//  MoviesApplication
//
//  Created by Mehmet Baturay Yasar on 23/06/2022.
//

import Foundation

struct Movie: Codable {
    var results:[FilmResult]?
}

// MARK: - FilmResult
struct FilmResult: Codable {
    let imageurl: [String]?
    let genre: [String]?
    let imdbid, title: String?
    let imdbrating: Double?
    let released: Int?
    let type, synopsis: String?
}
