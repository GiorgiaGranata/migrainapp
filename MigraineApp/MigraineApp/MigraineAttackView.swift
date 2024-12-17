//
//  MigraineAttack.swift
//  MigraineApp
//
//  Created by Giorgia Granata on 16/12/24.
//


import Foundation

struct MigraineAttack: Identifiable {
    var id = UUID()
    var date: Date
    var intensity: String
    var type: String
    var timeOfDay: String
    var tags: [String]
    var duration: String
    var resolution: String
    var pills: Pills
}

struct Pills {
    var hasTaken: Bool
    var medicineName: String?
}
//import Foundation
//
//struct MigraineAttack: Identifiable {
//    var id = UUID()
//    var duration: String
//    var intensity: String
//    var resolution: String
//    var time: String
//}

