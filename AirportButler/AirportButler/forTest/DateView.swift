//
//  DateView.swift
//  AirportButler
//
//  Created by lee eunsoo on 8/17/24.
//

import SwiftUI
import Foundation


struct DateView: View {
    func dateViewer() -> String{
        
        let currentDate = Date()// 현재 날짜와 시간 가져오기
        let dateFormatter = DateFormatter()// DateFormatter를 사용하여 날짜 형식 지정
        dateFormatter.dateFormat = "yyyyMMddHHmmss" // 원하는 형식으로 지정
        let currentTimeString = dateFormatter.string(from: currentDate)
        
        return currentTimeString
    }
    
    var body: some View {
        
        
        Text("현재시간 \(dateViewer())")
    }
}

#Preview {
    DateView()
}
