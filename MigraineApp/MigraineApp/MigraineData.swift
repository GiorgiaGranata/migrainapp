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
    
    
    @Published var migraines: [MigraineAttack] = []
    
    // Funzione per aggiungere un nuovo attacco
    func addMigraine() {
        
        
        
        var newMigraine = MigraineAttack(date: tempData, intensity: tempIntensity, type: <#T##String#>, timeOfDay: tempTimeOfDay, tags: <#T##[String]#>, duration: <#T##String#>, resolution: <#T##String#>, pills: <#T##Pills#>)
        migraines.append(newMigraine)
        resetValues()
        
    }
    
    func resetValues(){
        tempData = Date.now
        tempIntensity = ""
        tempTimeOfDay = ""
    }
}
