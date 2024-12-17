//
//  AddMigraineListView.swift
//  MigraineApp
//
//  Created by Giorgia Granata on 11/12/24.

import Foundation
import SwiftUI

struct AddMigraineView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var episodes: [Migraine]
    
    @State private var intensity: Int = 5
    @State private var type: String = ""
    @State private var timeOfDay: String = ""
    @State private var tags: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Migraine Details")) {
                    Stepper("Intensity: \(intensity)", value: $intensity, in: 1...10)
                    TextField("Type (e.g., Migraine, Migraine with aura)", text: $type)
                    TextField("Time of Day (e.g., Morning, Night)", text: $timeOfDay)
                }
                
                Section(header: Text("Tags")) {
                    TextField("Tags (comma separated)", text: $tags)
                }
                
                Section {
                    Button("Save") {
                        // Salva l'episodio
                        let newMigraine = Migraine(
                            date: Date(),
                            intensity: intensity,
                            type: type,
                            timeOfDay: timeOfDay,
                            tags: tags.components(separatedBy: ", ").map { $0 }
                        )
                        episodes.append(newMigraine)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationTitle("Log New Migraine")
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
