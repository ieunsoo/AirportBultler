import SwiftUI

struct KAC_GCD_View_old: View {
//    @StateObject private var viewModel = KAC_Time_ViewModel()
//    @StateObject private var lvlviewModel = KAC_Level_ViewModel("PUS")
//    @State var airportName: String = "김해공항"
//    @State var refreashCount: Int = 0
    
    var body: some View {
        /*
         
         NavigationView {
             List(viewModel.waitTimes) { waitTime in
                 
                 VStack(alignment: .leading) {
                     //새로고침 버튼
                     HStack{
                         Spacer()
                         Button(action: {
                                     viewModel.fetchWaitTimes()
                                     refreashCount = refreashCount + 1
                                     print(waitTime.processHour, refreashCount)
                         }) { Image(systemName: "arrow.clockwise.circle.fill").foregroundStyle(Color.gray) }
                     }
                     var status:String = Int(waitTime.operationStatus) == 1 ? "정상운영 중" : "비정상운영 중"
                     Text("공항 코드: \(waitTime.iataCode)")
 //                    Text("운영 상태: \(waitTime.operationStatus)")
                     Text("운영 상태: \(status)")
                     
                     Text("기준 시간: \(waitTime.processHour)")
                     Text("전체 터미널 평균 대기 시간: \(waitTime.avgTimeAll / 60) 분")
                     Text("터미널 A 평균 대기 시간: \(waitTime.avgTimeA / 60) 분")
                     Text("터미널 B 평균 대기 시간: \(waitTime.avgTimeB / 60) 분")
                     Text("터미널 C 평균 대기 시간: \(waitTime.avgTimeC / 60) 분")
                     Text("터미널 D 평균 대기 시간: \(waitTime.avgTimeD / 60) 분")
                 }
                 .padding(.vertical, 5)
             }
             .navigationTitle(viewModel.airportName)
             .onAppear {
                 viewModel.fetchWaitTimes()
             }
             //.onchange + 후행클로저
         }
         */
        Text("hello world")
    }
}
struct KAC_GCD_Time_View_old_Previews: PreviewProvider {
    static var previews: some View {
//        KAC_GCD_View_old(airportName: "김해공항 정보")
        KAC_GCD_View_old()
    }
}

