//
//  DataBaseTable.swift
//  SinkerCalculation
//
//  Created by さわっち on 2018/08/12.
//  Copyright © 2018年 sawatch. All rights reserved.
//

import Foundation

class DataBaseTable {
    
    enum UserDefaultsTag: String {
        case first_boot = "first_boot"
        
        case using_float_select     = "using_float_select"
        case using_float_weight     = "using_float_weight"
        case the_number_of_sinkers  = "the_number_of_sinkers"
        case extra_weight_sinker    = "extra_weight_sinker"
        
        case sinker_g8 = "sinker_g8"
        case sinker_g7 = "sinker_g7"
        case sinker_g6 = "sinker_g6"
        case sinker_g5 = "sinker_g5"
        case sinker_g4 = "sinker_g4"
        case sinker_g3 = "sinker_g3"
        case sinker_g2 = "sinker_g2"
        case sinker_g1 = "sinker_g1"
        case sinker_b1 = "sinker_b1"
        case sinker_b2 = "sinker_b2"
        case sinker_b3 = "sinker_b3"
        case sinker_b4 = "sinker_b4"
        case sinker_b5 = "sinker_b5"
        case sinker_b6 = "sinker_b6"
        
        case float_g8 = "float_g8"
        case float_g7 = "float_g7"
        case float_g6 = "float_g6"
        case float_g5 = "float_g5"
        case float_g4 = "float_g4"
        case float_g3 = "float_g3"
        case float_g2 = "float_g2"
        case float_g1 = "float_g1"
        case float_b1 = "float_b1"
        case float_b2 = "float_b2"
        case float_b3 = "float_b3"
        case float_b4 = "float_b4"
        case float_b5 = "float_b5"
        case float_b6 = "float_b6"
    }
    
    enum WeightIndex: String {
        case g8
        case g7
        case g6
        case g5
        case g4
        case g3
        case g2
        case g1
        case b1
        case b2
        case b3
        case b4
        case b5
        case b6
        
        static let WeightIndexs: [WeightIndex] = [.g8, .g7, .g6, .g5, .g4, .g3, .g2, .g1,
                                                  .b1, .b2, .b3, .b4, .b5, .b6]
    }

    enum WeightNumber: Int {
        case g8 = 0
        case g7
        case g6
        case g5
        case g4
        case g3
        case g2
        case g1
        case b1
        case b2
        case b3
        case b4
        case b5
        case b6
        
        static let WeightNumbers: [WeightNumber] = [.g8, .g7, .g6, .g5, .g4, .g3, .g2, .g1,
                                                  .b1, .b2, .b3, .b4, .b5, .b6]
    }
    // Calu画面の設定値
    struct CaluInterfaceTable {
        var usingFloatSelect: String = "B3"
        var usingFloatWeight: Double = 0.0           // これは使用の有無は不明

        var theNumberOfSinkers: Int = 2
        var extraWeightSinker: Double = 0.0
        
        init() {
            usingFloatSelect = "B3"
            usingFloatWeight = 0.0
            theNumberOfSinkers = 2
            extraWeightSinker = 0.0
        }
    }

    // オモリとウキのサイズごとの重量テーブル
    struct WeightTable {
        var weights: Dictionary = [WeightIndex: Double]()

        init() {
            weights[WeightIndex.g8] = 0.0
            weights[WeightIndex.g7] = 0.0
            weights[WeightIndex.g6] = 0.0
            weights[WeightIndex.g5] = 0.0
            weights[WeightIndex.g4] = 0.0
            weights[WeightIndex.g3] = 0.0
            weights[WeightIndex.g2] = 0.0
            weights[WeightIndex.g1] = 0.0
            weights[WeightIndex.b1] = 0.0
            weights[WeightIndex.b2] = 0.0
            weights[WeightIndex.b3] = 0.0
            weights[WeightIndex.b4] = 0.0
            weights[WeightIndex.b5] = 0.0
            weights[WeightIndex.b6] = 0.0
        }
    }
    
}
