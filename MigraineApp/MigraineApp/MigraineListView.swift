//
//  ContentView.swift
//  MigraineApp
//
//  Created by Giorgia Granata on 09/12/24.
//
//

import SwiftUI

struct MigraineListView: View {
//    @State private var episodes: [Migraine] = [
//        Migraine(date: Date(), intensity: 7, type: "Migraine", timeOfDay: "Night", tags: ["5h", "Synflex"]),
//        Migraine(date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, intensity: 10, type: "Migraine with aura", timeOfDay: "Morning", tags: ["All day", "Toradol"])
//    ]
    @StateObject var  viewModel = MigraineData()
    @State private var selectedDuration: String? = nil // Durata selezionata
    @State private var showDurationSelection = false // Per gestire la visualizzazione della schermata di selezione della durata

    var body: some View {
        NavigationView {
            VStack {
                Text("Your migraines")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 16)
                
                // Pulsante per registrare una nuova emicrania, che apre la schermata per la selezione della durata
                Button(action: {
                    showDurationSelection.toggle()
                }) {
                    Text("Log new migraine")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 16)
                }
                
                // Lista delle emicranie
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(groupedByMonth(episodes: viewModel.migraines), id: \.key) { month, migraines in
                            VStack(alignment: .leading, spacing: 10) {
                                Text(month)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .padding(.horizontal, 16)
                                
                                ForEach(migraines) { episode in
                                    MigraineCardView(episode: episode)
                                }
                            }
                        }
                    }
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarHidden(true)
            .sheet(isPresented: $showDurationSelection) {
                DurationSelectionView( viewModel: viewModel )
            }
        }
    }
    
    // Funzione per raggruppare le emicranie per mese
    private func groupedByMonth(episodes: [Migraine]) -> [(key: String, value: [Migraine])] {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        let grouped = Dictionary(grouping: episodes) { episode in
            formatter.string(from: episode.date)
        }
        return grouped.sorted { $0.key > $1.key }
    }
}


struct MigraineCardView: View {
    var episode: Migraine
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                // Cerchio blu con intensità
                Text("\(episode.intensity)")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(width: 40, height: 40)
                    .background(Circle().fill(Color.blue))
                    .foregroundColor(.white)
                
                VStack(alignment: .leading) {
                    Text(episode.date, formatter: dateFormatter)
                        .font(.headline)
                    
                }
                
                Spacer()
                
                Text(episode.timeOfDay)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            
            HStack(spacing: 8) {
            
                if let duration = episode.duration {
                    Text(duration)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                }
                
                if let medicine = episode.pills.medicineName {
                    Text(medicine)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
        .padding(.horizontal, 16)
    }
}

// Per includere la durata
class Migraine: Identifiable {
    var id          = UUID()
    var date        : Date
    var intensity   : Int
    var timeOfDay   : String
    var pills       : Pills
    var duration    : String? // Nuovo campo per la durata
    
    init(id: UUID = UUID(), date: Date, intensity: Int, timeOfDay: String, pills: Pills, duration: String? = nil) {
        self.id = id
        self.date = date
        self.intensity = intensity
        self.timeOfDay = timeOfDay
        self.pills = pills
        self.duration = duration
    }
    
    
}

// Data formatter per la data
let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE, d MMM"
    return formatter
}()

#Preview{
    MigraineListView()
}

