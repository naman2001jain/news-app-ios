//
//  OnEverythingApiResponse.swift
//  news app
//
//  Created by Naman Jain on 26/08/21.
//

import Foundation
struct ApiResponse:Codable {
    let status: String?
    let totalResults: Int
    let articles: [Article]
}


struct Article:Codable {
//    let source: Source
//    let author: String?
    let title: String?
//    let description: String?
//    let url: String?
//    let urlToImage: String?
//    let content: String?
}


struct Source:Codable {
    let id: String
    let name: String
}
