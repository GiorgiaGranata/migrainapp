//
//  Intensity.swift
//  MigraineApp
//
//  Created by Giorgia Granata on 10/12/24.
//
//
import SwiftUI

struct IntensitySelectionView: View {
    @State private var selectedIntensity: Int = 0 // Valore selezionato (da 1 a 10)
    @State public var selectedDuration: String // Durata selezionata
    
    @ObservedObject     var viewModel : MigraineData
    
    var body: some View {
        VStack {
            
            HStack {
                Spacer()
                Button(action: {
                    // Torna indietro alla schermata precedente
                    viewModel.showDurationSelection = false// Chiude la schermata
                }) {
                    Image(systemName: "x.circle.fill")
                        .font(.title2)
                        .foregroundColor(.blue)
                        
                }
                
            }
            .padding(.horizontal)
            .padding(.top, 16)
            
            // Titolo
            Text("Intensity")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 16)
            
            Spacer()
            
            // Grafico a barre
            HStack(alignment: .bottom, spacing: 8) {
                ForEach(1...10, id: \.self) { level in
                    VStack {
                        Rectangle()
                            .fill(level <= selectedIntensity ? Color.blue : Color.blue.opacity(0.2))
                            .frame(width: 20, height: CGFloat(level * 20))
                            .cornerRadius(4)
                            .onTapGesture {
                                selectedIntensity = level // Seleziona l'intensità
                            }
                        
                        Text("\(level)")
                            .font(.caption)
                            .foregroundColor(level == selectedIntensity ? .blue : .blue)
                    }
                }
            }
            
            Spacer()
            
            // Pulsante Next
            NavigationLink(destination: TimeSelectionView(viewModel: viewModel, selectedIntensity: selectedIntensity,selectedDuration: selectedDuration)) {
                Text("Next")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(selectedIntensity > 0 ? Color.blue : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.horizontal, 16)
            }
            .disabled(selectedIntensity == 0) // Disabilita il pulsante se non è selezionata un'intensità
            .padding(.bottom, 40)
        }
        .background(Color(.systemGroupedBackground))
        .edgesIgnoringSafeArea(.bottom)
    }
}


#Preview {
    @Previewable @StateObject var  viewModel = MigraineData()
    
    IntensitySelectionView(selectedDuration: "3h", viewModel: viewModel )
}

