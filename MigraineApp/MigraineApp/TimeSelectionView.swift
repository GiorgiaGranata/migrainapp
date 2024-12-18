//
//  When.swift
//  MigraineApp
//
//  Created by Giorgia Granata on 10/12/24.
//import SwiftUI
import SwiftUI

struct TimeSelectionView: View {
    @ObservedObject  var viewModel : MigraineData
    
    @State public var selectedIntensity : Int  // Valore selezionato (da 1 a 10)
    
    @State public var selectedDuration: String
    
   
    @State private var navigateToResolution = false // Controlla se navigare alla ResolutionSelectionView
    
    @State private var selectedTime: String? = "Morning" // Tiene traccia dell'opzione selezionata
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
                
                Text("When")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
                
                // Icone e testi
                VStack(spacing: 40) {
                    HStack(spacing: 50) {
                        TimeOption(icon: "sun.and.horizon", label: "Morning", selectedTime: $selectedTime)
                        TimeOption(icon: "sun.max", label: "Afternoon", selectedTime: $selectedTime)
                    }
                    
                    HStack(spacing: 50) {
                        TimeOption(icon: "moon", label: "Night", selectedTime: $selectedTime)
                    }
                }
                
                Spacer()
                
                // Pulsante Next con NavigationLink
                NavigationLink(
                    destination: ResolutionSelectionView(viewModel: viewModel, selectedIntensity: selectedIntensity, selectedDuration: selectedDuration, selectedTime: selectedTime ?? "Morning"), // La vista a cui navigare
                    isActive: $navigateToResolution // Attiva la navigazione
                ) {
                    Button(action: {
                        if selectedTime != nil {
                            navigateToResolution = true // Naviga alla ResolutionSelectionView
                        }
                    }) {
                        Text("Next")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(selectedTime != nil ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .padding(.horizontal, 16)
                    }
                    .disabled(selectedTime == nil) // Disabilita il pulsante se non è selezionata un'opzione
                    .padding(.bottom, 40)
                }
            }
            .background(Color(.systemGroupedBackground))
            .edgesIgnoringSafeArea(.bottom)
        
    }
}

struct TimeOption: View {
    var icon: String
    var label: String
    @Binding var selectedTime: String?
    
    var body: some View {
        VStack {
            Button(action: {
                selectedTime = label // Seleziona l'opzione
            }) {
                VStack {
                    Image(systemName: icon)
                        .font(.largeTitle)
                        .foregroundColor(selectedTime == label ? .blue : .gray)
                    Text(label)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(selectedTime == label ? .blue : .black)
                }
            }
        }
    }
}

#Preview{
    	
}

