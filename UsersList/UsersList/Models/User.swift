//
//  User.swift
//  UsersList
//
//  Created by Lucian Cristea on 15.08.2024.
//

import Foundation

// MARK: - Response
struct Response: Codable {
    let results: [User]
}

// MARK: - User
struct User: Codable, Identifiable, Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: UUID = UUID()
    let gender: String?
    let name: Name?
    let location: Location?
    let email: String?
    let login: Login?
    let dob: Dob?
    let registered: Registered?
    let phone: String?
    let cell: String?
    let identifier: IDInfo?
    let picture: Picture?
    let nat: String?
    
    enum CodingKeys: String, CodingKey {
        case gender, name, location, email, login, dob, registered, phone, cell, picture, nat
        case identifier = "id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        gender = try? container.decode(String.self, forKey: .gender)
        name = try? container.decode(Name.self, forKey: .name)
        location = try? container.decode(Location.self, forKey: .location)
        email = try? container.decode(String.self, forKey: .email)
        login = try? container.decode(Login.self, forKey: .login)
        dob = try? container.decode(Dob.self, forKey: .dob)
        registered = try? container.decode(Registered.self, forKey: .registered)
        phone = try? container.decode(String.self, forKey: .phone)
        cell = try? container.decode(String.self, forKey: .cell)
        identifier = try? container.decode(IDInfo.self, forKey: .identifier)
        picture = try? container.decode(Picture.self, forKey: .picture)
        nat = try? container.decode(String.self, forKey: .nat)
    }
}

// MARK: - Name
struct Name: Codable {
    let title: String?
    let first: String?
    let last: String?
}

// MARK: - Street
struct Street: Codable {
    let number: Int?
    let name: String?
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let latitude: String?
    let longitude: String?
}

// MARK: - Timezone
struct Timezone: Codable {
    let offset: String?
    let description: String?
}

// MARK: - Location
struct Location: Codable {
    let street: Street?
    let city: String?
    let state: String?
    let country: String?
    let postcode: Int?
    let coordinates: Coordinates?
    let timezone: Timezone?
}

// MARK: - Login
struct Login: Codable {
    let uuid: String?
    let username: String?
    let password: String?
    let salt: String?
    let md5: String?
    let sha1: String?
    let sha256: String?
}

// MARK: - Dob
struct Dob: Codable {
    let date: String?
    let age: Int?
}

// MARK: - Registered
struct Registered: Codable {
    let date: String?
    let age: Int?
}

// MARK: - IDInfo
struct IDInfo: Codable {
    let name: String?
    let value: String?
}

// MARK: - Picture
struct Picture: Codable {
    let large: String?
    let medium: String?
    let thumbnail: String?
}
