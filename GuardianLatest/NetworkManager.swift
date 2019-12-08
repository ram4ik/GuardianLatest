//
//  NetworkManager.swift
//  GuardianLatest
//
//  Created by Ramill Ibragimov on 08.12.2019.
//  Copyright © 2019 Ramill Ibragimov. All rights reserved.
//

import Foundation

let endpointLink = "https://content.guardianapis.com/search?api-key=2f56e020-c276-4788-8b03-3a6d49048e81"

struct PageContent: Decodable {
    let response: Response?
}

struct Response: Decodable {
    let status: String?
    let userTier: String?
    let total: Int?
    let startIndex: Int?
    let pageSize: Int?
    let currentPage: Int?
    let pages: Int?
    let orderBy: String?
    let results: [Item]
}

struct Item: Decodable {
    let id: UUID = UUID()
    let _id: String?
    let type: String?
    let sectionID: String?
    let sectionName: String?
    let webPublicationDate: String?
    let webTitle: String?
    let webUrl: String?
    let apiUrl: String?
    let isHosted: Bool?
    let pillarId: String?
    let pillarName: String?
}

class NetworkManager {
    
    static func fetchAllPages(_ path: String? = nil, completionHandler: @escaping (PageContent) -> Void) {
        if let url = URL.init(string: path ?? endpointLink) {
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if let page: PageContent = try? JSONDecoder().decode(PageContent.self, from: data!) {
                    completionHandler(page)
                } else {
                    print("No data!")
                }
            })
            task.resume()
        }
    }
}
