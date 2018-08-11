//
//  ViewControllerResult.swift
//  SinkerCalculation
//
//  Created by さわっち on 2018/06/27.
//  Copyright © 2018年 sawatch. All rights reserved.
//

// Description: [画面4] 計算の結果を出力する画面

// memo: [その1] ViewControllerResult から ViewControllerCalculation へ戻る処理は、
//              ViewControllerCalculation に記述している。

import UIKit

class ViewControllerResult: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 試しに関数のテスト
        MainCalculation()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // 表を作成する処理を記述する
    //  ----------------------------- Start -----------------------------
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //  ----------------------------- Finish -----------------------------
    
    
    // 計算の処理を記述する
    //  ----------------------------- Start -----------------------------
    
    // メンバ変数
    struct Sinker {
        var number: String
        var weight: Double
        
        init(number : String, weight : Double){
            self.number = number
            self.weight = weight
        }
    }
    
    var maxRangeOfWeight:Double = 0
    var minRangeOfWeight:Double = 0
    
    // 計算用のオモリの配列
    var sinkerArrayForCalu = [Sinker]()
    
    // 組合せの結果の2次元配列
    var resultCombinationArray = [[Sinker]]()
    
    
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    /////////////////////
    // 計算処理の最初!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    /////////////////////
    func MainCalculation(){
        
        MakeSinkerArray()
        
        // 最大値と最小値を求める
        SetRangeOfWeight()
        
        // debug
        let start = Date()
        
        // オモリの組合せ 1パターン[1次元 配列][例:0.20g, 0.30g, 0.45g]
        let blankCombinationOfSinkersArray = [Sinker]()
        GetSinkersCombinationRepeatedly(argNumber: 0, argNowCombination: blankCombinationOfSinkersArray)
        
        
        let elapsed_1 = Date().timeIntervalSince(start)
        
        //print("1 - パターン抽出後")
        //DebugPrintResultArray()
        
        // もしパターンが0なら抜けろ！
        // メッセージを出力
        
        // 重複の削除
        DeleteDuplicationMain()

        // debug
        //print("2 - 重複削除後")
        DebugPrintResultArray()
        
        // 経過時間
        let elapsed_2 = Date().timeIntervalSince(start)
        print("経過時間-半分: ",elapsed_1)
        print("経過時間-全部: ",elapsed_2)
        
    }
    
    // 辞書は順番がランダムのため、2次元配列に変更する
    func MakeSinkerArray() {
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
    }
    
    // 最大値を求める (ウキの重量 + 余重)
    func SetRangeOfWeight(){
        var rangeOfWeight:Double = 0.0;
        
        var selectSize:DataBaseTable.WeightIndex = DataBaseTable.WeightIndex.b6
        switch(appDelegate.db_CaluInterface.usingFloatSelect)
        {
        // ["G8","G7","G6","G5","G4","G3","G2","G1","B","B2","B3","B4","B5","B6"]
        case "G8": selectSize = DataBaseTable.WeightIndex.g8
        case "G7": selectSize = DataBaseTable.WeightIndex.g7
        case "G6": selectSize = DataBaseTable.WeightIndex.g6
        case "G5": selectSize = DataBaseTable.WeightIndex.g5
        case "G4": selectSize = DataBaseTable.WeightIndex.g4
        case "G3": selectSize = DataBaseTable.WeightIndex.g3
        case "G2": selectSize = DataBaseTable.WeightIndex.g2
        case "G1": selectSize = DataBaseTable.WeightIndex.g1
        case "B" : selectSize = DataBaseTable.WeightIndex.b1
        case "B2": selectSize = DataBaseTable.WeightIndex.b2
        case "B3": selectSize = DataBaseTable.WeightIndex.b3
        case "B4": selectSize = DataBaseTable.WeightIndex.b4
        case "B5": selectSize = DataBaseTable.WeightIndex.b5
        case "B6": selectSize = DataBaseTable.WeightIndex.b6
        default: selectSize = DataBaseTable.WeightIndex.b6          // Error
        }
        
        rangeOfWeight = appDelegate.db_Weights.db_Float.weights[selectSize]!
        maxRangeOfWeight = rangeOfWeight + appDelegate.db_CaluInterface.extraWeightSinker
        minRangeOfWeight = rangeOfWeight
        
    }
    
    // 組合せの算出
    func GetSinkersCombinationRepeatedly( argNumber:Int, argNowCombination:[Sinker]){
        
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
            GetSinkersCombinationRepeatedly(argNumber: NowIndexSinker, argNowCombination: simpleCombinationOfSinkersArray)
        }
        
        return
    }
    
    
    
    // 2次元配列の重複を削除
    func DeleteDuplicationMain(){
        
        // 2次元配列の並び替え
        resultCombinationArray.sort(by: {$0[0].weight > $1[0].weight})
        
        // 重複の削除
        DeleteDuplicationDetail()
        
        //Debug
        print("Loop処理 再構築後")
        DebugPrintResultArray()
        
        return
    }
    
    
    // 2次元配列の重複を削除
    // true:  削除あり
    // false: 削除なし
    func DeleteDuplicationDetail() {
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
    //  ----------------------------- Finish -----------------------------
    


}
