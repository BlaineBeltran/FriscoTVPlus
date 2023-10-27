//
//  FloatingHeader.swift
//  FriscoTV+
//
//  Created by Blaine Beltran on 10/23/23.
//

import SwiftUI

struct FloatingHeader: View {
    @Binding var isChecked: Bool
    
    var body: some View {
        HStack {
            Text("Watch Now")
                .foregroundStyle(.white)
                .font(.largeTitle)
                .fontWeight(.bold)
                .shadow(radius: 10)
            
            Spacer()
            
            /// Movable navigation / status bar
            Image(systemName: isChecked ? "checkmark.circle.fill": "plus.circle.fill")
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, .secondary)
                .font(.title)
                .contentTransition(.symbolEffect(.replace))
                .onTapGesture {
                    isChecked.toggle()
                }
        }
        .padding([.leading, .trailing])
        .offset(y: 55)
    }
}

#Preview {
    FloatingHeader(isChecked: .constant(false))
}
