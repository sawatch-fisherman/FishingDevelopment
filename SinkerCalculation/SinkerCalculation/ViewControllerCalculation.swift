//
//  ViewControllerCalculation.swift
//  SinkerCalculation
//
//  Created by さわっち on 2018/06/24.
//  Copyright © 2018年 sawatch. All rights reserved.
//

// Description: [画面1] 計算の値を入力する画面



import UIKit
import Eureka

class ViewControllerCalculation: FormViewController {

    // AppDelegateのインスタンスを取得
    let defaults: UserDefaults = UserDefaults.standard
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate


    override func viewDidLoad() {
        super.viewDidLoad()

        setUserDefaultsToAppDelegate()

        setEurekaControl()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func setEurekaControl() {
        // "オモサ"の正数と小   数点の桁数を設定
        let wrapFormatter = DecimalFormatter()
        wrapFormatter.maximumIntegerDigits = 1
        wrapFormatter.minimumIntegerDigits = 1
        wrapFormatter.maximumFractionDigits = 2
        wrapFormatter.minimumFractionDigits = 2
        
        form
            // Section1
            +++ Section("各項目を選択してください")
            <<< PickerInputRow<String>("UsingFloat"){
                $0.title = "使用するウキ"
                $0.options = ["G8","G7","G6","G5","G4","G3","G2","G1","B","2B","3B","4B","5B","6B"]
                $0.value = self.appDelegate.db_CaluInterface.usingFloatSelect
                }.onChange{ row in
                    self.appDelegate.db_CaluInterface.usingFloatSelect = row.value!
                    self.defaults.set(self.appDelegate.db_CaluInterface.usingFloatSelect, forKey: DataBaseTable.UserDefaultsTag.using_float_select.rawValue)
            }
            <<< PickerInputRow<Int>(){
                $0.title = "使用するオモリの個数"
                $0.options = [2,3,4]
                $0.value = self.appDelegate.db_CaluInterface.theNumberOfSinkers
                }.onChange{ row in
                    self.appDelegate.db_CaluInterface.theNumberOfSinkers = row.value!
                    self.defaults.set(self.appDelegate.db_CaluInterface.theNumberOfSinkers, forKey: DataBaseTable.UserDefaultsTag.the_number_of_sinkers.rawValue)
            }
            <<< DecimalRow() {
                $0.title = "余分な重さ"
                $0.value = self.appDelegate.db_CaluInterface.extraWeightSinker
                $0.formatter = wrapFormatter          // これをこのクラスように作らないといけない
                }.onChange{ row in
                    self.appDelegate.db_CaluInterface.extraWeightSinker = row.value!
                    self.defaults.set(self.appDelegate.db_CaluInterface.extraWeightSinker, forKey: DataBaseTable.UserDefaultsTag.extra_weight_sinker.rawValue)
            }

            // Section_2
            +++ Section("")
            
            <<< ButtonRow() {
                $0.title = "計算"
                }.onCellSelection{ cell, row in
                    // move View Controller of "ID:toResult".
                    self.performSegue(withIdentifier: "toResultViewController", sender: nil)
        }
    }

    /// Storyboadで ViewControllerResult から ViewControllerCalculation へ戻るために必要
    @IBAction func unwindToViewControllerResult(segue: UIStoryboardSegue) {
        // 戻る際の処理が必要な場合は記述
    }


    // 起動時にUserDefaultsのデータをAppDelegateに格納する
    func setUserDefaultsToAppDelegate(){
        let firstBoot = defaults.bool(forKey: DataBaseTable.UserDefaultsTag.first_boot.rawValue)
        if(false == firstBoot){
            // 初回起動時はデフォルト値を設定する
            // Calu画面の設定値
            defaults.register(defaults: [DataBaseTable.UserDefaultsTag.using_float_select.rawValue : "B3"])
            defaults.register(defaults: [DataBaseTable.UserDefaultsTag.using_float_weight.rawValue : 0.00])
            defaults.register(defaults: [DataBaseTable.UserDefaultsTag.the_number_of_sinkers.rawValue : 2])
            defaults.register(defaults: [DataBaseTable.UserDefaultsTag.extra_weight_sinker.rawValue : 0.0])

            // オモリ
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

            // オモリ
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
            
            defaults.set(true, forKey: DataBaseTable.UserDefaultsTag.first_boot.rawValue)
        }
        // 計算
        appDelegate.db_CaluInterface.usingFloatSelect = defaults.string(forKey: DataBaseTable.UserDefaultsTag.using_float_select.rawValue)!
        appDelegate.db_CaluInterface.usingFloatWeight = defaults.double(forKey: DataBaseTable.UserDefaultsTag.using_float_weight.rawValue)
        appDelegate.db_CaluInterface.theNumberOfSinkers = defaults.integer(forKey: DataBaseTable.UserDefaultsTag.the_number_of_sinkers.rawValue)
        appDelegate.db_CaluInterface.extraWeightSinker = defaults.double(forKey: DataBaseTable.UserDefaultsTag.extra_weight_sinker.rawValue)
        
        // ウキ
        appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g8]! = defaults.double(forKey: DataBaseTable.UserDefaultsTag.sinker_g8.rawValue)
        appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g7]! = defaults.double(forKey: DataBaseTable.UserDefaultsTag.sinker_g7.rawValue)
        appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g6]! = defaults.double(forKey: DataBaseTable.UserDefaultsTag.sinker_g6.rawValue)
        appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g5]! = defaults.double(forKey: DataBaseTable.UserDefaultsTag.sinker_g5.rawValue)
        appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g4]! = defaults.double(forKey: DataBaseTable.UserDefaultsTag.sinker_g4.rawValue)
        appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g3]! = defaults.double(forKey: DataBaseTable.UserDefaultsTag.sinker_g3.rawValue)
        appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g2]! = defaults.double(forKey: DataBaseTable.UserDefaultsTag.sinker_g2.rawValue)
        appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g1]! = defaults.double(forKey: DataBaseTable.UserDefaultsTag.sinker_g1.rawValue)
        appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.b1]! = defaults.double(forKey: DataBaseTable.UserDefaultsTag.sinker_b1.rawValue)
        appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.b2]! = defaults.double(forKey: DataBaseTable.UserDefaultsTag.sinker_b2.rawValue)
        appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.b3]! = defaults.double(forKey: DataBaseTable.UserDefaultsTag.sinker_b3.rawValue)
        appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.b4]! = defaults.double(forKey: DataBaseTable.UserDefaultsTag.sinker_b4.rawValue)
        appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.b5]! = defaults.double(forKey: DataBaseTable.UserDefaultsTag.sinker_b5.rawValue)
        appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.b6]! = defaults.double(forKey: DataBaseTable.UserDefaultsTag.sinker_b6.rawValue)

        // オモリ
        appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g8]! = defaults.double(forKey: DataBaseTable.UserDefaultsTag.float_g8.rawValue)
        appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g7]! = defaults.double(forKey: DataBaseTable.UserDefaultsTag.float_g7.rawValue)
        appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g6]! = defaults.double(forKey: DataBaseTable.UserDefaultsTag.float_g6.rawValue)
        appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g5]! = defaults.double(forKey: DataBaseTable.UserDefaultsTag.float_g5.rawValue)
        appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g4]! = defaults.double(forKey: DataBaseTable.UserDefaultsTag.float_g4.rawValue)
        appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g3]! = defaults.double(forKey: DataBaseTable.UserDefaultsTag.float_g3.rawValue)
        appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g2]! = defaults.double(forKey: DataBaseTable.UserDefaultsTag.float_g2.rawValue)
        appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g1]! = defaults.double(forKey: DataBaseTable.UserDefaultsTag.float_g1.rawValue)
        appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.b1]! = defaults.double(forKey: DataBaseTable.UserDefaultsTag.float_b1.rawValue)
        appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.b2]! = defaults.double(forKey: DataBaseTable.UserDefaultsTag.float_b2.rawValue)
        appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.b3]! = defaults.double(forKey: DataBaseTable.UserDefaultsTag.float_b3.rawValue)
        appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.b4]! = defaults.double(forKey: DataBaseTable.UserDefaultsTag.float_b4.rawValue)
        appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.b5]! = defaults.double(forKey: DataBaseTable.UserDefaultsTag.float_b5.rawValue)
        appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.b6]! = defaults.double(forKey: DataBaseTable.UserDefaultsTag.float_b6.rawValue)
        return
        
    }


}
