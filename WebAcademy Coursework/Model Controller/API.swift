//
//  API.swift
//  WebAcademy Coursework
//
//  Created by Dmytro Churakov on 04.07.2022.
//

import Foundation

class API {
    
    static let shared = API()
    private var currentPage = 1
    let baseURL = "https://randomuser.me/api/"
    
    func getUsers(completion: @escaping ([User])->(Void)) {
        let urlString = baseURL + "?" + "format=json" + "&" + "results=20" + "&" + "page=" + String(self.currentPage)
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error getting users: \(error)")
            }
            guard let data = data else {
                print("No data returned from data task.")
                return
            }
            do {
                let newUsers = try JSONDecoder().decode(UserResult.self, from: data)
                print(newUsers)
                self.currentPage += 1
                completion(newUsers.results)
            } catch {
                print("Error decoding users: \(error)")
            }
        }.resume()
    }
    
    
}
