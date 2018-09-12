//
//  CalculationDataBase.swift
//  SinkerCalculation
//
//  Created by さわっち on 2018/08/12.
//  Copyright © 2018年 sawatch. All rights reserved.
//

import Foundation

// DataBaseテーブルにアクセスするための関数
class CalculationDataBase: DataBaseTable {
    
    // ウキのデータベース
    var DbWeightFloat:WeightTable = WeightTable()

    // var
    var editFlag:Bool = false;

    func setArrayDataBaseWeightFloat(setKey: CalculationDataBase.WeightIndex, setValue: Double) {
        DbWeightFloat.weights.updateValue(setValue, forKey: setKey)
        onEditFlag()
        return
    }

    func getArrayDataBaseWeightFloat(getKey: CalculationDataBase.WeightIndex) -> Double {
        let retValue:Double = DbWeightFloat.weights[getKey]!
        return retValue
    }

    // オモリのデータベース
    var DbWeightSinker:WeightTable = WeightTable()
    func setArrayDataBaseWeightSinker(setKey: CalculationDataBase.WeightIndex, setValue: Double) {
        DbWeightSinker.weights.updateValue(setValue, forKey: setKey)
        onEditFlag()
        return
    }
    func getArrayDataBaseWeightSinker(getKey: CalculationDataBase.WeightIndex) -> Double {
        let retValue:Double = DbWeightSinker.weights[getKey]!
        return retValue
    }


    func onEditFlag(){
        editFlag = true
    }

    func offEditFlag(){
        editFlag = false
    }
}
