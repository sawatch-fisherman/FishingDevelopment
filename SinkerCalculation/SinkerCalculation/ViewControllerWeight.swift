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

    let activityIndicatorView = UIActivityIndicatorView(style: .large)

    enum WeightType:Int{
        case float = 0
        case sinker
    }

    /// Description: ボタンの編集状態
    ///              項目を変更した場合、値を変更する
    /// - Author: sawatch
    /// - Date: 2018/08/17
    /// - Version: 1.0.1
    struct Status{
        var edit:Bool = false               // false:未編集, true:編集済み
        var beforeValue:Double = 0.0        // 編集前の値, エラー値が入力された場合、この値に戻す
        // 初期化
        init(){
            edit        = false
            beforeValue = 0.0
        }
    }
    var statsFloats:[Status] = [Status(), Status(), Status(), Status(),
                                 Status(), Status(), Status(), Status(),
                                 Status(), Status(), Status(),
                                 Status(), Status(), Status(),
                                 Status() ]
    var statsSinkers:[Status] = [Status(), Status(), Status(), Status(),
                                 Status(), Status(), Status(), Status(),
                                 Status(), Status(), Status(),
                                 Status(), Status(), Status(),
                                 Status() ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // TにAを設定
        setAppDelegateToCalculationDataBase()

        // コントロールの設定
        setEurekaControl()

        // インジケータの設定
        settingActivityIndicatorView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /// Description: [設定]画面が表示される直前のイベント
    ///              もしリセットボタンが押されていた場合、インジケータの表示を開始する
    /// - Author: sawatch
    /// - Date: 2018/09/17
    /// - Version: 1.0.1
    override func viewWillAppear(_ animated: Bool) {
        if(true == appDelegate.resetFlag.viewWeight){
            // インジケーター start
            activityIndicatorView.startAnimating()

        }
        return
    }

    /// Description: [設定]画面が表示された直後のイベント
    ///              もしリセットボタンが押されていた場合、各ボタンをリセットする、インジケータを終了する
    /// - Author: sawatch
    /// - Date: 2018/09/17
    /// - Version: 1.0.1
    override func viewDidAppear(_ animated: Bool) {
        if(true == appDelegate.resetFlag.viewWeight){
            resetValues()

            appDelegate.resetFlag.viewWeight = false

            // インジケーター finish
            if (true == self.activityIndicatorView.isAnimating) {
                self.activityIndicatorView.stopAnimating()
            }
        }
        return
    }

    /// Description: タブバーを表示する
    ///                 >> 動作のタイミング
    ///                    - [取消し]ボタンの[破棄する]
    ///                    - [保存]ボタン
    ///
    /// - Author:       sawatch
    /// - Date:         2018/09/09
    /// - Version:      1.0.1
    func hideTabBar(){
        tabBarController?.tabBar.isHidden = true
        return
    }
    
    /// Description: タブバーを非表示にする
    ///                 >>>動作のタイミング
    ///                    - 各項目のいずれか一つが変更された場合
    ///
    /// - Author:       sawatch
    /// - Date:         2018/09/09
    /// - Version:      1.0.1
    func showTabBar(){
        tabBarController?.tabBar.isHidden = false
        return
    }

    /// Description: 保存ボタンの処理
    /// - Note: 2018/09/09 - Ver.1.0.1
    ///              処理を追加
    ///              - インジケーターを表示する
    ///              - タブバーを表示する
    /// - Warning:   ボタン押下後のクロージャー内でインジケータの宣言の処理を記述しても動作しない。
    /// - Author: sawatch
    /// - Date: 2018/08/17
    /// - Version: 1.0.0
    @IBAction func clickButtonSave(_ sender: Any) {

        // インジケーター start
        activityIndicatorView.startAnimating()

        // "保存しました"
        let alert = UIAlertController(title: "", message: "保存しました", preferredStyle: UIAlertController.Style.alert)
        present(alert, animated: true, completion: {

            // アラートを閉じる
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                alert.dismiss(animated: true, completion: nil)
            })

            // タブバーを表示
            self.showTabBar()

            // インジケーター finish
            if (true == self.activityIndicatorView.isAnimating) {
                self.activityIndicatorView.stopAnimating()
            }
        })

        // 値を設定
        setCalculationDataBaseToAppDelegate()

        return
    }


    /// Description: 取消しボタンの処理
    /// - Note: 2018/09/09 - Ver.1.0.1
    ///              処理を追加
    ///              - インジケーターを表示する
    ///              - タブバーを表示する
    /// - Warning:   ボタン押下後のクロージャー内でインジケータの宣言の処理を記述しても動作しない。
    /// - Author: sawatch
    /// - Date: 2018/08/17
    /// - Version: 1.0.0
    @IBAction func clickButtonCancel(_ sender: Any) {
        // インジケーター start
        activityIndicatorView.startAnimating()

        // アラートを表示
        let title = "キャンセル確認"
        let message = "編集中の内容を破棄してよろしいですか？"

        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "戻る", style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) -> Void in
            // ボタン押下後の処理
            // インジケーター finish
            if (true == self.activityIndicatorView.isAnimating) {
                self.activityIndicatorView.stopAnimating()
            }
        })

        let cancelAction: UIAlertAction = UIAlertAction(title: "破棄する", style: UIAlertAction.Style.cancel, handler: {
            (action: UIAlertAction!) -> Void in

            // ボタン押下後の処理
            self.setReload()

            // タブバーを表示
            self.showTabBar()

            // インジケーター finish
            if (true == self.activityIndicatorView.isAnimating) {
                self.activityIndicatorView.stopAnimating()
            }

            // "編集中の内容を破棄しました"
            let alert2 = UIAlertController(title: "", message: "編集中の内容を破棄しました", preferredStyle: UIAlertController.Style.alert)
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

    /// Description: UIActivityIndicatorViewの設定
    /// - Author: sawatch
    /// - Date: 2018/09/03
    /// - Version: 1.0.1
    func settingActivityIndicatorView(){
        self.view.addSubview(activityIndicatorView)
        self.view.bringSubviewToFront(activityIndicatorView)
        activityIndicatorView.frame = self.view.bounds
    }

    /// Description: Eurekaの設定
    /// - Note: 2018/09/16 - Ver.1.0.1
    ///              >>項目を追加
    ///              - 1号
    ///              >>各引数を定数化
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
            <<< DecimalRow(DataBaseTable.UserDefaultsTag.float_g8.rawValue) {
                $0.title = DataBaseTable.WeightShow.g8.rawValue
                $0.value = CCalcDB.getArrayDataBaseWeightFloat(getKey: .g8)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueFloats(argIndex: DataBaseTable.WeightNumber.g8.rawValue, checkValue: row.value!)
            }
            <<< DecimalRow(DataBaseTable.UserDefaultsTag.float_g7.rawValue) {
                $0.title = DataBaseTable.WeightShow.g7.rawValue
                $0.value = CCalcDB.getArrayDataBaseWeightFloat(getKey: .g7)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueFloats(argIndex: DataBaseTable.WeightNumber.g7.rawValue, checkValue: row.value!)
            }
            <<< DecimalRow(DataBaseTable.UserDefaultsTag.float_g6.rawValue) {
                $0.title = DataBaseTable.WeightShow.g6.rawValue
                $0.value = CCalcDB.getArrayDataBaseWeightFloat(getKey: .g6)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueFloats(argIndex: DataBaseTable.WeightNumber.g6.rawValue, checkValue: row.value!)
            }
            <<< DecimalRow(DataBaseTable.UserDefaultsTag.float_g5.rawValue) {
                $0.title = DataBaseTable.WeightShow.g5.rawValue
                $0.value = CCalcDB.getArrayDataBaseWeightFloat(getKey: .g5)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueFloats(argIndex: DataBaseTable.WeightNumber.g5.rawValue, checkValue: row.value!)
            }
            <<< DecimalRow(DataBaseTable.UserDefaultsTag.float_g4.rawValue) {
                $0.title = DataBaseTable.WeightShow.g4.rawValue
                $0.value = CCalcDB.getArrayDataBaseWeightFloat(getKey: .g4)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueFloats(argIndex: DataBaseTable.WeightNumber.g4.rawValue, checkValue: row.value!)
            }
            <<< DecimalRow(DataBaseTable.UserDefaultsTag.float_g3.rawValue) {
                $0.title = DataBaseTable.WeightShow.g3.rawValue
                $0.value = CCalcDB.getArrayDataBaseWeightFloat(getKey: .g3)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueFloats(argIndex: DataBaseTable.WeightNumber.g3.rawValue, checkValue: row.value!)
            }
            <<< DecimalRow(DataBaseTable.UserDefaultsTag.float_g2.rawValue) {
                $0.title = DataBaseTable.WeightShow.g2.rawValue
                $0.value = CCalcDB.getArrayDataBaseWeightFloat(getKey: .g2)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueFloats(argIndex: DataBaseTable.WeightNumber.g2.rawValue, checkValue: row.value!)
            }
            <<< DecimalRow(DataBaseTable.UserDefaultsTag.float_g1.rawValue) {
                $0.title = DataBaseTable.WeightShow.g1.rawValue
                $0.value = CCalcDB.getArrayDataBaseWeightFloat(getKey: .g1)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueFloats(argIndex: DataBaseTable.WeightNumber.g1.rawValue, checkValue: row.value!)
            }
            <<< DecimalRow(DataBaseTable.UserDefaultsTag.float_b1.rawValue) {
                $0.title = DataBaseTable.WeightShow.b1.rawValue
                $0.value = CCalcDB.getArrayDataBaseWeightFloat(getKey: .b1)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueFloats(argIndex: DataBaseTable.WeightNumber.b1.rawValue, checkValue: row.value!)
            }
            <<< DecimalRow(DataBaseTable.UserDefaultsTag.float_b2.rawValue) {
                $0.title = DataBaseTable.WeightShow.b2.rawValue
                $0.value = CCalcDB.getArrayDataBaseWeightFloat(getKey: .b2)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueFloats(argIndex: DataBaseTable.WeightNumber.b2.rawValue, checkValue: row.value!)
            }
            <<< DecimalRow(DataBaseTable.UserDefaultsTag.float_b3.rawValue) {
                $0.title = DataBaseTable.WeightShow.b3.rawValue
                $0.value = CCalcDB.getArrayDataBaseWeightFloat(getKey: .b3)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueFloats(argIndex: DataBaseTable.WeightNumber.b3.rawValue, checkValue: row.value!)
            }
            <<< DecimalRow(DataBaseTable.UserDefaultsTag.float_b4.rawValue) {
                $0.title = DataBaseTable.WeightShow.b4.rawValue
                $0.value = CCalcDB.getArrayDataBaseWeightFloat(getKey: .b4)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueFloats(argIndex: DataBaseTable.WeightNumber.b4.rawValue, checkValue: row.value!)
            }
            <<< DecimalRow(DataBaseTable.UserDefaultsTag.float_b5.rawValue) {
                $0.title = DataBaseTable.WeightShow.b5.rawValue
                $0.value = CCalcDB.getArrayDataBaseWeightFloat(getKey: .b5)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueFloats(argIndex: DataBaseTable.WeightNumber.b5.rawValue, checkValue: row.value!)
            }
            <<< DecimalRow(DataBaseTable.UserDefaultsTag.float_b6.rawValue) {
                $0.title = DataBaseTable.WeightShow.b6.rawValue
                $0.value = CCalcDB.getArrayDataBaseWeightFloat(getKey: .b6)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueFloats(argIndex: DataBaseTable.WeightNumber.b6.rawValue, checkValue: row.value!)
            }
            //
            <<< DecimalRow(DataBaseTable.UserDefaultsTag.float_n1.rawValue) {
                $0.title = DataBaseTable.WeightShow.n1.rawValue
                $0.value = CCalcDB.getArrayDataBaseWeightFloat(getKey: .n1)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueFloats(argIndex: DataBaseTable.WeightNumber.n1.rawValue, checkValue: row.value!)
            }

            // オモリの設定
            +++ Section("オモリのオモサ (単位:g)")
            <<< DecimalRow(DataBaseTable.UserDefaultsTag.sinker_g8.rawValue) {
                $0.title = DataBaseTable.WeightShow.g8.rawValue
                $0.value = CCalcDB.getArrayDataBaseWeightSinker(getKey: .g8)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueSinkers(argIndex: DataBaseTable.WeightNumber.g8.rawValue, checkValue: row.value!)
            }
            <<< DecimalRow(DataBaseTable.UserDefaultsTag.sinker_g7.rawValue) {
                $0.title = DataBaseTable.WeightShow.g7.rawValue
                $0.value = CCalcDB.getArrayDataBaseWeightSinker(getKey: .g7)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueSinkers(argIndex: DataBaseTable.WeightNumber.g7.rawValue, checkValue: row.value!)
            }
            <<< DecimalRow(DataBaseTable.UserDefaultsTag.sinker_g6.rawValue) {
                $0.title = DataBaseTable.WeightShow.g6.rawValue
                $0.value = CCalcDB.getArrayDataBaseWeightSinker(getKey: .g6)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueSinkers(argIndex: DataBaseTable.WeightNumber.g6.rawValue, checkValue: row.value!)
            }
            <<< DecimalRow(DataBaseTable.UserDefaultsTag.sinker_g5.rawValue) {
                $0.title = DataBaseTable.WeightShow.g5.rawValue
                $0.value = CCalcDB.getArrayDataBaseWeightSinker(getKey: .g5)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueSinkers(argIndex: DataBaseTable.WeightNumber.g5.rawValue, checkValue: row.value!)
            }
            <<< DecimalRow(DataBaseTable.UserDefaultsTag.sinker_g4.rawValue) {
                $0.title = DataBaseTable.WeightShow.g4.rawValue
                $0.value = CCalcDB.getArrayDataBaseWeightSinker(getKey: .g4)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueSinkers(argIndex: DataBaseTable.WeightNumber.g4.rawValue, checkValue: row.value!)
            }
            <<< DecimalRow(DataBaseTable.UserDefaultsTag.sinker_g3.rawValue) {
                $0.title = DataBaseTable.WeightShow.g3.rawValue
                $0.value = CCalcDB.getArrayDataBaseWeightSinker(getKey: .g3)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueSinkers(argIndex: DataBaseTable.WeightNumber.g3.rawValue, checkValue: row.value!)
            }
            <<< DecimalRow(DataBaseTable.UserDefaultsTag.sinker_g2.rawValue) {
                $0.title = DataBaseTable.WeightShow.g2.rawValue
                $0.value = CCalcDB.getArrayDataBaseWeightSinker(getKey: .g2)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueSinkers(argIndex: DataBaseTable.WeightNumber.g2.rawValue, checkValue: row.value!)
            }
            <<< DecimalRow(DataBaseTable.UserDefaultsTag.sinker_g1.rawValue) {
                $0.title = DataBaseTable.WeightShow.g1.rawValue
                $0.value = CCalcDB.getArrayDataBaseWeightSinker(getKey: .g1)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueSinkers(argIndex: DataBaseTable.WeightNumber.g1.rawValue, checkValue: row.value!)
            }
            <<< DecimalRow(DataBaseTable.UserDefaultsTag.sinker_b1.rawValue) {
                $0.title = DataBaseTable.WeightShow.b1.rawValue
                $0.value = CCalcDB.getArrayDataBaseWeightSinker(getKey: .b1)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueSinkers(argIndex: DataBaseTable.WeightNumber.b1.rawValue, checkValue: row.value!)
            }
            <<< DecimalRow(DataBaseTable.UserDefaultsTag.sinker_b2.rawValue) {
                $0.title = DataBaseTable.WeightShow.b2.rawValue
                $0.value = CCalcDB.getArrayDataBaseWeightSinker(getKey: .b2)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueSinkers(argIndex: DataBaseTable.WeightNumber.b2.rawValue, checkValue: row.value!)
            }
            <<< DecimalRow(DataBaseTable.UserDefaultsTag.sinker_b3.rawValue) {
                $0.title = DataBaseTable.WeightShow.b3.rawValue
                $0.value = CCalcDB.getArrayDataBaseWeightSinker(getKey: .b3)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueSinkers(argIndex: DataBaseTable.WeightNumber.b3.rawValue, checkValue: row.value!)
            }
            <<< DecimalRow(DataBaseTable.UserDefaultsTag.sinker_b4.rawValue) {
                $0.title = DataBaseTable.WeightShow.b4.rawValue
                $0.value = CCalcDB.getArrayDataBaseWeightSinker(getKey: .b4)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueSinkers(argIndex: DataBaseTable.WeightNumber.b4.rawValue, checkValue: row.value!)
            }
            <<< DecimalRow(DataBaseTable.UserDefaultsTag.sinker_b5.rawValue) {
                $0.title = DataBaseTable.WeightShow.b5.rawValue
                $0.value = CCalcDB.getArrayDataBaseWeightSinker(getKey: .b5)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueSinkers(argIndex: DataBaseTable.WeightNumber.b5.rawValue, checkValue: row.value!)
            }
            <<< DecimalRow(DataBaseTable.UserDefaultsTag.sinker_b6.rawValue) {
                $0.title = DataBaseTable.WeightShow.b6.rawValue
                $0.value = CCalcDB.getArrayDataBaseWeightSinker(getKey: .b6)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueSinkers(argIndex: DataBaseTable.WeightNumber.b6.rawValue, checkValue: row.value!)
            }
            <<< DecimalRow(DataBaseTable.UserDefaultsTag.sinker_n1.rawValue) {
                $0.title = DataBaseTable.WeightShow.n1.rawValue
                $0.value = CCalcDB.getArrayDataBaseWeightSinker(getKey: .n1)
                $0.formatter = wrapFormatter
                }.onCellHighlightChanged { cell, row in
                    self.checkValueSinkers(argIndex: DataBaseTable.WeightNumber.n1.rawValue, checkValue: row.value!)
        }

        return
    }


    /// Description:    各項目の設定値を変更前(最後に保存した値)に戻す
    ///                 "editFlag"をオフにする
    ///                 ■動作のタイミング
    ///
    /// - Note:         "破棄する"が選択された場合に動作する
    ///                 2018/09/06 - Ver.1.0.1
    ///                   処理のロジックを修正
    /// - Author:       sawatch
    /// - Date:         2018/08/17
    /// - Version:      1.0.0
    func setReload(){
        #if DEBUG
        print("Func -setReload-")
        #endif
        // 値を戻す
        for index in 0..<DataBaseTable.WeightNumber.WeightNumbers.count{
            // ウキ
            form.rowBy(tag: DataBaseTable.UserDefaultsTag.FloatTags[index].rawValue)?.baseValue = appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.WeightIndexs[index]]!
            form.rowBy(tag: DataBaseTable.UserDefaultsTag.FloatTags[index].rawValue)?.reload()

            // オモリ
            form.rowBy(tag: DataBaseTable.UserDefaultsTag.SinkerTags[index].rawValue)?.baseValue = appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.WeightIndexs[index]]!
            form.rowBy(tag: DataBaseTable.UserDefaultsTag.SinkerTags[index].rawValue)?.reload()

            #if DEBUG
            print("Keys:", DataBaseTable.WeightIndex.WeightIndexs[index])
            let debugFloat:Double = appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.WeightIndexs[index]]!
            print("Float:", debugFloat)
            let debugSinker:Double = appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.WeightIndexs[index]]!
            print("Sinker:", debugSinker)
            #endif
        }

        CCalcDB.offEditFlag()

        return
    }

    /// Description: AppDelegateの値をDataBaseテーブル変数に保存する
    ///              使用状況: 編集した値を以前の値に戻したい時に使用する
    ///                       1. 画面起動時
    ///                       2. 取消し
    ///                       3. 他の画面に移動
    /// - Note: 2018/08/26 - Ver.1.0.1
    ///              初起動時にAppDelegateの値が全て"0"の不具合を修正
    ///              UserDefaultsを初期化する処理を別関数に置き換え
    /// - Author: sawatch
    /// - Date: 2018/08/17
    /// - Version: 1.0.0
    func setAppDelegateToCalculationDataBase(){
        #if DEBUG
        print("Func -setAppDelegateToCalculationDataBase-")
        #endif

        // 値を戻す
        for index in 0..<DataBaseTable.WeightNumber.WeightNumbers.count{
            // ウキ
            CCalcDB.setArrayDataBaseWeightFloat(setKey: DataBaseTable.WeightIndex.WeightIndexs[index],
                                                 setValue: appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.WeightIndexs[index]]!)

            // オモリ
            CCalcDB.setArrayDataBaseWeightSinker(setKey: DataBaseTable.WeightIndex.WeightIndexs[index],
                                                 setValue: appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.WeightIndexs[index]]!)

            #if DEBUG
            print("Keys:", DataBaseTable.WeightIndex.WeightIndexs[index])
            let debugFloat:Double = appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.WeightIndexs[index]]!
            print("Float:",debugFloat)
            let debugSinker:Double = appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.WeightIndexs[index]]!
            print("Sinker:",debugSinker)
            #endif
        }

        return
    }

    /// Description:    DBの値をAppleDelegateに保存
    ///                 AppleDelegateの値をUserDefaultに保存
    /// - Note:         2018/09/04 - Ver.1.0.1
    ///                   処理のロジックを修正
    /// - Author:       sawatch
    /// - Date:         2018/08/17
    /// - Version:      1.0.0
    // TをAへ設定
    // When do you use this function?
    // 1.Save                 保存
    func setCalculationDataBaseToAppDelegate(){
        #if DEBUG
        print("Func -setCalculationDataBaseToAppDelegate-")
        #endif
        // UserDefaultへ保存
        let defaults: UserDefaults = UserDefaults.standard
        // 値を戻す
        for index in 0..<DataBaseTable.WeightNumber.WeightNumbers.count{

            appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.WeightIndexs[index]] = CCalcDB.getArrayDataBaseWeightFloat(getKey: DataBaseTable.WeightIndex.WeightIndexs[index])
            appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.WeightIndexs[index]] = CCalcDB.getArrayDataBaseWeightSinker(getKey: DataBaseTable.WeightIndex.WeightIndexs[index])

            defaults.set(appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.WeightIndexs[index]], forKey: DataBaseTable.UserDefaultsTag.FloatTags[index].rawValue)
            defaults.set(appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.WeightIndexs[index]], forKey: DataBaseTable.UserDefaultsTag.SinkerTags[index].rawValue)

            #if DEBUG
            print("Keys:", DataBaseTable.WeightIndex.WeightIndexs[index])
            let debugFloat:Double = appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.WeightIndexs[index]]!
            print("Float:", debugFloat)
            let debugSinker:Double = appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.WeightIndexs[index]]!
            print("Sinker:", debugSinker)
            #endif
        }
        return
    }



    /// Description: Float項目のEurekaの値のチェックを行う
    ///              値をチェックする
    ///              - 0チェック
    ///              - 変更チェック
    ///              - 重複チェック
    ///
    ///              フォーカスの状態
    ///              IN:  editSinkersをtrueにする
    ///              OUT: 値のチェック処理を実行する
    ///                   DbWeightFloatの値を更新する
    ///                   editSinkersをfalseにする
    ///
    /// - Author: sawatch
    /// - Date: 2018/09/12
    /// - Version: 1.0.1
    /// - Parameters:
    ///   - argIndex:Int          変更した項目のサイズ
    ///   - argSetValue:Double    変更する値
    func checkValueFloats(argIndex:Int, checkValue:Double){
        // 設定するEurekaのタグ名とインデックスを取得する
        let selectTag:String = convertIndexToTagFloat(argIndex: argIndex)
        let selectKey:String = convertIndexToKey(argIndex: argIndex)
        
        if(statsFloats[argIndex].edit == false){
            statsFloats[argIndex].beforeValue = checkValue
            statsFloats[argIndex].edit = true
            return
        }

        let resultRange:Bool = CheckRangeValue(argIndex: argIndex, argTag:selectTag, argSetValue: checkValue, argType: WeightType.float)
        if(resultRange == true){
            return
        }

        let resultNoChange = CheckNoChangeValue(argIndex: argIndex, argSetValue: checkValue, argType: WeightType.float)
        if(resultNoChange == true){
            return
        }
        
        let resultDuplication:Bool = CheckDuplicationValueFloat(argIndex: argIndex, argTag:selectTag, argKey:selectKey, argSetValue: checkValue)
        if(resultDuplication == true){
            return
        }

        // 重複なし
        // 書込み
        self.CCalcDB.setArrayDataBaseWeightFloat(setKey: DataBaseTable.WeightIndex(rawValue: selectKey)!, setValue: checkValue)
        statsFloats[argIndex].edit = false
        // タブバーを隠す
        hideTabBar()
        return
    }

    /// Description: Sinker項目のEurekaの値のチェックを行う
    ///              値をチェックする
    ///              - 0チェック
    ///              - 変更チェック
    ///              - 重複チェック
    ///
    ///              フォーカスの状態
    ///              IN:  editSinkersをtrueにする
    ///              OUT: 値のチェック処理を実行する
    ///                   DbWeightSinkerの値を更新する
    ///                   editSinkersをfalseにする
    /// - Note: 2018/09/12 - Ver.1.0.1
    ///              値のチェックする処理を修正
    ///              ・関数名を修正
    ///              ・0チェックの関数を追加
    ///              ・変更チェックの関数を追加
    ///
    /// - Author: sawatch
    /// - Date: 2018/08/19
    /// - Version: 1.0.0
    /// - Parameters:
    ///   - argIndex:Int          変更した項目のサイズ
    ///   - argSetValue:Double    変更する値
    func checkValueSinkers(argIndex:Int, checkValue:Double){

        // 設定するEurekaのタグ名とインデックスを取得する
        let selectTag:String = convertIndexToTagSinker(argIndex: argIndex)
        let selectKey:String = convertIndexToKey(argIndex: argIndex)

        if(statsSinkers[argIndex].edit == false){
            statsSinkers[argIndex].beforeValue = checkValue
            statsSinkers[argIndex].edit = true
            return
        }

        let resultRange:Bool = CheckRangeValue(argIndex: argIndex, argTag:selectTag, argSetValue: checkValue, argType: WeightType.sinker)
        if(resultRange == true){
            return
        }

        let resultNoChange = CheckNoChangeValue(argIndex: argIndex, argSetValue: checkValue, argType: WeightType.sinker)
        if(resultNoChange == true){
            return
        }

        let resultDuplication:Bool = CheckDuplicationValueSinker(argIndex: argIndex, argTag:selectTag, argKey:selectKey, argSetValue: checkValue)
        if(resultDuplication == true){
            return
        }

        // 重複なし
        // 書込み
        self.CCalcDB.setArrayDataBaseWeightSinker(setKey: DataBaseTable.WeightIndex(rawValue: selectKey)!, setValue: checkValue)
        statsSinkers[argIndex].edit = false
        // タブバーを隠す
        hideTabBar()

        return
    }

    /// Description: 重量が変更された場合、値が範囲内[0.01 ~ 9.99] かチェックする
    ///              重複あり: メッセージを出力する
    ///                       編集前の値に戻す
    ///              重複なし: 何もしない
    ///
    /// - Author: sawatch
    /// - Date: 2018/09/16
    /// - Version: 1.0.1
    /// - Parameters:
    ///   - argIndex:Int           変更した項目のサイズ
    ///   - argTag:String          変更した項目のタグ名
    ///   - argSetValue:Double     変更する値
    ///   - argType:WeightType     0:Float, 1:Sinker
    /// - Returns: true : 値は0.01 ~ 9.99 以内
    ///            false: 値は0.00以下、10.00以上
    func CheckRangeValue(argIndex:Int, argTag:String, argSetValue:Double, argType:WeightType)->Bool{
        if( (argSetValue.isZero == false) && (10.00 > argSetValue)){
            return false
        }
        // 値はゼロ
        // アラートを表示
        let title = "入力値エラー"
        let message = "重量の値が 範囲外です です。\n[0.01~9.99] の重量を設定してください。"
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) -> Void in
            // ボタン押下後の処理
            // 編集前の値に戻す
            var restoreValue:Double = 0.0
            if(argType == WeightType.float){
                restoreValue = self.statsFloats[argIndex].beforeValue
            }else{
                restoreValue = self.statsSinkers[argIndex].beforeValue
            }
            self.form.rowBy(tag: argTag)?.baseValue = restoreValue
            self.form.rowBy(tag: argTag)?.reload()
        })
        
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
        return true
        
    }

    /// Description: 重量が変更された場合、値が0かチェックする
    ///              重複あり: メッセージを出力する
    ///                       編集前の値に戻す
    ///              重複なし: 何もしない
    ///
    /// - Author: sawatch
    /// - Date: 2018/09/16
    /// - Version: 1.0.1
    /// - Parameters:
    ///   - argIndex:Int           変更した項目のサイズ
    ///   - argTag:String          変更した項目のタグ名
    ///   - argSetValue:Double     変更する値
    ///   - argType:WeightType     0:Float, 1:Sinker
    /// - Returns: true : 値は0.00
    ///            false: 値は0.01以上
    func CheckZeroValue(argIndex:Int, argTag:String, argSetValue:Double, argType:WeightType)->Bool{
        if(argSetValue.isZero == false){
            return false
        }
        // 値はゼロ
        // アラートを表示
        let title = "入力値エラー"
        let message = "重量の値が 0 です。\n0.01以上の重量を設定してください。"
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) -> Void in
            // ボタン押下後の処理
            // 編集前の値に戻す
            var restoreValue:Double = 0.0
            if(argType == WeightType.float){
                restoreValue = self.statsFloats[argIndex].beforeValue
            }else{
                restoreValue = self.statsSinkers[argIndex].beforeValue
            }
            self.form.rowBy(tag: argTag)?.baseValue = restoreValue
            self.form.rowBy(tag: argTag)?.reload()
        })

        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
        return true

    }


    /// Description: 重量が変更された場合、値が変更前と同じかチェックする
    ///              変更あり: 何もしない
    ///              変更なし: 処理を終了する
    ///
    /// - Author: sawatch
    /// - Date: 2018/09/12
    /// - Version: 1.0.1
    /// - Parameters:
    ///   - argIndex:Int           変更した項目のサイズ
    ///   - argSetValue:Double     変更する値
    ///   - argType:WeightType     0:Float, 1:Sinker
    /// - Returns: true : 値は変更なし
    ///            false: 値は変更あり
    func CheckNoChangeValue(argIndex:Int, argSetValue:Double, argType:WeightType)->Bool{
        var valueCompare:Double = 0.0
        
        if(argType == WeightType.float){
            valueCompare = self.statsFloats[argIndex].beforeValue
        }else{
            valueCompare = self.statsSinkers[argIndex].beforeValue
        }
        
        if(valueCompare == argSetValue){
            return true
        }
        return false
    }
    

    /// Description: Float重量が変更された場合、他の項目と重複していないか確認する
    ///              重複あり: メッセージを出力する
    ///                       編集前の値に戻す
    ///
    /// - Note: 2018/09/10 - Ver.1.0.1
    ///              関数名を修正: "CheckDuplicationValueFloat" → "CheckDuplicationValueSinker"
    ///              Indexからタグ名と文字型の目次を取得する処理を別関数に置き換え
    /// - Author: sawatch
    /// - Date: 2018/09/12
    /// - Version: 1.0.1
    /// - Parameters:
    ///   - argIndex:Int           変更した項目のサイズ
    ///   - argTag:String          変更した項目のタグ名
    ///   - argKey:String          変更した項目のキー名
    ///   - argSetValue:Double     変更する値
    /// - Returns: true : 重複あり
    ///            false: 重複なし
    func CheckDuplicationValueFloat(argIndex:Int, argTag:String, argKey:String ,argSetValue:Double)->Bool{
        var editFlag:Bool = false
        var valueCompare:Double = 0.0
        
        // 他の項目と重量が重複していないか確認する
        for indexWeight in DataBaseTable.WeightIndex.WeightIndexs
        {
            valueCompare = CCalcDB.getArrayDataBaseWeightFloat(getKey: indexWeight)
            
            // 編集中の項目は対象外
            if(argKey == indexWeight.rawValue){
                continue
            }
            // 他の項目と値が重複した場合、エラーとする
            if(argSetValue == valueCompare){
                editFlag = true
                break
            }
        }
        
        if(editFlag == false){
            // 重複なし
            return false
        }

        // 重複あり
        // アラートを表示
        let title = "重複エラー"
        let message = "他のウキと同じ重量になっています。\n他のウキと異なる重量を設定してください。"
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) -> Void in
            // ボタン押下後の処理
            // 編集前の値に戻す
            self.form.rowBy(tag: argTag)?.baseValue = self.statsFloats[argIndex].beforeValue
            self.form.rowBy(tag: argTag)?.reload()
        })
        
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)

        return true
    }


    /// Description: Sinker重量が変更された場合、他の項目と重複していないか確認する
    ///              重複あり: メッセージを出力する
    ///                       編集前の値に戻す
    ///
    /// - Note: 2018/09/10 - Ver.1.0.1
    ///              関数名を修正: "CheckDuplicationValueFloat" → "CheckDuplicationValueSinker"
    ///              Indexからタグ名と文字型の目次を取得する処理を別関数に置き換え
    /// - Author: sawatch
    /// - Date: 2018/08/19
    /// - Version: 1.0.0
    /// - Parameters:
    ///   - argIndex:Int           変更した項目のサイズ
    ///   - argTag:String          変更した項目のタグ名
    ///   - argKey:String          変更した項目のキー名
    ///   - argSetValue:Double     変更する値
    /// - Returns: true : 重複あり
    ///            false: 重複なし
    func CheckDuplicationValueSinker(argIndex:Int, argTag:String, argKey:String ,argSetValue:Double)->Bool{
        var editFlag:Bool = false
        var valueCompare:Double = 0.0

        // 他の項目と重量が重複していないか確認する
        for indexWeight in DataBaseTable.WeightIndex.WeightIndexs
        {
            valueCompare = CCalcDB.getArrayDataBaseWeightSinker(getKey: indexWeight)

            // 編集中の項目は対象外
            if(argKey == indexWeight.rawValue){
                continue
            }
            // 他の項目と値が重複した場合、エラーとする
            if(argSetValue == valueCompare){
                editFlag = true
                break
            }
        }

        if(editFlag == false){
            // 重複なし
            return false
        }

        // 重複あり
        // アラートを表示
        let title = "重複エラー"
        let message = "他のオモリと同じ重量になっています。\n他のオモリと異なる重量を設定してください。"
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) -> Void in
            // ボタン押下後の処理
            // 編集前の値に戻す
            self.form.rowBy(tag: argTag)?.baseValue = self.statsSinkers[argIndex].beforeValue
            self.form.rowBy(tag: argTag)?.reload()
        })

        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)

        return true
    }

    /// Description: 設定するEurekaのタグ名(Float)を取得する
    /// - Author: sawatch
    /// - Date: 2018/09/12
    /// - Version: 1.0.1
    /// - Parameters:
    ///   - argIndex:Int    変更した項目のサイズ
    /// - Returns: 設定するEurekaのタグ名
    func convertIndexToTagFloat(argIndex:Int) -> String {
        // 設定するEurekaのタグ名を取得する
        var selectTag:String = ""
        switch(argIndex)
        {
        case DataBaseTable.WeightNumber.g8.rawValue:
            selectTag  = DataBaseTable.UserDefaultsTag.float_g8.rawValue
        case DataBaseTable.WeightNumber.g7.rawValue:
            selectTag  = DataBaseTable.UserDefaultsTag.float_g7.rawValue
        case DataBaseTable.WeightNumber.g6.rawValue:
            selectTag  = DataBaseTable.UserDefaultsTag.float_g6.rawValue
        case DataBaseTable.WeightNumber.g5.rawValue:
            selectTag  = DataBaseTable.UserDefaultsTag.float_g5.rawValue
        case DataBaseTable.WeightNumber.g4.rawValue:
            selectTag  = DataBaseTable.UserDefaultsTag.float_g4.rawValue
        case DataBaseTable.WeightNumber.g3.rawValue:
            selectTag  = DataBaseTable.UserDefaultsTag.float_g3.rawValue
        case DataBaseTable.WeightNumber.g2.rawValue:
            selectTag  = DataBaseTable.UserDefaultsTag.float_g2.rawValue
        case DataBaseTable.WeightNumber.g1.rawValue:
            selectTag  = DataBaseTable.UserDefaultsTag.float_g1.rawValue
        case DataBaseTable.WeightNumber.b1.rawValue:
            selectTag  = DataBaseTable.UserDefaultsTag.float_b1.rawValue
        case DataBaseTable.WeightNumber.b2.rawValue:
            selectTag  = DataBaseTable.UserDefaultsTag.float_b2.rawValue
        case DataBaseTable.WeightNumber.b3.rawValue:
            selectTag  = DataBaseTable.UserDefaultsTag.float_b3.rawValue
        case DataBaseTable.WeightNumber.b4.rawValue:
            selectTag  = DataBaseTable.UserDefaultsTag.float_b4.rawValue
        case DataBaseTable.WeightNumber.b5.rawValue:
            selectTag  = DataBaseTable.UserDefaultsTag.float_b5.rawValue
        case DataBaseTable.WeightNumber.b6.rawValue:
            selectTag  = DataBaseTable.UserDefaultsTag.float_b6.rawValue
        case DataBaseTable.WeightNumber.n1.rawValue:
            selectTag  = DataBaseTable.UserDefaultsTag.float_n1.rawValue
        default:
            print("convertIndexToTagFloat-Error")
        }

        return selectTag
    }

    /// Description: 設定するEurekaのタグ名(Sinker)を取得する
    /// - Author: sawatch
    /// - Date: 2018/09/12
    /// - Version: 1.0.1
    /// - Parameters:
    ///   - argIndex:Int    変更した項目のサイズ
    /// - Returns: 設定するEurekaのタグ名
    func convertIndexToTagSinker(argIndex:Int) -> String {
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
        case DataBaseTable.WeightNumber.n1.rawValue:
            selectTag  = DataBaseTable.UserDefaultsTag.sinker_n1.rawValue
        default:
            print("convertIndexToTagSinker-Error")
        }
        
        return selectTag
    }

    /// Description: 整数のインデックスを取得する
    /// - Author: sawatch
    /// - Date: 2018/09/12
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
        case DataBaseTable.WeightNumber.n1.rawValue:
            selectKey   = DataBaseTable.WeightIndex.n1.rawValue
        default:
            print("convertIndexToKey-Error")
        }

        return selectKey
    }

    /// Description: [情報]画面でリセットがONになった場合、各値をリセットする
    /// - Author: sawatch
    /// - Date: 2018/09/04
    /// - Version: 1.0.1
    /// - Parameters:
    /// - Returns:
    func resetValues(){
        // リセットする
        setReload()

        return
    }
}
