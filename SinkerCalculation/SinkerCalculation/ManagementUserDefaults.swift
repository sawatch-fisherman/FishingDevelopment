//
//  ManagementUserDefaults.swift
//  SinkerCalculation
//
//  Created by さわっち on 2018/09/17.
//  Copyright © 2018年 sawatch. All rights reserved.
//
/// Description: UserDefaultsクラス関連の操作をする関数をまとめたクラス
/// - Author: sawatch
/// - Date: 2018/09/17
/// - Version: 1.0.1


import Foundation
import UIKit

class ManagementUserDefaults {
    let defaults: UserDefaults = UserDefaults.standard
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    /// Description: 全てのAppDelegateの値をUserDefaultsに保存する
    ///              - 編集を無効にする
    ///              - 選択を無効にする
    /// - Author: sawatch
    /// - Date: 2018/09/17
    /// - Version: 1.0.1
    func setAllAppDelegateToDefaults(){
        // [計算]画面の設定値
        defaults.set(appDelegate.db_CaluInterface.usingFloatSelect, forKey: DataBaseTable.UserDefaultsTag.using_float_select.rawValue)
        defaults.set(appDelegate.db_CaluInterface.theNumberOfSinkers, forKey: DataBaseTable.UserDefaultsTag.the_number_of_sinkers.rawValue)
        defaults.set(appDelegate.db_CaluInterface.extraWeightSinker, forKey: DataBaseTable.UserDefaultsTag.extra_weight_sinker.rawValue)
        
        // [設定]画面の設定値
        for index in 0..<DataBaseTable.WeightNumber.WeightNumbers.count{
        
        defaults.set(appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.WeightIndexs[index]], forKey: DataBaseTable.UserDefaultsTag.FloatTags[index].rawValue)
        defaults.set(appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.WeightIndexs[index]], forKey: DataBaseTable.UserDefaultsTag.SinkerTags[index].rawValue)
        
        #if DEBUG
        print("Keys:", DataBaseTable.WeightIndex.WeightIndexs[index])
        let debugFloat:Double = defaults.double(forKey: DataBaseTable.UserDefaultsTag.FloatTags[index].rawValue)
        print("Float:",debugFloat)
        let debugSinker:Double = defaults.double(forKey: DataBaseTable.UserDefaultsTag.SinkerTags[index].rawValue)
        print("Sinker:",debugSinker)
        #endif
        }

        return
    }

    /// Description: UserDefaultsの全ての値にデフォルト値を設定する
    /// - Warning:   register関数は保存しているわけではないので注意
    ///              register関数後は絶対に保存関数(set)を入れること
    /// - Note:      setUserDefaultsToAppDelegateから処理を抜粋して作成
    /// - Author:    sawatch
    /// - Date:      2018/09/17
    /// - Version:   1.0.1
    func formatAllUserDefaults(){
        // [計算]画面の設定値
        defaults.register(defaults: [DataBaseTable.UserDefaultsTag.using_float_select.rawValue : DataBaseTable.WeightShow.b3.rawValue])
        defaults.register(defaults: [DataBaseTable.UserDefaultsTag.using_float_weight.rawValue : 0.00])
        defaults.register(defaults: [DataBaseTable.UserDefaultsTag.the_number_of_sinkers.rawValue : 2])
        defaults.register(defaults: [DataBaseTable.UserDefaultsTag.extra_weight_sinker.rawValue : 0.0])

        // [設定]画面の設定値 オモリ
        defaults.register(defaults: [DataBaseTable.UserDefaultsTag.float_g8.rawValue : 0.07])
        defaults.register(defaults: [DataBaseTable.UserDefaultsTag.float_g7.rawValue : 0.09])
        defaults.register(defaults: [DataBaseTable.UserDefaultsTag.float_g6.rawValue : 0.12])
        defaults.register(defaults: [DataBaseTable.UserDefaultsTag.float_g5.rawValue : 0.17])
        defaults.register(defaults: [DataBaseTable.UserDefaultsTag.float_g4.rawValue : 0.20])
        defaults.register(defaults: [DataBaseTable.UserDefaultsTag.float_g3.rawValue : 0.25])
        defaults.register(defaults: [DataBaseTable.UserDefaultsTag.float_g2.rawValue : 0.33])
        defaults.register(defaults: [DataBaseTable.UserDefaultsTag.float_g1.rawValue : 0.45])
        defaults.register(defaults: [DataBaseTable.UserDefaultsTag.float_b1.rawValue : 0.55])
        defaults.register(defaults: [DataBaseTable.UserDefaultsTag.float_b2.rawValue : 0.80])
        defaults.register(defaults: [DataBaseTable.UserDefaultsTag.float_b3.rawValue : 1.00])
        defaults.register(defaults: [DataBaseTable.UserDefaultsTag.float_b4.rawValue : 1.25])
        defaults.register(defaults: [DataBaseTable.UserDefaultsTag.float_b5.rawValue : 1.75])
        defaults.register(defaults: [DataBaseTable.UserDefaultsTag.float_b6.rawValue : 2.20])
        defaults.register(defaults: [DataBaseTable.UserDefaultsTag.float_n1.rawValue : 3.75])

        // [設定]画面の設定値 ウキ
        defaults.register(defaults: [DataBaseTable.UserDefaultsTag.sinker_g8.rawValue : 0.07])
        defaults.register(defaults: [DataBaseTable.UserDefaultsTag.sinker_g7.rawValue : 0.09])
        defaults.register(defaults: [DataBaseTable.UserDefaultsTag.sinker_g6.rawValue : 0.12])
        defaults.register(defaults: [DataBaseTable.UserDefaultsTag.sinker_g5.rawValue : 0.17])
        defaults.register(defaults: [DataBaseTable.UserDefaultsTag.sinker_g4.rawValue : 0.20])
        defaults.register(defaults: [DataBaseTable.UserDefaultsTag.sinker_g3.rawValue : 0.25])
        defaults.register(defaults: [DataBaseTable.UserDefaultsTag.sinker_g2.rawValue : 0.33])
        defaults.register(defaults: [DataBaseTable.UserDefaultsTag.sinker_g1.rawValue : 0.45])
        defaults.register(defaults: [DataBaseTable.UserDefaultsTag.sinker_b1.rawValue : 0.55])
        defaults.register(defaults: [DataBaseTable.UserDefaultsTag.sinker_b2.rawValue : 0.80])
        defaults.register(defaults: [DataBaseTable.UserDefaultsTag.sinker_b3.rawValue : 1.00])
        defaults.register(defaults: [DataBaseTable.UserDefaultsTag.sinker_b4.rawValue : 1.25])
        defaults.register(defaults: [DataBaseTable.UserDefaultsTag.sinker_b5.rawValue : 1.75])
        defaults.register(defaults: [DataBaseTable.UserDefaultsTag.sinker_b6.rawValue : 2.20])
        defaults.register(defaults: [DataBaseTable.UserDefaultsTag.sinker_n1.rawValue : 3.75])

        return
    }

}
