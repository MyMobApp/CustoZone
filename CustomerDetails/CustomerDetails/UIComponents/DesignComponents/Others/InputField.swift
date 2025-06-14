//
//  InputField.swift
//  CustomerDetails
//
//  Created by Mahesh TN on 12/06/25.
//

import SwiftUI

struct InputField: View {
    var title: String
    @Binding var text: String
    var icon: String
    var keyboard: UIKeyboardType = .default
    var autoCapital: UITextAutocapitalizationType = .sentences

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label(title, systemImage: icon)
                .font(.caption)
                .foregroundColor(.blue)
            TextField("Enter \(title.lowercased())", text: $text)
                .keyboardType(keyboard)
                .autocapitalization(autoCapital)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color(UIColor.secondarySystemBackground))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                )
        }
    }
}


//#Preview {
//    InputField(title: "", text: , icon: "")
//}
