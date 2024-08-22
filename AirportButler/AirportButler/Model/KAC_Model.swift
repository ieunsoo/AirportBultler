//
//  KAC_Model.swift
//  AirportButler
//
//  Created by lee eunsoo on 8/13/24.
//

import Foundation

// 공통 프로토콜 정의
protocol KAC_Status: Identifiable, Codable {
    var iataCode: String { get }
    var processHour: String { get }
}


// KAC_Time_Model이 KAC_Status 프로토콜을 채택하도록 수정
struct KAC_Time_Model: KAC_Status {
    var id: UUID { UUID() }
    let iataCode: String
    let operationStatus: String
    let processHour: String
    let avgTimeA: Int
    let avgTimeAll: Int
    let avgTimeB: Int
    let avgTimeC: Int
    let avgTimeD: Int

    enum CodingKeys: String, CodingKey {
        case iataCode = "IATA_APCD"         // 공항코드
        case operationStatus = "OPR_STS_CD" // 공항 운영상태 (1=정상)
        case processHour = "PRC_HR"         // 요청한 시간(현재시간)
        case avgTimeA = "STY_TCT_AVG_A"     // A구간 소요시간(초단위)
        case avgTimeAll = "STY_TCT_AVG_ALL" // 전체구간 소요시간(초단위)
        case avgTimeB = "STY_TCT_AVG_B"     // B구간 소요시간(초단위)
        case avgTimeC = "STY_TCT_AVG_C"     // C구간 소요시간(초단위)
        case avgTimeD = "STY_TCT_AVG_D"     // D구간 소요시간(초단위)
    }
}

// KAC_Level_Model이 KAC_Status 프로토콜을 채택하도록 수정
struct KAC_Level_Model: KAC_Status {
    var id: UUID { UUID() }
    let avgLevelAll: Int
    let avgLevelA: Int
    let avgLevelB: Int
    let avgLevelC: Int
    let iataCode: String
    let processHour: String
    
    enum CodingKeys: String, CodingKey {
        case avgLevelAll = "CGDR_ALL_LVL" // 전체구간 소요시간(초단위)
        case avgLevelA = "CGDR_A_LVL"     // A구간 소요시간(초단위)
        case avgLevelB = "CGDR_B_LVL"     // B구간 소요시간(초단위)
        case avgLevelC = "CGDR_C_LVL"     // C구간 소요시간(초단위)
        case iataCode = "IATA_APCD"       // 공항코드
        case processHour = "PRC_HR"       // 요청한 시간(현재시간)
    }
}

// API 응답 모델은 그대로 유지합니다.
struct KAC_Level_Model_ApiResponse: Codable {
    let currentCount: Int
    let data: [KAC_Level_Model]
    let matchCount: Int
    let page: Int
    let perPage: Int
    let totalCount: Int
}

struct KAC_Time_Model_ApiResponse: Codable {
    let currentCount: Int
    let data: [KAC_Time_Model]
    let matchCount: Int
    let page: Int
    let perPage: Int
    let totalCount: Int
}

