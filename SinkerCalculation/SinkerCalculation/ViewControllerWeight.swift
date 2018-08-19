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


    // キャンセルボタンで設定変更前に戻す

    /// Description:    設定値を変更前に戻す
    /// - note:         "破棄する"が選択された場合に動作する
    /// - Author:       sawatch
    /// - Date:         2018/08/17
    /// - Version:      1.0.0
    func setReload(){
        // キャンセルの処理

        // オモリ
        form.rowBy(tag: "sinker_g8")?.baseValue = appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g8]!
        form.rowBy(tag: "sinker_g8")?.reload()
        form.rowBy(tag: "sinker_g7")?.baseValue = appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g7]!
        form.rowBy(tag: "sinker_g7")?.reload()
        form.rowBy(tag: "sinker_g6")?.baseValue = appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g6]!
        form.rowBy(tag: "sinker_g6")?.reload()
        form.rowBy(tag: "sinker_g5")?.baseValue = appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g5]!
        form.rowBy(tag: "sinker_g5")?.reload()
        form.rowBy(tag: "sinker_g4")?.baseValue = appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g4]!
        form.rowBy(tag: "sinker_g4")?.reload()
        form.rowBy(tag: "sinker_g3")?.baseValue = appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g3]!
        form.rowBy(tag: "sinker_g3")?.reload()
        form.rowBy(tag: "sinker_g2")?.baseValue = appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g2]!
        form.rowBy(tag: "sinker_g2")?.reload()
        form.rowBy(tag: "sinker_g1")?.baseValue = appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g1]!
        form.rowBy(tag: "sinker_g1")?.reload()
        form.rowBy(tag: "sinker_b1")?.baseValue = appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.b1]!
        form.rowBy(tag: "sinker_b1")?.reload()
        form.rowBy(tag: "sinker_b2")?.baseValue = appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.b2]!
        form.rowBy(tag: "sinker_b2")?.reload()
        form.rowBy(tag: "sinker_b3")?.baseValue = appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.b3]!
        form.rowBy(tag: "sinker_b3")?.reload()
        form.rowBy(tag: "sinker_b4")?.baseValue = appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.b4]!
        form.rowBy(tag: "sinker_b4")?.reload()
        form.rowBy(tag: "sinker_b5")?.baseValue = appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.b5]!
        form.rowBy(tag: "sinker_b5")?.reload()
        form.rowBy(tag: "sinker_b6")?.baseValue = appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.b6]!
        form.rowBy(tag: "sinker_b6")?.reload()
        
        // ウキ
        form.rowBy(tag: "float_g8")?.baseValue = appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g8]!
        form.rowBy(tag: "float_g8")?.reload()
        form.rowBy(tag: "float_g7")?.baseValue = appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g7]!
        form.rowBy(tag: "float_g7")?.reload()
        form.rowBy(tag: "float_g6")?.baseValue = appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g6]!
        form.rowBy(tag: "float_g6")?.reload()
        form.rowBy(tag: "float_g5")?.baseValue = appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g5]!
        form.rowBy(tag: "float_g5")?.reload()
        form.rowBy(tag: "float_g4")?.baseValue = appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g4]!
        form.rowBy(tag: "float_g4")?.reload()
        form.rowBy(tag: "float_g3")?.baseValue = appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g3]!
        form.rowBy(tag: "float_g3")?.reload()
        form.rowBy(tag: "float_g2")?.baseValue = appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g2]!
        form.rowBy(tag: "float_g2")?.reload()
        form.rowBy(tag: "float_g1")?.baseValue = appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g1]!
        form.rowBy(tag: "float_g1")?.reload()
        form.rowBy(tag: "float_b1")?.baseValue = appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.b1]!
        form.rowBy(tag: "float_b1")?.reload()
        form.rowBy(tag: "float_b2")?.baseValue = appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.b2]!
        form.rowBy(tag: "float_b2")?.reload()
        form.rowBy(tag: "float_b3")?.baseValue = appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.b3]!
        form.rowBy(tag: "float_b3")?.reload()
        form.rowBy(tag: "float_b4")?.baseValue = appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.b4]!
        form.rowBy(tag: "float_b4")?.reload()
        form.rowBy(tag: "float_b5")?.baseValue = appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.b5]!
        form.rowBy(tag: "float_b5")?.reload()
        form.rowBy(tag: "float_b6")?.baseValue = appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.b6]!
        form.rowBy(tag: "float_b6")?.reload()
    }

    // AをTへ設定
    // When do you use this function?
    // 1.Fist Rold              画面起動
    // 2.Cancel                 取り消し
    // 3.Move else View         他画面に移動
    func setAppDelegateToCalculationDataBase(){
        // ウキ
        CCalcDB.setArrayDataBaseWeightFloat(setKey: .g8, setValue: appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g8]!)
        CCalcDB.setArrayDataBaseWeightFloat(setKey: .g7, setValue: appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g7]!)
        CCalcDB.setArrayDataBaseWeightFloat(setKey: .g6, setValue: appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g6]!)
        CCalcDB.setArrayDataBaseWeightFloat(setKey: .g5, setValue: appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g5]!)
        CCalcDB.setArrayDataBaseWeightFloat(setKey: .g4, setValue: appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g4]!)
        CCalcDB.setArrayDataBaseWeightFloat(setKey: .g3, setValue: appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g3]!)
        CCalcDB.setArrayDataBaseWeightFloat(setKey: .g2, setValue: appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g2]!)
        CCalcDB.setArrayDataBaseWeightFloat(setKey: .g1, setValue: appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g1]!)
        CCalcDB.setArrayDataBaseWeightFloat(setKey: .b1, setValue: appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.b1]!)
        CCalcDB.setArrayDataBaseWeightFloat(setKey: .b2, setValue: appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.b2]!)
        CCalcDB.setArrayDataBaseWeightFloat(setKey: .b3, setValue: appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.b3]!)
        CCalcDB.setArrayDataBaseWeightFloat(setKey: .b4, setValue: appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.b4]!)
        CCalcDB.setArrayDataBaseWeightFloat(setKey: .b5, setValue: appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.b5]!)
        CCalcDB.setArrayDataBaseWeightFloat(setKey: .b6, setValue: appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.b6]!)
        
        // オモリ
        CCalcDB.setArrayDataBaseWeightSinker(setKey: .g8, setValue: appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g8]!)
        CCalcDB.setArrayDataBaseWeightSinker(setKey: .g7, setValue: appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g7]!)
        CCalcDB.setArrayDataBaseWeightSinker(setKey: .g6, setValue: appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g6]!)
        CCalcDB.setArrayDataBaseWeightSinker(setKey: .g5, setValue: appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g5]!)
        CCalcDB.setArrayDataBaseWeightSinker(setKey: .g4, setValue: appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g4]!)
        CCalcDB.setArrayDataBaseWeightSinker(setKey: .g3, setValue: appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g3]!)
        CCalcDB.setArrayDataBaseWeightSinker(setKey: .g2, setValue: appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g2]!)
        CCalcDB.setArrayDataBaseWeightSinker(setKey: .g1, setValue: appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g1]!)
        CCalcDB.setArrayDataBaseWeightSinker(setKey: .b1, setValue: appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.b1]!)
        CCalcDB.setArrayDataBaseWeightSinker(setKey: .b2, setValue: appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.b2]!)
        CCalcDB.setArrayDataBaseWeightSinker(setKey: .b3, setValue: appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.b3]!)
        CCalcDB.setArrayDataBaseWeightSinker(setKey: .b4, setValue: appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.b4]!)
        CCalcDB.setArrayDataBaseWeightSinker(setKey: .b5, setValue: appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.b5]!)
        CCalcDB.setArrayDataBaseWeightSinker(setKey: .b6, setValue: appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.b6]!)
        
        
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
            CheckDuplicationValueFloat(argIndex: argIndex, argSetValue: checkValue)
            editSinkers[argIndex] = false
        }

        return
    }

    /// Description: 重量が変更された場合、他の項目と重複していないか確認する
    ///              重複あり: メッセージを出力する
    ///                       編集前の値に戻す
    ///              重複なし:DbWeightSinkerの値を更新する
    ///
    /// - Author: sawatch
    /// - Date: 2018/08/19
    /// - Version: 1.0.0
    /// - Parameters:
    ///   - argIndex:Int    変更した項目のサイズ
    ///   - argSetValue:Double     変更する値
    /// - Returns: [計算結果]画面に出力する文字列
    func CheckDuplicationValueFloat(argIndex:Int, argSetValue:Double){
        var editFlag:Bool = false
        var valueCompare:Double = 0.0
        
        // 設定するEurekaのタグ名を取得する
        var selectItem:String = ""
        var selectKey:String = ""
        switch(argIndex)
        {
        case DataBaseTable.WeightNumber.g8.rawValue:
            selectItem  = "sinker_g8"
            selectKey   = DataBaseTable.WeightIndex.g8.rawValue
        case DataBaseTable.WeightNumber.g7.rawValue:
            selectItem  = "sinker_g7"
            selectKey   = DataBaseTable.WeightIndex.g7.rawValue
        case DataBaseTable.WeightNumber.g6.rawValue:
            selectItem  = "sinker_g6"
            selectKey   = DataBaseTable.WeightIndex.g6.rawValue
        case DataBaseTable.WeightNumber.g5.rawValue:
            selectItem  = "sinker_g5"
            selectKey   = DataBaseTable.WeightIndex.g5.rawValue
        case DataBaseTable.WeightNumber.g4.rawValue:
            selectItem  = "sinker_g4"
            selectKey   = DataBaseTable.WeightIndex.g4.rawValue
        case DataBaseTable.WeightNumber.g3.rawValue:
            selectItem  = "sinker_g3"
            selectKey   = DataBaseTable.WeightIndex.g3.rawValue
        case DataBaseTable.WeightNumber.g2.rawValue:
            selectItem  = "sinker_g2"
            selectKey   = DataBaseTable.WeightIndex.g2.rawValue
        case DataBaseTable.WeightNumber.g1.rawValue:
            selectItem  = "sinker_g1"
            selectKey   = DataBaseTable.WeightIndex.g1.rawValue
        case DataBaseTable.WeightNumber.b1.rawValue:
            selectItem  = "sinker_b1"
            selectKey   = DataBaseTable.WeightIndex.b1.rawValue
        case DataBaseTable.WeightNumber.b2.rawValue:
            selectItem  = "sinker_b2"
            selectKey   = DataBaseTable.WeightIndex.b2.rawValue
        case DataBaseTable.WeightNumber.b3.rawValue:
            selectItem  = "sinker_b3"
            selectKey   = DataBaseTable.WeightIndex.b3.rawValue
        case DataBaseTable.WeightNumber.b4.rawValue:
            selectItem  = "sinker_b4"
            selectKey   = DataBaseTable.WeightIndex.b4.rawValue
        case DataBaseTable.WeightNumber.b5.rawValue:
            selectItem  = "sinker_b5"
            selectKey   = DataBaseTable.WeightIndex.b5.rawValue
        case DataBaseTable.WeightNumber.b6.rawValue:
            selectItem  = "sinker_b6"
            selectKey   = DataBaseTable.WeightIndex.b6.rawValue
        default:
            print("CheckDuplicationValueFloat-Error")
        }

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
                // 戻したいけど戻せないため "0.0" にする
                // let value:Double  = self.CCalcDB.getArrayDataBaseWeightFloat(getKey: DataBaseTable.WeightIndex(rawValue: argKey)!)
                self.form.rowBy(tag: selectItem)?.baseValue = self.beforeValueSinkers[argIndex]
                self.form.rowBy(tag: selectItem)?.reload()
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

}
