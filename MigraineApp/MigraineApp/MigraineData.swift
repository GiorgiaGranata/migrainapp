//
//  MigraineData.swift
//  MigraineApp
//
//  Created by Giorgia Granata on 16/12/24.
//
//
import SwiftUI

class MigraineData: ObservableObject {
    @Published var tempData: Date = Date.now
    @Published var tempIntensity: String = ""
    @Published var tempTimeOfDay: String = ""
    
    @Published public var showDurationSelection = false
    
    @Published var migraines: [Migraine] = [
        Migraine(date: Date(), intensity: 7, timeOfDay: "Night", pills: Pills(hasTaken: false), duration: "5-7h"),
        Migraine(date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, intensity: 10, timeOfDay: "Morning", pills: Pills(hasTaken: true, medicineName: "Toradol"), duration: "All day"),
    ]
    
    // Funzione per aggiungere un nuovo attacco
    func addMigraine(  intensity: Int, timeOfDay: String, pills: Pills, duration: String? = nil) {
        
        resetDate()
        
        var newMigraine = Migraine (
            date: tempData,
            intensity: intensity,
            timeOfDay: tempTimeOfDay,
            pills: pills,
            duration: duration
        )
        
        migraines.append(newMigraine)
        
    }
    
    func resetDate(){
        tempData = Date.now
    }
}
