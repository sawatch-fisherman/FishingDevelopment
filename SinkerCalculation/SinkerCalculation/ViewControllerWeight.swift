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

    override func viewDidLoad() {
        super.viewDidLoad()

        setEurekaControl()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func clickButtonSave(_ sender: Any) {
    }
    
    @IBAction func clickButtonCancel(_ sender: Any) {
    }
    
    
    
    func setEurekaControl() {

        // "オモサ"の正数と小数点の桁数を設定
        let wrapFormatter = NumberFormatter()
        wrapFormatter.maximumIntegerDigits = 1
        wrapFormatter.minimumIntegerDigits = 1
        wrapFormatter.maximumFractionDigits = 2
        wrapFormatter.minimumFractionDigits = 2
        
        form
            // ウキの設定
            +++ Section("ウキのオモサ (単位:g)")
            <<< DecimalRow() {
                $0.title = "G8"
                $0.value = 0.07
                $0.formatter = wrapFormatter
            }
            <<< DecimalRow() {
                $0.title = "G7"
                $0.value = 0.09
                $0.formatter = wrapFormatter
            }
            <<< DecimalRow() {
                $0.title = "G6"
                $0.value = 0.12
                $0.formatter = wrapFormatter
            }
            <<< DecimalRow() {
                $0.title = "G5"
                $0.value = 0.17
                $0.formatter = wrapFormatter
            }
            <<< DecimalRow() {
                $0.title = "G4"
                $0.value = 0.20
                $0.formatter = wrapFormatter
            }
            <<< DecimalRow() {
                $0.title = "G3"
                $0.value = 0.25
                $0.formatter = wrapFormatter
            }
            <<< DecimalRow() {
                $0.title = "G2"
                $0.value = 0.33
                $0.formatter = wrapFormatter
            }
            <<< DecimalRow() {
                $0.title = "G1"
                $0.value = 0.45
                $0.formatter = wrapFormatter
            }
            <<< DecimalRow() {
                $0.title = "B"
                $0.value = 0.55
                $0.formatter = wrapFormatter
            }
            <<< DecimalRow() {
                $0.title = "2B"
                $0.value = 0.80
                $0.formatter = wrapFormatter
            }
            <<< DecimalRow() {
                $0.title = "3B"
                $0.value = 1.00
                $0.formatter = wrapFormatter
            }
            <<< DecimalRow() {
                $0.title = "4B"
                $0.value = 1.25
                $0.formatter = wrapFormatter
            }
            <<< DecimalRow() {
                $0.title = "5B"
                $0.value = 1.75
                $0.formatter = wrapFormatter
            }
            <<< DecimalRow() {
                $0.title = "6B"
                $0.value = 2.20
                $0.formatter = wrapFormatter
            }
            
            // オモリの設定
            +++ Section("オモリのオモサ (単位:g)")
            <<< DecimalRow() {
                $0.title = "G8"
                $0.value = 0.07
                $0.formatter = wrapFormatter
            }
            <<< DecimalRow() {
                $0.title = "G7"
                $0.value = 0.09
                $0.formatter = wrapFormatter
            }
            <<< DecimalRow() {
                $0.title = "G6"
                $0.value = 0.12
                $0.formatter = wrapFormatter
            }
            <<< DecimalRow() {
                $0.title = "G5"
                $0.value = 0.17
                $0.formatter = wrapFormatter
            }
            <<< DecimalRow() {
                $0.title = "G4"
                $0.value = 0.20
                $0.formatter = wrapFormatter
            }
            <<< DecimalRow() {
                $0.title = "G3"
                $0.value = 0.25
                $0.formatter = wrapFormatter
            }
            <<< DecimalRow() {
                $0.title = "G2"
                $0.value = 0.33
                $0.formatter = wrapFormatter
            }
            <<< DecimalRow() {
                $0.title = "G1"
                $0.value = 0.45
                $0.formatter = wrapFormatter
            }
            <<< DecimalRow() {
                $0.title = "B"
                $0.value = 0.55
                $0.formatter = wrapFormatter
            }
            <<< DecimalRow() {
                $0.title = "2B"
                $0.value = 0.80
                $0.formatter = wrapFormatter
            }
            <<< DecimalRow() {
                $0.title = "3B"
                $0.value = 1.00
                $0.formatter = wrapFormatter
            }
            <<< DecimalRow() {
                $0.title = "4B"
                $0.value = 1.25
                $0.formatter = wrapFormatter
            }
            <<< DecimalRow() {
                $0.title = "5B"
                $0.value = 1.75
                $0.formatter = wrapFormatter
            }
            <<< DecimalRow() {
                $0.title = "6B"
                $0.value = 2.20
                $0.formatter = wrapFormatter
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

}
