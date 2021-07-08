//
//  Network.swift
//  Pryaniky
//
//  Created by Сэнди Белка on 07.07.2021.
//

import Foundation

final class NetworkManager {
    
    public func fetchData(completion: @escaping (NetworkModel) -> ()) {
        
        guard let url = URL(string: "https://pryaniky.com/static/json/sample.json") else {
            print("Something went wrong: URL error")
            return
        }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil, let data = data else {
                print("Something went wrong: \(String(describing: error?.localizedDescription))")
                return
            }
            do {
                let storedData = try JSONDecoder().decode(NetworkModel.self, from: data)
                completion(storedData)
            } catch {
                print("Something went wrong: \(error.localizedDescription)")
            }
        }.resume()
    }

}

struct NetworkModel: Codable {
    let data: [DataModel]
    let view: [String]
}

struct DataModel: Codable {
    let name: String
    let data: StoredData
}

struct StoredData: Codable {
    let url: String?
    let text: String?
    let selectedId: Int?
    let variants: [Variants]?
}

struct Variants: Codable {
    let id: Int
    let text: String
}
