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
    var dob: Dob
    var phone: String
    var gender: String
    var email: String
}

struct Name: Decodable {
    var title: String
    var first: String
    var last: String
}

struct Dob: Decodable {
    var date: String
}

struct Picture: Decodable {
    var thumbnail: URL
    var medium: URL
    var large: URL
}
