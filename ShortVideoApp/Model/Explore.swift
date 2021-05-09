//
//  Explore.swift
//  ShortVideoApp
//
//  Created by Biswajyoti Sahu on 06/05/21.
//

import Foundation

struct Expolre: Decodable {
    
    let title: String
    let nodes: [Node]
    
    enum CodingKeys: String, CodingKey {
        
        case title, nodes
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        nodes = try values.decodeIfPresent([Node].self, forKey: .nodes) ?? []
    }
}

struct Node: Decodable {
    
    let video: Video
    
    enum CodingKeys: String, CodingKey {
        
        case video
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        video = try values.decodeIfPresent(Video.self, forKey: .video) ?? Video()
    }
}

struct Video: Decodable {
    
    let encodeUrl: String
    
    enum CodingKeys: String, CodingKey {
        
        case encodeUrl
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        encodeUrl = try values.decodeIfPresent(String.self, forKey: .encodeUrl) ?? ""
    }
    
    init() {
        
        encodeUrl = ""
    }
}
