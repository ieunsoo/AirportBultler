//
//  KAC_Parking_Model.swift
//  AirportButler
//
//  Created by lee eunsoo on 9/4/24.
//

import Foundation
import Combine


//MARK: -Model
struct KAC_Parking_Model: Identifiable{
    let id = UUID()
    var aprEng:String                   //공항영어이름
    var aprKor:String                   //공항국문이름
    var parkingAirportCodeName:String   //주차장이름
    var parkingFullSpace:Int            //주차장 자리 총개수
    var parkingIstay:Int                //현재 주차차량 대수
    var parkingGetdate:String           // 데이터를 가져온 날짜
    var parkingGettime:String           //데이터를 가져온 시간
}
