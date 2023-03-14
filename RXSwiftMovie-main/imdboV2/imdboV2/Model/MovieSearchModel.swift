//
//  SearchModel.swift

import Foundation

struct MovieSearchModel: Codable {
    let  totalResults: String
    let response : String
    let search : [ListResult]

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"

    }
    
}


struct ListResult:Codable {
    let title: String
    let year : String
    let imdbID : String
    let type : String
    let poster : String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID = "imdbID"
        case type = "Type"
        case poster = "Poster"
    }
    
}
