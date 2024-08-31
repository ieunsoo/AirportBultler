import SwiftUI

struct Airport: Identifiable {
    let id = UUID()
    let name: String//enum으로, 선택해야 하는 환경에서는 열거형이 더 좋을 수 있움, 선택지외의 예외처리
    let description: String?
    let imageName: String
    
    //    let destination: AnyView
}

// TODO: 뷰에 사용하는 api데이터를 담은 객체르 여기서 생성해서 뷰에 넘겨주기 (지금은 뷰마다 객체가 1개씩 생김, 굳이 수정할 필요가 있나??)

struct MainNavigation: View {
    //    @ObservableObject var all
    //    @StateObject private var lvlWithTime = KAC_Data_Load_ViewModel()
    
    let airports: [Airport] = [
        Airport(name: "인천공항", description: nil, imageName: "incheon_square"),
        Airport(name: "김포공항", description: "이 공항은 국내선 정보만 제공해요", imageName: "gimpo_square"),
        Airport(name: "김해공항", description: "이 공항은 국내선 정보만 제공해요", imageName: "gimhae_square"),
        Airport(name: "제주공항", description: "이 공항은 국내선 정보만 제공해요", imageName: "jeju_square"),
        Airport(name: "청주공항", description: "이 공항은 국내선 정보만 제공해요", imageName: "cheongju_square"),
        Airport(name: "대구공항", description: "이 공항은 국내선 정보만 제공해요", imageName: "daegu_square"),
        Airport(name: "주차장 정보", description: nil, imageName: "other_square")
    ]
    
    var body: some View {
        NavigationStack{
            VStack {
                ZStack{
                    HStack{
                        Image("butler_emoji")
                            .resizable()
                            .frame(width: 45, height: 45)
                        Text("공항 선택")
                            .font(.system(size: 33))
                            .fontWeight(.bold)
                            .padding(.vertical, 10)
                            .foregroundStyle(Color.black)
                        Spacer()
                    }.padding(.horizontal)
                }
                
                ScrollView{
                    ForEach(airports) { airport in
                        if(airport.name == "인천공항"){
                            NavigationLink(destination: IIAC_DailyPassenger_View()) {
                                AirportRow(airport: airport)
                            }
                        }
                        else if(airport.name == "주차장 정보"){
                            NavigationLink(destination: Parking()) {
                                AirportRow(airport: airport)
                            }
                        }
                        else{
                            NavigationLink(destination: KAC_View(sendCode: airport.name, airportName: airport.name)) {
                                AirportRow(airport: airport)
                            }
                        }
                    }
                }
            }.background(Color.bgGray)
        }
    }
}

struct AirportRow: View {
    let airport: Airport
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(airport.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.black)
                
                if let description = airport.description {
                    Text(description)
                        .foregroundStyle(Color.accentBlue)
                        .fontWeight(.bold)
                        .font(.caption)
                }
            }
            .padding(.leading, 30)
            
            Spacer()
            
            Image(airport.imageName)
                .resizable()
                .frame(width: 90, height: 90)
                .cornerRadius(10)
                .padding(13)
            
        }
        .background(Color.white)
        .cornerRadius(10.0)
        .padding(.horizontal, 20)
        .padding(.bottom, 5)
    }
}


#Preview {
    MainNavigation()
}

