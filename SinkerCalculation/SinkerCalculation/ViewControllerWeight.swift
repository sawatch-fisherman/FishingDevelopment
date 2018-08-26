//
//  ViewControllerWeight.swift
//  SinkerCalculation
//
//  Created by さわっち on 2018/06/24.
//  Copyright © 2018年 sawatch. All rights reserved.
//

// Description: [画面2] ウキとオモリのオモサを設定する画面

import UIKit
import Eureka

class ViewControllerWeight: FormViewController {

    // クラスのオブジェクトを生成
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let CCalcDB = CalculationDataBase()

    override func viewDidLoad() {
        super.viewDidLoad()

        // TにAを設定
        setAppDelegateToCalculationDataBase()

        // コントロールの設定
        setEurekaControl()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /// Description: [計算], [情報]画面に切替えた際のイベント
    ///              もし項目が１つでも変更されていた場合、
    ///              編集情報を破棄して問題ないか？のメッセージを表示する
    /// - Note: 2018/08/26 - Ver.1.0.1
    /// - Author: sawatch
    /// - Date: 2018/08/17
    /// - Version: 1.0.1
    override func viewWillDisappear(_ animated: Bool) {

        // 未作成
        // 編集フラグをチェック

    }

    /// Description: 保存ボタンの処理
    /// - Author: sawatch
    /// - Date: 2018/08/17
    /// - Version: 1.0.0
    @IBAction func clickButtonSave(_ sender: Any) {
        // 値を設定
        setCalculationDataBaseToAppDelegate()

        // "保存しました"
        let alert = UIAlertController(title: "", message: "保存しました", preferredStyle: UIAlertControllerStyle.alert)
        present(alert, animated: true, completion: {
            // アラートを閉じる
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                alert.dismiss(animated: true, completion: nil)
            })
        })
        return
    }

    /// Description: 取消しボタンの処理
    /// - Author: sawatch
    /// - Date: 2018/08/17
    /// - Version: 1.0.0
    @IBAction func clickButtonCancel(_ sender: Any) {

        // アラートを表示
        let title = "キャンセル確認"
        let message = "編集中の内容を破棄してよろしいですか？"

        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "戻る", style: UIAlertActionStyle.default, handler: {
            (action: UIAlertAction!) -> Void in
            // ボタン押下後の処理
        })

        let cancelAction: UIAlertAction = UIAlertAction(title: "破棄する", style: UIAlertActionStyle.cancel, handler: {
            (action: UIAlertAction!) -> Void in
            // ボタン押下後の処理
            self.setReload()

            // "編集中の内容を破棄しました"
            let alert2 = UIAlertController(title: "", message: "編集中の内容を破棄しました", preferredStyle: UIAlertControllerStyle.alert)
            //present(alert, animated: true, completion: nil)
            self.present(alert2, animated: true, completion: {
                // アラートを閉じる
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    alert2.dismiss(animated: true, completion: nil)
                })
            })

        })

        alert.addAction(cancelAction)
        alert.addAction(defaultAction)

        present(alert, animated: true, completion: nil)

    }

    /// Description: Eurekaの設定
    /// - Author: sawatch
    /// - Date: 2018/08/17
    /// - Version: 1.0.0
    func setEurekaControl() {

        // "オモサ"の正数と小数点の桁数を設定
        let wrapFormatter = DecimalFormatter()
        wrapFormatter.maximumIntegerDigits = 1
        wrapFormatter.minimumIntegerDigits = 1
        wrapFormatter.maximumFractionDigits = 2
        wrapFormatter.minimumFractionDigits = 2
        
        form // ウキの設定
            +++ Section("ウキのオモサ (単位:g)")
            <<< DecimalRow("float_g8") {
                $0.title = "G8"
                $0.value = CCalcDB.getArrayDataBaseWeightFloat(getKey: .g8)
                $0.formatter = wrapFormatter
                }.onChange{ row in
                    self.CCalcDB.setArrayDataBaseWeightFloat(setKey: .g8, setValue: row.value!)
            }
            <<< DecimalRow("float_g7") {
                $0.title = "G7"
                $0.value = CCalcDB.getArrayDataBaseWeightFloat(getKey: .g7)
                $0.formatter = wrapFormatter
                }.onChange{ row in
                    self.CCalcDB.setArrayDataBaseWeightFloat(setKey: .g7, setValue: row.value!)
            }
            <<< DecimalRow("float_g6") {
                $0.title = "G6"
                $0.value = CCalcDB.getArrayDataBaseWeightFloat(getKey: .g6)
                $0.formatter = wrapFormatter
                }.onChange{ row in
                    
                    self.CCalcDB.setArrayDataBaseWeightFloat(setKey: .g6, setValue: row.value!)
            }
            <<< DecimalRow("float_g5") {
                $0.title = "G5"
                $0.value = CCalcDB.getArrayDataBaseWeightFloat(getKey: .g5)
                $0.formatter = wrapFormatter
                }.onChange{ row in
                    self.CCalcDB.setArrayDataBaseWeightFloat(setKey: .g5, setValue: row.value!)
            }
            <<< DecimalRow("float_g4") {
                $0.title = "G4"
                $0.value = CCalcDB.getArrayDataBaseWeightFloat(getKey: .g4)
                $0.formatter = wrapFormatter
                }.onChange{ row in
                    self.CCalcDB.setArrayDataBaseWeightFloat(setKey: .g4, setValue: row.value!)
            }
            <<< DecimalRow("float_g3") {
                $0.title = "G3"
                $0.value = CCalcDB.getArrayDataBaseWeightFloat(getKey: .g3)
                $0.formatter = wrapFormatter
                }.onChange{ row in
                    self.CCalcDB.setArrayDataBaseWeightFloat(setKey: .g3, setValue: row.value!)
            }
            <<< DecimalRow("float_g2") {
                $0.title = "G2"
                $0.value = CCalcDB.getArrayDataBaseWeightFloat(getKey: .g2)
                $0.formatter = wrapFormatter
                }.onChange{ row in
                    self.CCalcDB.setArrayDataBaseWeightFloat(setKey: .g2, setValue: row.value!)
            }
            <<< DecimalRow("float_g1") {
                $0.title = "G1"
                $0.value = CCalcDB.getArrayDataBaseWeightFloat(getKey: .g1)
                $0.formatter = wrapFormatter
                }.onChange{ row in
                    self.CCalcDB.setArrayDataBaseWeightFloat(setKey: .g1, setValue: row.value!)
            }
            <<< DecimalRow("float_b1") {
                $0.title = "B"
                $0.value = CCalcDB.getArrayDataBaseWeightFloat(getKey: .b1)
                $0.formatter = wrapFormatter
                }.onChange{ row in
                    self.CCalcDB.setArrayDataBaseWeightFloat(setKey: .b1, setValue: row.value!)
            }
            <<< DecimalRow("float_b2") {
                $0.title = "2B"
                $0.value = CCalcDB.getArrayDataBaseWeightFloat(getKey: .b2)
                $0.formatter = wrapFormatter
                }.onChange{ row in
                    self.CCalcDB.setArrayDataBaseWeightFloat(setKey: .b2, setValue: row.value!)
            }
            <<< DecimalRow("float_b3") {
                $0.title = "3B"
                $0.value = CCalcDB.getArrayDataBaseWeightFloat(getKey: .b3)
                $0.formatter = wrapFormatter
                }.onChange{ row in
                    self.CCalcDB.setArrayDataBaseWeightFloat(setKey: .b3, setValue: row.value!)
            }
            <<< DecimalRow("float_b4") {
                $0.title = "4B"
                $0.value = CCalcDB.getArrayDataBaseWeightFloat(getKey: .b4)
                $0.formatter = wrapFormatter
                }.onChange{ row in
                    self.CCalcDB.setArrayDataBaseWeightFloat(setKey: .b4, setValue: row.value!)
            }
            <<< DecimalRow("float_b5") {
                $0.title = "5B"
                $0.value = CCalcDB.getArrayDataBaseWeightFloat(getKey: .b5)
                $0.formatter = wrapFormatter
                }.onChange{ row in
                    self.CCalcDB.setArrayDataBaseWeightFloat(setKey: .b5, setValue: row.value!)
            }
            <<< DecimalRow("float_b6") {
                $0.title = "6B"
                $0.value = CCalcDB.getArrayDataBaseWeightFloat(getKey: .b6)
                $0.formatter = wrapFormatter
                }.onChange{ row in
                    self.CCalcDB.setArrayDataBaseWeightFloat(setKey: .b6, setValue: row.value!)
            }
            
            // オモリの設定
            +++ Section("オモリのオモサ (単位:g)")
            <<< DecimalRow("sinker_g8") {
                $0.title = "G8"
                $0.value = CCalcDB.getArrayDataBaseWeightSinker(getKey: .g8)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueSinkers(argIndex: DataBaseTable.WeightNumber.g8.rawValue, checkValue: row.value!)
            }
            <<< DecimalRow("sinker_g7") {
                $0.title = "G7"
                $0.value = CCalcDB.getArrayDataBaseWeightSinker(getKey: .g7)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueSinkers(argIndex: DataBaseTable.WeightNumber.g7.rawValue, checkValue: row.value!)
            }
            <<< DecimalRow("sinker_g6") {
                $0.title = "G6"
                $0.value = CCalcDB.getArrayDataBaseWeightSinker(getKey: .g6)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueSinkers(argIndex: DataBaseTable.WeightNumber.g6.rawValue, checkValue: row.value!)
            }
            <<< DecimalRow("sinker_g5") {
                $0.title = "G5"
                $0.value = CCalcDB.getArrayDataBaseWeightSinker(getKey: .g5)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueSinkers(argIndex: DataBaseTable.WeightNumber.g5.rawValue, checkValue: row.value!)
            }
            <<< DecimalRow("sinker_g4") {
                $0.title = "G4"
                $0.value = CCalcDB.getArrayDataBaseWeightSinker(getKey: .g4)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueSinkers(argIndex: DataBaseTable.WeightNumber.g4.rawValue, checkValue: row.value!)
            }
            <<< DecimalRow("sinker_g3") {
                $0.title = "G3"
                $0.value = CCalcDB.getArrayDataBaseWeightSinker(getKey: .g3)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueSinkers(argIndex: DataBaseTable.WeightNumber.g3.rawValue, checkValue: row.value!)
            }
            <<< DecimalRow("sinker_g2") {
                $0.title = "G2"
                $0.value = CCalcDB.getArrayDataBaseWeightSinker(getKey: .g2)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueSinkers(argIndex: DataBaseTable.WeightNumber.g2.rawValue, checkValue: row.value!)
            }
            <<< DecimalRow("sinker_g1") {
                $0.title = "G1"
                $0.value = CCalcDB.getArrayDataBaseWeightSinker(getKey: .g1)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueSinkers(argIndex: DataBaseTable.WeightNumber.g1.rawValue, checkValue: row.value!)
            }
            <<< DecimalRow("sinker_b1") {
                $0.title = "B"
                $0.value = CCalcDB.getArrayDataBaseWeightSinker(getKey: .b1)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueSinkers(argIndex: DataBaseTable.WeightNumber.b1.rawValue, checkValue: row.value!)
            }
            <<< DecimalRow("sinker_b2") {
                $0.title = "2B"
                $0.value = CCalcDB.getArrayDataBaseWeightSinker(getKey: .b2)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueSinkers(argIndex: DataBaseTable.WeightNumber.b2.rawValue, checkValue: row.value!)
            }
            <<< DecimalRow("sinker_b3") {
                $0.title = "3B"
                $0.value = CCalcDB.getArrayDataBaseWeightSinker(getKey: .b3)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueSinkers(argIndex: DataBaseTable.WeightNumber.b3.rawValue, checkValue: row.value!)
            }
            <<< DecimalRow("sinker_b4") {
                $0.title = "4B"
                $0.value = CCalcDB.getArrayDataBaseWeightSinker(getKey: .b4)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueSinkers(argIndex: DataBaseTable.WeightNumber.b4.rawValue, checkValue: row.value!)
            }
            <<< DecimalRow("sinker_b5") {
                $0.title = "5B"
                $0.value = CCalcDB.getArrayDataBaseWeightSinker(getKey: .b5)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueSinkers(argIndex: DataBaseTable.WeightNumber.b5.rawValue, checkValue: row.value!)
            }
            <<< DecimalRow("sinker_b6") {
                $0.title = "6B"
                $0.value = CCalcDB.getArrayDataBaseWeightSinker(getKey: .b6)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueSinkers(argIndex: DataBaseTable.WeightNumber.b6.rawValue, checkValue: row.value!)
        }

    }


    /// Description:    設定値を変更前に戻す
    /// - Note:         "破棄する"が選択された場合に動作する
    ///                 2018/08/26 - Ver.1.0.1
    ///                   処理のロジックを修正
    /// - Author:       sawatch
    /// - Date:         2018/08/17
    /// - Version:      1.0.0
    func setReload(){
        // キャンセルの処理

        // 値を戻す
        for index in 0..<DataBaseTable.WeightNumber.WeightNumbers.count{
            // ウキ
            form.rowBy(tag: DataBaseTable.UserDefaultsTag.FloatTags[index].rawValue)?.baseValue = appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.WeightIndexs[index]]!
            form.rowBy(tag: DataBaseTable.UserDefaultsTag.FloatTags[index].rawValue)?.reload()

            // オモリ
            form.rowBy(tag: DataBaseTable.UserDefaultsTag.SinkerTags[index].rawValue)?.baseValue = appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.WeightIndexs[index]]!
            form.rowBy(tag: DataBaseTable.UserDefaultsTag.SinkerTags[index].rawValue)?.reload()

            #if DEBUG
            let debugFloat:Double = appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.WeightIndexs[index]]!
            print(debugFloat)
            let debugSinker:Double = appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.WeightIndexs[index]]!
            print(debugSinker)
            #endif
        }

    }

    /// Description: AppDelegateの値をDataBaseテーブル変数に保存する
    ///              使用状況: 編集した値を以前の値に戻したい時に使用する
    ///                       1. 画面起動時
    ///                       2. 取消し
    ///                       3. 他の画面に移動
    /// - Note: 2018/08/26 - Ver.1.0.1
    ///              初回起動時にAppDelegateの値が全て"0"の不具合を修正
    ///              UserDefaultsを初期化する処理を別関数に置き換え
    /// - Author: sawatch
    /// - Date: 2018/08/17
    /// - Version: 1.0.0
    func setAppDelegateToCalculationDataBase(){

        // 値を戻す
        for index in 0..<DataBaseTable.WeightNumber.WeightNumbers.count{
            // ウキ
            CCalcDB.setArrayDataBaseWeightFloat(setKey: DataBaseTable.WeightIndex.WeightIndexs[index],
                                                 setValue: appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.WeightIndexs[index]]!)

            // オモリ
            CCalcDB.setArrayDataBaseWeightSinker(setKey: DataBaseTable.WeightIndex.WeightIndexs[index],
                                                 setValue: appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.WeightIndexs[index]]!)

            #if DEBUG
            let debugFloat1:String = DataBaseTable.WeightIndex.WeightIndexs[index].rawValue
            print(debugFloat1)
            let debugFloat2:Double = appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.WeightIndexs[index]]!
            print(debugFloat2)
            let debugSinker1:String = DataBaseTable.WeightIndex.WeightIndexs[index].rawValue
            print(debugSinker1)
            let debugSinker2:Double = appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.WeightIndexs[index]]!
            print(debugSinker2)
            #endif
        }

        return
    }
    
    // TをAへ設定
    // When do you use this function?
    // 1.Save                 保存
    func setCalculationDataBaseToAppDelegate(){
        // ウキ
        appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g8] = CCalcDB.getArrayDataBaseWeightFloat(getKey: .g8)
        appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g7] = CCalcDB.getArrayDataBaseWeightFloat(getKey: .g7)
        appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g6] = CCalcDB.getArrayDataBaseWeightFloat(getKey: .g6)
        appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g5] = CCalcDB.getArrayDataBaseWeightFloat(getKey: .g5)
        appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g4] = CCalcDB.getArrayDataBaseWeightFloat(getKey: .g4)
        appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g3] = CCalcDB.getArrayDataBaseWeightFloat(getKey: .g3)
        appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g2] = CCalcDB.getArrayDataBaseWeightFloat(getKey: .g2)
        appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g1] = CCalcDB.getArrayDataBaseWeightFloat(getKey: .g1)
        appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.b1] = CCalcDB.getArrayDataBaseWeightFloat(getKey: .b1)
        appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.b2] = CCalcDB.getArrayDataBaseWeightFloat(getKey: .b2)
        appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.b3] = CCalcDB.getArrayDataBaseWeightFloat(getKey: .b3)
        appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.b4] = CCalcDB.getArrayDataBaseWeightFloat(getKey: .b4)
        appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.b5] = CCalcDB.getArrayDataBaseWeightFloat(getKey: .b5)
        appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.b6] = CCalcDB.getArrayDataBaseWeightFloat(getKey: .b6)
        
        // オモリ
        appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g8] = CCalcDB.getArrayDataBaseWeightSinker(getKey: .g8)
        appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g7] = CCalcDB.getArrayDataBaseWeightSinker(getKey: .g7)
        appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g6] = CCalcDB.getArrayDataBaseWeightSinker(getKey: .g6)
        appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g5] = CCalcDB.getArrayDataBaseWeightSinker(getKey: .g5)
        appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g4] = CCalcDB.getArrayDataBaseWeightSinker(getKey: .g4)
        appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g3] = CCalcDB.getArrayDataBaseWeightSinker(getKey: .g3)
        appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g2] = CCalcDB.getArrayDataBaseWeightSinker(getKey: .g2)
        appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g1] = CCalcDB.getArrayDataBaseWeightSinker(getKey: .g1)
        appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.b1] = CCalcDB.getArrayDataBaseWeightSinker(getKey: .b1)
        appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.b2] = CCalcDB.getArrayDataBaseWeightSinker(getKey: .b2)
        appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.b3] = CCalcDB.getArrayDataBaseWeightSinker(getKey: .b3)
        appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.b4] = CCalcDB.getArrayDataBaseWeightSinker(getKey: .b4)
        appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.b5] = CCalcDB.getArrayDataBaseWeightSinker(getKey: .b5)
        appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.b6] = CCalcDB.getArrayDataBaseWeightSinker(getKey: .b6)
        
        // UserDefaultへ保存
        let defaults: UserDefaults = UserDefaults.standard

        // ウキ
        defaults.set(appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g8], forKey: DataBaseTable.UserDefaultsTag.float_g8.rawValue)
        defaults.set(appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g7], forKey: DataBaseTable.UserDefaultsTag.float_g7.rawValue)
        defaults.set(appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g6], forKey: DataBaseTable.UserDefaultsTag.float_g6.rawValue)
        defaults.set(appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g5], forKey: DataBaseTable.UserDefaultsTag.float_g5.rawValue)
        defaults.set(appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g4], forKey: DataBaseTable.UserDefaultsTag.float_g4.rawValue)
        defaults.set(appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g3], forKey: DataBaseTable.UserDefaultsTag.float_g3.rawValue)
        defaults.set(appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g2], forKey: DataBaseTable.UserDefaultsTag.float_g2.rawValue)
        defaults.set(appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g1], forKey: DataBaseTable.UserDefaultsTag.float_g1.rawValue)
        defaults.set(appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.b1], forKey: DataBaseTable.UserDefaultsTag.float_b1.rawValue)
        defaults.set(appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.b2], forKey: DataBaseTable.UserDefaultsTag.float_b2.rawValue)
        defaults.set(appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.b3], forKey: DataBaseTable.UserDefaultsTag.float_b3.rawValue)
        defaults.set(appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.b4], forKey: DataBaseTable.UserDefaultsTag.float_b4.rawValue)
        defaults.set(appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.b5], forKey: DataBaseTable.UserDefaultsTag.float_b5.rawValue)
        defaults.set(appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.b6], forKey: DataBaseTable.UserDefaultsTag.float_b6.rawValue)
        
        // オモリ
        defaults.set(appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g8], forKey: DataBaseTable.UserDefaultsTag.sinker_g8.rawValue)
        defaults.set(appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g7], forKey: DataBaseTable.UserDefaultsTag.sinker_g7.rawValue)
        defaults.set(appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g6], forKey: DataBaseTable.UserDefaultsTag.sinker_g6.rawValue)
        defaults.set(appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g5], forKey: DataBaseTable.UserDefaultsTag.sinker_g5.rawValue)
        defaults.set(appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g4], forKey: DataBaseTable.UserDefaultsTag.sinker_g4.rawValue)
        defaults.set(appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g3], forKey: DataBaseTable.UserDefaultsTag.sinker_g3.rawValue)
        defaults.set(appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g2], forKey: DataBaseTable.UserDefaultsTag.sinker_g2.rawValue)
        defaults.set(appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g1], forKey: DataBaseTable.UserDefaultsTag.sinker_g1.rawValue)
        defaults.set(appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.b1], forKey: DataBaseTable.UserDefaultsTag.sinker_b1.rawValue)
        defaults.set(appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.b2], forKey: DataBaseTable.UserDefaultsTag.sinker_b2.rawValue)
        defaults.set(appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.b3], forKey: DataBaseTable.UserDefaultsTag.sinker_b3.rawValue)
        defaults.set(appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.b4], forKey: DataBaseTable.UserDefaultsTag.sinker_b4.rawValue)
        defaults.set(appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.b5], forKey: DataBaseTable.UserDefaultsTag.sinker_b5.rawValue)
        defaults.set(appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.b6], forKey: DataBaseTable.UserDefaultsTag.sinker_b6.rawValue)
        
        return
    }


    var editSinkers:[Bool] = [false, false, false, false, false,
                              false, false, false, false, false,
                              false, false, false, false]
    var beforeValueSinkers:[Double] = [ 0.0, 0.0, 0.0, 0.0, 0.0,
                                        0.0, 0.0, 0.0, 0.0, 0.0,
                                        0.0, 0.0, 0.0, 0.0]

    /// Description: Sinker項目のEurekaの値のチェックを行う
    ///              フォーカスの状態
    ///              IN:  editSinkersをtrueにする
    ///              OUT: 変更された値が、他の項目と重複していないか確認する
    ///                   editSinkersをfalseにする
    ///              チェック
    ///              >> 0 チェック
    ///              >> 他の項目との重複チェック
    /// - Note: 2018/08/25 - Ver.1.0.1
    ///              値のチェックする処理を修正
    ///              ・関数名を修正
    ///              ・0チェックの関数を追加
    ///
    /// - Author: sawatch
    /// - Date: 2018/08/19
    /// - Version: 1.0.0
    /// - Parameters:
    ///   - argIndex:Int    変更した項目のサイズ
    ///   - argSetValue:Double     変更する値
    func checkValueSinkers(argIndex:Int, checkValue:Double){
        if(editSinkers[argIndex] == false){
            beforeValueSinkers[argIndex] = checkValue
            editSinkers[argIndex] = true
        } else {
            let resultZero:Bool = CheckZeroValueSinker(argIndex: argIndex, argSetValue: checkValue)
            if(resultZero == false){
                CheckDuplicationValueSinker(argIndex: argIndex, argSetValue: checkValue)
            }
            editSinkers[argIndex] = false
        }

        return
    }

    /// Description: 重量が変更された場合、値が0かチェックする
    ///              重複あり: メッセージを出力する
    ///                       編集前の値に戻す
    ///              重複なし: 何もしない
    ///
    /// - Author: sawatch
    /// - Date: 2018/08/25
    /// - Version: 1.0.1
    /// - Parameters:
    ///   - argIndex:Int    変更した項目のサイズ
    ///   - argSetValue:Double     変更する値
    /// - Returns: true : 値は0.00
    ///            false: 値は0.01以上
    func CheckZeroValueSinker(argIndex:Int, argSetValue:Double)->Bool{
        if(argSetValue.isZero){
            // 値はゼロ
            // アラートを表示
            let title = "入力値エラー"
            let message = "重量の値が 0 です。\n0.01以上の重量を設定してください。"
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
                (action: UIAlertAction!) -> Void in
                // ボタン押下後の処理
                // 編集前の値に戻す
                let selectTag:String = self.convertIndexToTag(argIndex: argIndex)
                self.form.rowBy(tag: selectTag)?.baseValue = self.beforeValueSinkers[argIndex]
                self.form.rowBy(tag: selectTag)?.reload()
            })
            
            alert.addAction(defaultAction)
            present(alert, animated: true, completion: nil)
            return true
        }
        return false
    }

    /// Description: 重量が変更された場合、他の項目と重複していないか確認する
    ///              重複あり: メッセージを出力する
    ///                       編集前の値に戻す
    ///              重複なし:DbWeightSinkerの値を更新する
    ///
    /// - Note: 2018/08/25 - Ver.1.0.1
    ///              関数名を修正: "CheckDuplicationValueFloat" → "CheckDuplicationValueSinker"
    ///              Indexからタグ名と文字型の目次を取得する処理を別関数に置き換え
    /// - Author: sawatch
    /// - Date: 2018/08/19
    /// - Version: 1.0.0
    /// - Parameters:
    ///   - argIndex:Int    変更した項目のサイズ
    ///   - argSetValue:Double     変更する値
    /// - Returns: [計算結果]画面に出力する文字列
    func CheckDuplicationValueSinker(argIndex:Int, argSetValue:Double){
        var editFlag:Bool = false
        var valueCompare:Double = 0.0

        // 設定するEurekaのタグ名とインデックスを取得する
        let selectTag:String = convertIndexToTag(argIndex: argIndex)
        let selectKey:String = convertIndexToKey(argIndex: argIndex)

        // 他の項目と重量が重複していないか確認する
        for indexWeight in DataBaseTable.WeightIndex.WeightIndexs
        {
            valueCompare = CCalcDB.getArrayDataBaseWeightSinker(getKey: indexWeight)

            // 編集中の項目は対象外
            if(selectKey == indexWeight.rawValue){
                continue
            }
            // 他の項目と値が重複した場合、エラーとする
            if(argSetValue == valueCompare){
                editFlag = true
                break;
            }
        }

        if(editFlag == true){
            // 重複あり
            // アラートを表示
            let title = "重複エラー"
            let message = "他のオモリと同じ重量になっています。\n他のオモリと異なる重量を設定してください。"
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
                (action: UIAlertAction!) -> Void in
                // ボタン押下後の処理
                // 編集前の値に戻す
                self.form.rowBy(tag: selectTag)?.baseValue = self.beforeValueSinkers[argIndex]
                self.form.rowBy(tag: selectTag)?.reload()
            })
            
            alert.addAction(defaultAction)
            present(alert, animated: true, completion: nil)
        }else{
            // 重複なし
            // 書込み
            self.CCalcDB.setArrayDataBaseWeightSinker(setKey: DataBaseTable.WeightIndex(rawValue: selectKey)!, setValue: argSetValue)
            print(argSetValue)
        }
        
        return
    }

    /// Description: 設定するEurekaのタグ名を取得する
    /// - Author: sawatch
    /// - Date: 2018/08/25
    /// - Version: 1.0.1
    /// - Parameters:
    ///   - argIndex:Int    変更した項目のサイズ
    /// - Returns: 設定するEurekaのタグ名
    func convertIndexToTag(argIndex:Int) -> String {
        // 設定するEurekaのタグ名を取得する
        var selectTag:String = ""
        switch(argIndex)
        {
        case DataBaseTable.WeightNumber.g8.rawValue:
            selectTag  = DataBaseTable.UserDefaultsTag.sinker_g8.rawValue
        case DataBaseTable.WeightNumber.g7.rawValue:
            selectTag  = DataBaseTable.UserDefaultsTag.sinker_g7.rawValue
        case DataBaseTable.WeightNumber.g6.rawValue:
            selectTag  = DataBaseTable.UserDefaultsTag.sinker_g6.rawValue
        case DataBaseTable.WeightNumber.g5.rawValue:
            selectTag  = DataBaseTable.UserDefaultsTag.sinker_g5.rawValue
        case DataBaseTable.WeightNumber.g4.rawValue:
            selectTag  = DataBaseTable.UserDefaultsTag.sinker_g4.rawValue
        case DataBaseTable.WeightNumber.g3.rawValue:
            selectTag  = DataBaseTable.UserDefaultsTag.sinker_g3.rawValue
        case DataBaseTable.WeightNumber.g2.rawValue:
            selectTag  = DataBaseTable.UserDefaultsTag.sinker_g2.rawValue
        case DataBaseTable.WeightNumber.g1.rawValue:
            selectTag  = DataBaseTable.UserDefaultsTag.sinker_g1.rawValue
        case DataBaseTable.WeightNumber.b1.rawValue:
            selectTag  = DataBaseTable.UserDefaultsTag.sinker_b1.rawValue
        case DataBaseTable.WeightNumber.b2.rawValue:
            selectTag  = DataBaseTable.UserDefaultsTag.sinker_b2.rawValue
        case DataBaseTable.WeightNumber.b3.rawValue:
            selectTag  = DataBaseTable.UserDefaultsTag.sinker_b3.rawValue
        case DataBaseTable.WeightNumber.b4.rawValue:
            selectTag  = DataBaseTable.UserDefaultsTag.sinker_b4.rawValue
        case DataBaseTable.WeightNumber.b5.rawValue:
            selectTag  = DataBaseTable.UserDefaultsTag.sinker_b5.rawValue
        case DataBaseTable.WeightNumber.b6.rawValue:
            selectTag  = DataBaseTable.UserDefaultsTag.sinker_b6.rawValue
        default:
            print("convertIndexToTag-Error")
        }

        return selectTag
    }

    /// Description: 整数のインデックスを取得する
    /// - Author: sawatch
    /// - Date: 2018/08/25
    /// - Version: 1.0.1
    /// - Parameters:
    ///   - argIndex:Int    変更した項目のサイズ
    /// - Returns: 設定するEurekaのタグ名
    func convertIndexToKey(argIndex:Int) -> String {
        // 設定するEurekaのタグ名を取得する
        var selectKey:String = ""

        switch(argIndex)
        {
        case DataBaseTable.WeightNumber.g8.rawValue:
            selectKey   = DataBaseTable.WeightIndex.g8.rawValue
        case DataBaseTable.WeightNumber.g7.rawValue:
            selectKey   = DataBaseTable.WeightIndex.g7.rawValue
        case DataBaseTable.WeightNumber.g6.rawValue:
            selectKey   = DataBaseTable.WeightIndex.g6.rawValue
        case DataBaseTable.WeightNumber.g5.rawValue:
            selectKey   = DataBaseTable.WeightIndex.g5.rawValue
        case DataBaseTable.WeightNumber.g4.rawValue:
            selectKey   = DataBaseTable.WeightIndex.g4.rawValue
        case DataBaseTable.WeightNumber.g3.rawValue:
            selectKey   = DataBaseTable.WeightIndex.g3.rawValue
        case DataBaseTable.WeightNumber.g2.rawValue:
            selectKey   = DataBaseTable.WeightIndex.g2.rawValue
        case DataBaseTable.WeightNumber.g1.rawValue:
            selectKey   = DataBaseTable.WeightIndex.g1.rawValue
        case DataBaseTable.WeightNumber.b1.rawValue:
            selectKey   = DataBaseTable.WeightIndex.b1.rawValue
        case DataBaseTable.WeightNumber.b2.rawValue:
            selectKey   = DataBaseTable.WeightIndex.b2.rawValue
        case DataBaseTable.WeightNumber.b3.rawValue:
            selectKey   = DataBaseTable.WeightIndex.b3.rawValue
        case DataBaseTable.WeightNumber.b4.rawValue:
            selectKey   = DataBaseTable.WeightIndex.b4.rawValue
        case DataBaseTable.WeightNumber.b5.rawValue:
            selectKey   = DataBaseTable.WeightIndex.b5.rawValue
        case DataBaseTable.WeightNumber.b6.rawValue:
            selectKey   = DataBaseTable.WeightIndex.b6.rawValue
        default:
            print("convertIndexToKey-Error")
        }

        return selectKey
    }
}
