//
//  CalculationCombination.swift
//  SinkerCalculation
//
//  Created by さわっち on 2018/08/12.
//  Copyright © 2018年 sawatch. All rights reserved.
//

import Foundation
import UIKit

class CalculationCombination {

    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    // 答えの雛形
    // この値を使用して、結果の画面に計算結果を表示する
    // タイトル     [例 : パターン 7個\nオモリ3個: 3B(1.00g)+余重(0.01g)]
    // Cell複数
    struct resultTable {
        var header:  String
        var cells =  [cellTable]()
        
        init(){
            self.header = ""
            self.cells.removeAll()
        }
    }

    // Cell1個の値     [例 : 合計 : 0.37g,  余り : -0.01g \n詳細 : G8(0.07g), G7(0.09g), G7(0.09g), G6(0.12g)]
    struct cellTable {
        var summary: String
        var detail: String

        init(){
            self.summary = ""
            self.detail = ""
        }
    }

    // メンバ変数
    struct Sinker {
        var number: String
        var weight: Double
        
        init(number : String, weight : Double){
            self.number = number
            self.weight = weight
        }

        static func ==(lhs: Sinker, rhs: Sinker) -> Bool {
            if(lhs.number != rhs.number){
                return false
            }
            if(lhs.weight != rhs.weight){
                return false
            }
            return true
        }
    }
    
    
    var maxRangeOfWeight:Double = 0
    var minRangeOfWeight:Double = 0
    var selectFlotWeight:Double = 0     // headerの表示に使う
    
    // 計算用のオモリの配列
    var sinkerArrayForCalu = [Sinker]()
    
    // 組合せの結果の2次元配列
    var resultCombinationArray = [[Sinker]]()

    /////////////////////
    // 計算処理の最初!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!resultTable

    /// Description:
    /// - Author: sawatch
    /// - Date: 2018/08/17
    /// - Version: 1.0.0
    func mainCalculation()->resultTable{

        makeSinkerArray()

        setRangeOfWeight()

        #if DEBUG
        let start = Date()
        #endif

        // オモリの組合せ 1パターン[1次元 配列][例:0.20g, 0.30g, 0.45g]
        let blankCombinationOfSinkersArray = [Sinker]()
        getSinkersCombinationRepeatedly(argNumber: 0, argNowCombination: blankCombinationOfSinkersArray)

        #if DEBUG
        let elapsed_1 = Date().timeIntervalSince(start)
        print("経過時間-半分: ",elapsed_1)
        #endif
        // 重複の削除
        deleteDuplicationMain()

        #if DEBUG
        DebugPrintResultArray()

        // 経過時間
        let elapsed_2 = Date().timeIntervalSince(start)
        print("経過時間-全部: ",elapsed_2)
        #endif

        let returnCombinationList:resultTable = CreatResutTable()

        return returnCombinationList
    }
    
    // 辞書は順番がランダムのため、2次元配列に変更する
    /// Description:    オモリの配列を作成する
    /// - Note:         辞書は順番がランダムのため、2次元配列に変更する
    ///                 2018/09/12 - Ver.1.0.1
    ///                 項目を追加
    ///                 - 1号
    /// - Author:       sawatch
    /// - Date:         2018/08/17
    /// - Version:      1.0.0
    func makeSinkerArray() {
        sinkerArrayForCalu.append(Sinker(number: DataBaseTable.WeightIndex.g8.rawValue, weight: appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g8]!))
        sinkerArrayForCalu.append(Sinker(number: DataBaseTable.WeightIndex.g7.rawValue, weight: appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g7]!))
        sinkerArrayForCalu.append(Sinker(number: DataBaseTable.WeightIndex.g6.rawValue, weight: appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g6]!))
        sinkerArrayForCalu.append(Sinker(number: DataBaseTable.WeightIndex.g5.rawValue, weight: appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g5]!))
        sinkerArrayForCalu.append(Sinker(number: DataBaseTable.WeightIndex.g4.rawValue, weight: appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g4]!))
        sinkerArrayForCalu.append(Sinker(number: DataBaseTable.WeightIndex.g3.rawValue, weight: appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g3]!))
        sinkerArrayForCalu.append(Sinker(number: DataBaseTable.WeightIndex.g2.rawValue, weight: appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g2]!))
        sinkerArrayForCalu.append(Sinker(number: DataBaseTable.WeightIndex.g1.rawValue, weight: appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g1]!))
        sinkerArrayForCalu.append(Sinker(number: DataBaseTable.WeightIndex.b1.rawValue, weight: appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.b1]!))
        sinkerArrayForCalu.append(Sinker(number: DataBaseTable.WeightIndex.b2.rawValue, weight: appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.b2]!))
        sinkerArrayForCalu.append(Sinker(number: DataBaseTable.WeightIndex.b3.rawValue, weight: appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.b3]!))
        sinkerArrayForCalu.append(Sinker(number: DataBaseTable.WeightIndex.b4.rawValue, weight: appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.b4]!))
        sinkerArrayForCalu.append(Sinker(number: DataBaseTable.WeightIndex.b5.rawValue, weight: appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.b5]!))
        sinkerArrayForCalu.append(Sinker(number: DataBaseTable.WeightIndex.b6.rawValue, weight: appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.b6]!))
        sinkerArrayForCalu.append(Sinker(number: DataBaseTable.WeightIndex.n1.rawValue, weight: appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.n1]!))
    }

    /// Description: 最大値/最小値を求める (ウキの重量 ± 余重)
    /// - Note: 2018/09/12 - Ver.1.0.1
    ///              項目を追加
    ///              - 1号
    /// - Author: sawatch
    /// - Date: 2018/08/17
    /// - Version: 1.0.0
    func setRangeOfWeight(){
        selectFlotWeight = 0.0

        var selectSize:DataBaseTable.WeightIndex = DataBaseTable.WeightIndex.b6
        switch(appDelegate.db_CaluInterface.usingFloatSelect)
        {
            case "G8": selectSize = DataBaseTable.WeightIndex.g8
            case "G7": selectSize = DataBaseTable.WeightIndex.g7
            case "G6": selectSize = DataBaseTable.WeightIndex.g6
            case "G5": selectSize = DataBaseTable.WeightIndex.g5
            case "G4": selectSize = DataBaseTable.WeightIndex.g4
            case "G3": selectSize = DataBaseTable.WeightIndex.g3
            case "G2": selectSize = DataBaseTable.WeightIndex.g2
            case "G1": selectSize = DataBaseTable.WeightIndex.g1
            case "B" : selectSize = DataBaseTable.WeightIndex.b1
            case "2B": selectSize = DataBaseTable.WeightIndex.b2
            case "3B": selectSize = DataBaseTable.WeightIndex.b3
            case "4B": selectSize = DataBaseTable.WeightIndex.b4
            case "5B": selectSize = DataBaseTable.WeightIndex.b5
            case "6B": selectSize = DataBaseTable.WeightIndex.b6
            case "1号": selectSize = DataBaseTable.WeightIndex.n1
            default: print("setRangeOfWeight-Error")          // Error
        }

        selectFlotWeight = appDelegate.db_Weights.db_Float.weights[selectSize]!
        maxRangeOfWeight = selectFlotWeight + appDelegate.db_CaluInterface.extraWeightSinker
        minRangeOfWeight = selectFlotWeight - appDelegate.db_CaluInterface.extraWeightSinker
    }
    
    // 組合せの算出
    
    /// Description: Eurekaの設定
    /// - Author: sawatch
    /// - Date: 2018/08/17
    /// - Version: 1.0.0
    func getSinkersCombinationRepeatedly( argNumber:Int, argNowCombination:[Sinker]){
        
        // 処理の速度を上げる処理
        var Sum:Double = 0.0
        // もし既に最大値を越えていた場合、対象パターンから除外する
        if(0 < argNumber){
            for index in argNowCombination {
                Sum += index.weight
            }
            
            if(Sum > maxRangeOfWeight){
                // 除外
                return;
            }
            // もし最後に使うSinkersだった場合、最小値を満たさなければ除外する
            if(argNumber == appDelegate.db_CaluInterface.theNumberOfSinkers) {
                if(Sum < minRangeOfWeight){
                    // 除外
                    return;
                }
            }
            
        }

        // もし最後に使うSinkersだったらメンバー変数に配列を格納する
        if(argNumber == appDelegate.db_CaluInterface.theNumberOfSinkers) {
            
            // [２次元配列に格納する前]並び替え
            var argNowCombination = argNowCombination
            argNowCombination.sort(by: {$0.number > $1.number})
            
            // パターンを代入[例: B2(0.95g)オモリ3個使用時 組合せ[6号(0.20g), 7号(0.30g), 8号(0.45g)]]
            resultCombinationArray.append(argNowCombination)
            return;
        }
        
        // オモリの組合せ 1パターン[1次元 配列][例:0.20g, 0.30g, 0.45g]
        var simpleCombinationOfSinkersArray = [Sinker]()
        // 何個目のSinker?
        var NowIndexSinker:Int = 0
        
        // 一時保有
        var tempCombinationOfSinkersArray = [Sinker]()
        tempCombinationOfSinkersArray = argNowCombination

        // オモリの種類 × 使用するウキの個数 の加算を行う
        // オモリの種類分ループさせる
        for indexSinker in sinkerArrayForCalu {
            // もし使うオモリの個数分、表の作成のために加算を繰り返す
            if(argNumber >= appDelegate.db_CaluInterface.theNumberOfSinkers){
                break
            }

            // [1次元配列]に格納
            simpleCombinationOfSinkersArray = tempCombinationOfSinkersArray
            
            // [1次元配列]に[オモリ1個分]を追加
            simpleCombinationOfSinkersArray.append(indexSinker)
            
            // 何個目に使うSinker?
            NowIndexSinker = (argNumber + 1)
            // 再循環（この関数）
            getSinkersCombinationRepeatedly(argNumber: NowIndexSinker, argNowCombination: simpleCombinationOfSinkersArray)
        }

        return
    }

    // 2次元配列の重複を削除
    func deleteDuplicationMain(){

        // 2次元配列の並び替え
        resultCombinationArray.sort(by: {$0[0].weight > $1[0].weight})

        // 重複の削除
        deleteDuplicationDetail()

        return
    }
    
    
    // 2次元配列の重複を削除
    
    /// Description: Eurekaの設定
    /// - Author: sawatch
    /// - Date: 2018/08/17
    /// - Version: 1.0.0
    func deleteDuplicationDetail() {
        // 重複の削除
        var numberOfLoopingOutSide:Int = resultCombinationArray.count
        
        for indexSource in 0..<numberOfLoopingOutSide
        {
            var arraySource:[Sinker] = resultCombinationArray[indexSource]
            
            let indexNextOfSource:Int = indexSource + 1;
            if(indexNextOfSource >= numberOfLoopingOutSide){
                // この処理がないと最後の列でfor文がエラーになる
                break;
            }

            // 削除する配列の番号を格納する
            var arrayIndexOfDelete = [Int]()
            arrayIndexOfDelete.removeAll()

            // 重複している1次元配列を検索する
            // 見つかった場合、配列に格納する
            for indexDestination in indexNextOfSource..<numberOfLoopingOutSide
            {
                var arrayDestination:[Sinker] = resultCombinationArray[indexDestination]

                let numberOfLoopingInSide:Int = arraySource.count
                var arrayDelete:Bool = true

                for indexCompare in 0..<numberOfLoopingInSide
                {
                    let sinkerSource:Sinker = arraySource[indexCompare]
                    let sinkerDestination:Sinker = arrayDestination[indexCompare]
                    // ここはオペレーター作らないとダメだね
                    if(sinkerSource.number != sinkerDestination.number){
                        // 元と先で、配列の内容が異なる
                        arrayDelete = false
                        break;
                    }
                }
                // 重複を削除する
                if(arrayDelete == true){
                    arrayIndexOfDelete.append(indexDestination)
                }
            }

            // 重複している１次元配列を　後ろの番号から削除する
            if(arrayIndexOfDelete.count > 0){
                for indexDelete in arrayIndexOfDelete.reversed()
                {
                    resultCombinationArray.remove(at: indexDelete)
                }
                // 配列の最大値を更新
                numberOfLoopingOutSide = resultCombinationArray.count
                if((indexSource+1) >= numberOfLoopingOutSide){
                    // 配列エラーを防ぐ
                    break;
                }
            }
            
        }
        return
    }

    #if DEBUG
    // デバッグ用 作成された回答の組み合わせをログに出力する
    func DebugPrintResultArray(){
        
        print("2次元配列の数: ",resultCombinationArray.count)
        for oneOfRowArray in resultCombinationArray
        {
            // 1次元を表示
            print(oneOfRowArray)
        }
        
        return
    }
    #endif
    //  ----------------------------- Finish -----------------------------


    /// Description: [計算結果]画面に出力する文字列を作成する
    ///              事前に作成した[オモリの組合せ]配列を元に作成する
    ///              例:
    ///              header(section)
    ///              - [オモリ3個: 3B(1.00g)+余重(0.01g)]\nパターン 7個]
    ///              cell(summary)
    ///              - [G4 + G3 + B]
    ///              cell(detail)
    ///              - [合計 : 1.00g,    余り : 0.01g \nG8(0.07g) G7(0.09g) G7(0.09g) G6(0.12g)]
    /// - Author: sawatch
    /// - Date: 2018/08/14
    /// - Version: 1.0.0
    /// - Parameters:
    ///   - paramA: パラメータAの説明
    ///   - paramB: パラメータBの説明
    /// - Returns: [計算結果]画面に出力する文字列
    func CreatResutTable()->resultTable{
        var returnValue = resultTable()

        // headerの作成    例 : [パターン 7個\nオモリ3個: 3B(1.00g)+余重(0.01g)]
        let headerText:String = "オモリ \(String(format: "%d", appDelegate.db_CaluInterface.theNumberOfSinkers))個 : \(appDelegate.db_CaluInterface.usingFloatSelect)(\(String(format:"%.2lf", selectFlotWeight))g)±余重(\(String(format:"%.2lf", appDelegate.db_CaluInterface.extraWeightSinker)))g\nパターン < \(String(format: "%d", resultCombinationArray.count)) 個>"

        returnValue.header = headerText


        if(resultCombinationArray.count == 0){
            var cellFail = cellTable()
            cellFail.summary = "該当なし"
            cellFail.detail = "選択した組合せは見つかりませんでした。\n再度、各項目を変更して計算してください。"
            returnValue.cells.append(cellFail)
            return returnValue
        }

        // cell
        // 例 : [G4 + G3 + B]
        // 例 : [合計 : 1.00g,    余り : 0.01g \nG8(0.07g) G7(0.09g) G7(0.09g) G6(0.12g)]
        var cell = cellTable()

        var weightSum:Double = 0.0
        var weightExtra:Double = 0.0

        var textSizeSummary:String = ""
        var textSizeDetail:String = ""

        var loopTimes:Int = 0
        var nameNumber:String = ""

        for oneOfCombination in resultCombinationArray
        {
            // 初期化
            cell = cellTable()

            weightSum = 0.0
            weightExtra = 0.0
            loopTimes = 0

            textSizeSummary = ""
            textSizeDetail = ""
            nameNumber = ""

            for oneOfSinker in oneOfCombination
            {
                loopTimes += 1
                nameNumber = ConvertNumberWord(argSource: oneOfSinker.number)

                weightSum += oneOfSinker.weight

                // 例 : [G4 + G3 + B]
                // プラスは最後は付与しない
                if(loopTimes == oneOfCombination.count){
                    textSizeSummary =  "\(textSizeSummary)\(nameNumber)"
                }else{
                    textSizeSummary =  "\(textSizeSummary)\(nameNumber) + "
                }

                // 例 : [G8(0.07g) G7(0.09g) G7(0.09g) G6(0.12g)]
                textSizeDetail = "\(textSizeDetail)\(nameNumber)(\(String(format:"%.2lf",oneOfSinker.weight))g) "
            }
            // 例 : [G4 + G3 + B]
            cell.summary = textSizeSummary

            // [合計 : 1.00g,    余り : 0.01g \nG8(0.07g) G7(0.09g) G7(0.09g) G6(0.12g)]
            weightExtra = weightSum - selectFlotWeight
            cell.detail = "合計 : \(String(format:"%.2lf",weightSum))g    余り : \(String(format:"%.2lf",weightExtra))\n\(textSizeDetail)"

            returnValue.cells.append(cell)
        }

        return returnValue
    }

    /// Description: ウキ/オモリの号数を、プログラム用から表示用に変換する
    ///              例:
    ///              変更[前]: b3
    ///              変更[後]: 3B
    /// - Note: 2018/09/12 - Ver.1.0.1
    ///              項目を追加
    ///              - 1号
    /// - Author: sawatch
    /// - Date: 2018/08/14
    /// - Version: 1.0.0
    /// - Parameters:
    ///   - paramA: プログラム用の号数
    /// - Returns: 表示用の号数
    func ConvertNumberWord(argSource:String)->String{
        var returnDestination:String = ""
        switch(argSource)
        {
        // ["G8","G7","G6","G5","G4","G3","G2","G1","B","B2","B3","B4","B5","B6"]
        case "g8": returnDestination = "G8"
        case "g7": returnDestination = "G7"
        case "g6": returnDestination = "G6"
        case "g5": returnDestination = "G5"
        case "g4": returnDestination = "G4"
        case "g3": returnDestination = "G3"
        case "g2": returnDestination = "G2"
        case "g1": returnDestination = "G1"
        case "b1": returnDestination = "B"
        case "b2": returnDestination = "2B"
        case "b3": returnDestination = "3B"
        case "b4": returnDestination = "4B"
        case "b5": returnDestination = "5B"
        case "b6": returnDestination = "6B"
        case "n1": returnDestination = "1号"
        default: returnDestination = ""          // Error
        }

        return returnDestination
    }


}
