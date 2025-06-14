//
//  GenderRadioButtons.swift
//  CustomerDetails
//
//  Created by Mahesh TN on 12/06/25.
//

import SwiftUI

struct GenderRadioButtons: View {
    @State private var gender: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Select Gender")
                .font(.headline)

            HStack(spacing: 20) {
                RadioButton(text: "Male", isSelected: gender == "Male") {
                    gender = "Male"
                }
                
                RadioButton(text: "Female", isSelected: gender == "Female") {
                    gender = "Female"
                }
            }

            Text("Selected: \(gender)")
        }
        .padding()
    }
}

struct RadioButton: View {
    var text: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                    .foregroundColor(isSelected ? .blue : .gray)
                Text(text)
                    .foregroundColor(.primary)
            }
        }
        .buttonStyle(.plain)
    }
}
