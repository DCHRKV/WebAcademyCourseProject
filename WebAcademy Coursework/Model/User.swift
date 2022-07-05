//
//  User.swift
//  WebAcademy Coursework
//
//  Created by Dmytro Churakov on 04.07.2022.
//




import Foundation
import UIKit

struct UserResult: Decodable {
    let results: [User]
}

struct User: Decodable {
    var name: Name
    var picture: Picture
}

struct Name: Decodable {
    var title: String
    var first: String
    var last: String
}

struct Picture: Decodable {
    var thumbnail: URL
    var medium: URL
    var large: URL
}
