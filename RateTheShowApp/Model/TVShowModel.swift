//
//  TVShowModel.swift
//  RateTheShowApp
//
//  Created by Анна Никифорова on 14.04.2020.
//  Copyright © 2020 Анна Никифорова. All rights reserved.
//

import Foundation

struct TVShowData: Decodable {
    
    let results: [TVShowInfo]

}

struct TVShowInfo: Decodable {
    let name: String?
    let poster_path: String?
    let first_air_date: String?
    let genre_ids: [Int]
    let vote_average: Double?
}
