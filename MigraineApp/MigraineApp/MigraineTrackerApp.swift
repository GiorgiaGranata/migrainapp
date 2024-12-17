//
//  MigraineAppApp.swift
//  MigraineApp
//
//  Created by Giorgia Granata on 09/12/24.
//
import SwiftUI

@main
struct MigraineTrackerApp: App {
    @StateObject var migraineData = MigraineData()
    
    var body: some Scene {
        WindowGroup {
            MigraineListView()
                .environmentObject(migraineData) // Passiamo il `MigraineData` a tutte le viste
        }
    }
}
 


