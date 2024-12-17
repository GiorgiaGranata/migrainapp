//
//  When.swift
//  MigraineApp
//
//  Created by Giorgia Granata on 10/12/24.
//import SwiftUI
import SwiftUI

struct TimeSelectionView: View {
    @State private var selectedTime: String? = nil // Tiene traccia dell'opzione selezionata
    @State private var navigateToResolution = false // Controlla se navigare alla ResolutionSelectionView
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        // Torna alla schermata precedente
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(.black)
                    }
                    Spacer()
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
                    destination: ResolutionSelectionView(), // La vista a cui navigare
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

struct TimeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        TimeSelectionView()
    }
}
