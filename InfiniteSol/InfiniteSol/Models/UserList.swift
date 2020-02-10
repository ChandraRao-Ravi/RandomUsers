//
//  UserList.swift
//  InfiniteSol
//
//  Created by Chandra Rao on 09/02/20.
//  Copyright © 2020 Chandra Rao. All rights reserved.
//

import Foundation

struct UserList : Codable {
    let results : [Results]?
    let info : Info?
    
    enum CodingKeys: String, CodingKey {
        
        case results = "results"
        case info = "info"
    }
    
}

struct Results : Codable {
    let gender : String?
    let name : Name?
    let location : Location?
    let email : String?
    let login : Login?
    let dob : Dob?
    let registered : Registered?
    let phone : String?
    let cell : String?
    let id : Id?
    let picture : Picture?
    let nat : String?
    
    enum CodingKeys: String, CodingKey {
        
        case gender = "gender"
        case name = "name"
        case location = "location"
        case email = "email"
        case login = "login"
        case dob = "dob"
        case registered = "registered"
        case phone = "phone"
        case cell = "cell"
        case id = "id"
        case picture = "picture"
        case nat = "nat"
    }
    
}

struct Info : Codable {
    let seed : String?
    let results : Int?
    let page : Int?
    let version : String?
    
    enum CodingKeys: String, CodingKey {
        
        case seed = "seed"
        case results = "results"
        case page = "page"
        case version = "version"
    }
    
}

struct Name : Codable {
    let title : String?
    let first : String?
    let last : String?
    
    enum CodingKeys: String, CodingKey {
        
        case title = "title"
        case first = "first"
        case last = "last"
    }
    
    func getUserName() -> String {
        return (self.title ?? "") + " " + (self.first ?? "")
    }
    
    func getFullUserName() -> String {
        return self.getUserName() + " " + (self.last ?? "")
    }
    
}

struct Location : Codable {
    let city : String?
    let state : String?
    let coordinates : Coordinates?
    let timezone : Timezone?
    
    enum CodingKeys: String, CodingKey {
        
        case city = "city"
        case state = "state"
        case coordinates = "coordinates"
        case timezone = "timezone"
    }
    
    func getLocation() -> String {
        return (self.city ?? "") + ", " + (self.state ?? "")
    }
}

struct Coordinates : Codable {
    let latitude : String?
    let longitude : String?
    
    enum CodingKeys: String, CodingKey {
        
        case latitude = "latitude"
        case longitude = "longitude"
    }
    
}

struct Timezone : Codable {
    let offset : String?
    let description : String?
    
    enum CodingKeys: String, CodingKey {
        
        case offset = "offset"
        case description = "description"
    }
    
}

struct Login : Codable {
    let uuid : String?
    let username : String?
    let password : String?
    let salt : String?
    let md5 : String?
    let sha1 : String?
    let sha256 : String?
    
    enum CodingKeys: String, CodingKey {
        
        case uuid = "uuid"
        case username = "username"
        case password = "password"
        case salt = "salt"
        case md5 = "md5"
        case sha1 = "sha1"
        case sha256 = "sha256"
    }
    
}

struct Dob : Codable {
    let date : String?
    let age : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case date = "date"
        case age = "age"
    }
    
    func getUserAge() -> String {
        return "\(self.age ?? 0)"
    }
    
    func getDateOfBirth() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd-MMM-yyyy"

        if let date = dateFormatterGet.date(from: self.date ?? "") {
            return dateFormatterPrint.string(from: date)
        } else {
            print("There was an error decoding the string")
        }
        return ""
    }
}

struct Registered : Codable {
    let date : String?
    let age : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case date = "date"
        case age = "age"
    }
    
}

struct Id : Codable {
    let name : String?
    let value : String?
    
    enum CodingKeys: String, CodingKey {
        
        case name = "name"
        case value = "value"
    }
    
}

struct Picture : Codable {
    let large : String?
    let medium : String?
    let thumbnail : String?
    
    enum CodingKeys: String, CodingKey {
        
        case large = "large"
        case medium = "medium"
        case thumbnail = "thumbnail"
    }
    
}
