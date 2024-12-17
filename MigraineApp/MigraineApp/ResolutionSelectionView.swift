//
//  How it goes away.swift
//  MigraineApp
//
//  Created by Giorgia Granata on 11/12/24.
import Foundation
import SwiftUI

struct ResolutionSelectionView: View {
    
    @State private var selectedOption       : String? = nil // Tiene traccia dell'opzione selezionata
    @State private var medicineName         : String = "" // Tiene traccia del nome del medicinale inserito
    
    @State private var showMedicineInput    : Bool = false // Controlla se mostrare l'input per il medicinale
    
    @Environment(\.presentationMode) var presentationMode // Gestisce il ritorno alla schermata precedente
    
    @StateObject var viewModel = MigraineData()
    
    
    var body: some View {
        VStack {
            // Intestazione
            HStack {
                Button(action: {
                    if showMedicineInput {
                        // Torna alla selezione principale
                        showMedicineInput = false
                    } else {
                        // Torna indietro alla schermata precedente
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 16)
            
            if showMedicineInput {
                // Schermata per inserire il nome del medicinale
                Text("Select your medicine")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 8)
                
                Spacer()
                
                VStack {
                    Image(systemName: "pills.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.blue)
                        .padding(16)
                        .overlay(
                            Circle()
                                .stroke(Color.blue, lineWidth: 2)
                        )
                    
                    TextField("Enter medicine name", text: $medicineName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 40)
                        .padding(.top, 16)
                }
                
                Spacer()
                
                Button(action: {
                    // Azione per caricare o salvare il nome del medicinale
                    
                }) {
                    Text("Upload")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(medicineName.isEmpty ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.horizontal, 16)
                }
                .disabled(medicineName.isEmpty) // Disabilita il pulsante se il campo è vuoto
                .padding(.bottom, 40)
            } else {
                // Schermata principale
                Text("How it goes away")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 8)
                
                Spacer()
                
                HStack(spacing: 50) {
                    OptionView(icon: "pills.fill", label: "Pills", isSelected: selectedOption == "Pills") {
                        selectedOption = "Pills"
                        showMedicineInput = true // Mostra la schermata per l'inserimento del medicinale
                    }
                    OptionView(
                        icon: "nosign",
                        label: "No pills",
                        isSelected: selectedOption == "No pills"
                    ) {
                        print("Save Migraine")
                        selectedOption = "No pills"
                        // Azione per l'opzione "No pills"
                        	
                        viewModel.addMigraine(intensity: 4, timeOfDay: "Morning", pills: Pills(hasTaken: true,medicineName: "Brufen"))
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
                Spacer()
                
                Button(action: {
                    if selectedOption == "No pills" {
                        // Azione per "Upload" se l'utente ha selezionato "No pills"
                        print("No pills option uploaded!")
                    } else if selectedOption == "Pills" {
                        // Azione per "Next"
                        showMedicineInput = true
                    }
                }) {
                    Text(selectedOption == "No pills" ? "Upload" : "Next")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selectedOption != nil ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.horizontal, 16)
                }
                .disabled(selectedOption == nil) // Disabilita il pulsante se non è selezionata un'opzione
                .padding(.bottom, 40)
            }
        }
        .background(Color(.systemGroupedBackground))
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct OptionView: View {
    var icon: String
    var label: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: icon)
                    .font(.system(size: 40))
                    .foregroundColor(isSelected ? .blue : .blue.opacity(0.5))
                    .padding(8)
                    .overlay(
                        Circle()
                            .stroke(isSelected ? Color.blue : Color.blue.opacity(0.5), lineWidth: 2)
                    )
                Text(label)
                    .font(.headline)
                    .foregroundColor(.black)
            }
        }
    }
}

// Anteprima
struct ResolutionSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ResolutionSelectionView()
    }
}
