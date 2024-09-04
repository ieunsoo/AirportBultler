//
//  IIAC_Parking_View.swift
//  AirportButler
//
//  Created by lee eunsoo on 9/4/24.
//

import SwiftUI

struct IIAC_Parking_View: View {
    var body: some View {
        Text("인천공항 주차장에 주차하실려구요?")
            .font(.headline)
        Text("어림도 없지")
            .foregroundStyle(Color.red)
    }
}

#Preview {
    IIAC_Parking_View()
}
