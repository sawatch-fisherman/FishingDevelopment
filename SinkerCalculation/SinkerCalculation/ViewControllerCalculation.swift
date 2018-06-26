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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setEurekaControl()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setEurekaControl() {
        
        // "オモサ"の正数と小数点の桁数を設定
        let wrapFormatter = NumberFormatter()
        wrapFormatter.maximumIntegerDigits = 1
        wrapFormatter.minimumIntegerDigits = 1
        wrapFormatter.maximumFractionDigits = 2
        wrapFormatter.minimumFractionDigits = 2

        form
            // Section1
            +++ Section("各項目を選択してください")
            <<< PickerInputRow<String>(){
                $0.title = "使用するウキ"
                $0.options = ["G8","G7","G6"]
                $0.value = "G8"
            }
            
            <<< PickerInputRow<String>(){
                $0.title = "使用するオモリの個数"
                $0.options = ["2","3","4"]
                $0.value = "2"
            }
            <<< DecimalRow() {
                $0.title = "余分な重さ"
                $0.value = 1.12
                $0.formatter = wrapFormatter
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    /// Storyboadで ViewControllerResult から ViewControllerCalculation へ戻るために必要
    @IBAction func unwindToViewControllerResult(segue: UIStoryboardSegue) {
        // 戻る際の処理が必要な場合は記述
    }

    
    
    
    

}
