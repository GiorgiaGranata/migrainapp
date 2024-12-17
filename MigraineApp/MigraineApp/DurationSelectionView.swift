//
//  Duration.swift
//  MigraineApp
//
//  Created by Giorgia Granata on 10/12/24.
//

import SwiftUI

struct DurationSelectionView: View {
    @State private var selectedDuration: String? // Durata selezionata
    @Environment(\.presentationMode) var presentationMode
    
    let durations = [
        "1-3h",
        "All day",
        "5-7h",
        "3-5h"
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                
                HStack {
                    Button(action: {
                        // Torna indietro alla schermata precedente
                        presentationMode.wrappedValue.dismiss() // Chiude la schermata
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 16)
                
                // Titolo
                Text("Duration")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 16)
                
                Spacer()
                
                // Quadrante circolare
                ZStack {
                    ForEach(0..<4) { index in
                        let isSelected = durations[index] == selectedDuration
                        
                        // Sezione del quadrante
                        SectorShape(startAngle: Angle(degrees: Double(index) * 90),
                                    endAngle: Angle(degrees: Double(index + 1) * 90))
                        .fill(isSelected ? Color.blue.opacity(0.3) : Color.clear)
                            .overlay(
                                SectorShape(startAngle: Angle(degrees: Double(index) * 90),
                                            endAngle: Angle(degrees: Double(index + 1) * 90))
                                    .stroke(Color.blue, lineWidth: 2)
                            )
                        
                        // Pulsante cliccabile sopra la sezione
                        Button(action: {
                            selectedDuration = durations[index]
                        }) {
                            Rectangle()
                                .fill(Color.clear) // Area cliccabile trasparente
                                .frame(width: 120, height: 120) // Rende l'area più grande e cliccabile
                        }
                        .position(positionForSector(index: index))
                    }
                    
                    // Testo per la durata
                    ForEach(0..<4) { index in
                        Text(durations[index])
                            .font(.headline)
                            .foregroundColor(.black)
                            .position(positionForText(index: index))
                    }
                }
                .frame(width: 250, height: 250)
                
                Spacer()
                
                // Pulsante Next
                NavigationLink(destination: IntensitySelectionView()) {
                    Text("Next")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selectedDuration != nil ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.horizontal, 16)
                }
                .disabled(selectedDuration == nil) // Disabilita il pulsante se non è selezionata una durata
                .padding(.bottom, 40)
            }
            .background(Color(.systemGroupedBackground))
            .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    // Calcola la posizione del settore per il pulsante
    private func positionForSector(index: Int) -> CGPoint {
        let radius: CGFloat = 120 // Raggio maggiore per il pulsante
        let angle = Angle(degrees: Double(index) * 90 + 45).radians
        let xOffset = radius * cos(angle)
        let yOffset = radius * sin(angle)
        return CGPoint(x: 125 + xOffset, y: 125 - yOffset)
    }

    // Calcola la posizione del testo per ogni sezione
    private func positionForText(index: Int) -> CGPoint {
        let radius: CGFloat = 80 // Raggio minore per il testo
        let angle = Angle(degrees: Double(index) * 90 + 45).radians
        let xOffset = radius * cos(angle)
        let yOffset = radius * sin(angle)
        return CGPoint(x: 125 + xOffset, y: 125 - yOffset)
    }
}

// Forma di un settore circolare
struct SectorShape: Shape {
    let startAngle: Angle
    let endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        path.move(to: center)
        path.addArc(center: center,
                    radius: radius,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: false)
        path.closeSubpath()
        return path
    }
}

struct DurationSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        DurationSelectionView()
    }
}
