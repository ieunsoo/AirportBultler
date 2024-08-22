//
//  TestView.swift
//  AirportButler
//
//  Created by lee eunsoo on 8/4/24.
//
// 구현해보고 싶은 뷰 시험용으로 사용하는 뷰입니다 여기 데이터는 지워져도 상관없는걸 넣어주세요!!!
//

import SwiftUI

struct other: View {
    @StateObject private var levelViewModel = KAC_Level_ViewModel("PUS")

    var body: some View {
        
        NavigationStack {
            List(levelViewModel.waitLevels) { level in
                
                VStack(alignment: .leading) {
                    
                    Text("공항 코드: \(level.iataCode)")
                    Text("기준 시간: \(level.processHour)")
                    Text("전체 터미널 평균 대기 레벨: \(level.avgLevelAll)")
                    Text("터미널 A 평균 대기 레벨: \(level.avgLevelA)")
                    Text("터미널 B 평균 대기 레벨: \(level.avgLevelB)")
                    Text("터미널 C 평균 대기 레벨: \(level.avgLevelC)")
                }
                .padding(.vertical, 5)
            }
            .navigationTitle("김해공항")
            .onAppear {
                levelViewModel.fetchWaitLevel()
            }
            //.onchange + 후행클로저
        }
        
    }
}


#Preview {
    other()
}
