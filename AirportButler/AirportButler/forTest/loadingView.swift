import SwiftUI

struct loadingView: View {
    var body: some View {
        Spacer()
        HStack{
            Image("butler_youngman")
                .resizable()
                .aspectRatio(contentMode: .fit) // 비율을 유지한 채로 크기 조정
                .frame(height: 300) // 원하는 높이로 설정
                .clipped()
                .padding(.horizontal, 20)
            
            VStack(alignment: .leading){
                Text("공항갈땐")
                    .font(.system(size: 32))
                    .fontWeight(.bold)
                    .foregroundStyle(Color.accentBlue)
                Text("공항집사")
                    .fontWeight(.bold)
                    .font(.system(size: 40))
                    
            }
            
            
        }
        
        HStack{
            Text("만나서 반가워요 😎")
                .fontWeight(.bold)
                .foregroundStyle(Color.accentBlue)
        }.padding(.vertical, 100)
    }
}

#Preview {
    loadingView()
}
