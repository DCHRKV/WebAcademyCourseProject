//
//  API.swift
//  WebAcademy Coursework
//
//  Created by Dmytro Churakov on 04.07.2022.
//

import Foundation

class API {
    
    var users: [User] = []
    
    let baseURL = URL(string: "https://randomuser.me/api/?format=json&results=20")!
    typealias CompletionHandler = (Error?) -> Void
    
    func getUsers(completion: @escaping CompletionHandler = { _ in }) {
        URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            if let error = error {
                print("Error getting users: \(error)")
            }
            guard let data = data else {
                print("No data returned from data task.")
                completion(nil)
                return
            }
            do {
                let newUsers = try JSONDecoder().decode(UserResult.self, from: data)
                print(newUsers)
                self.users = newUsers.results
            } catch {
                print("Error decoding users: \(error)")
                completion(error)
            }
            completion(nil)
        }.resume()
    }
    
    
}
