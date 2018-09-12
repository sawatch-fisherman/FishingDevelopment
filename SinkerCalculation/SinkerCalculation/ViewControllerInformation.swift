//
//  ViewControllerInformation.swift
//  SinkerCalculation
//
//  Created by さわっち on 2018/06/24.
//  Copyright © 2018年 sawatch. All rights reserved.
//

// Description: [画面3] アプリの情報を表示する画面

import UIKit
import MessageUI        // Mail1機能

class ViewControllerInformation: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var informationTableView: UITableView!
    
    var selectItem:Int = kindItem.version.rawValue

    let defaults: UserDefaults = UserDefaults.standard
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)

    /// Description: アプリ情報のインデックス
    /// - Note: 2018/09/01 - Ver.1.0.1
    ///              項目[reset]を追加
    /// - Author: sawatch
    /// - Date: 2018/08/16
    /// - Version: 1.0.0
    enum kindItem:Int {
        case version = 0
        case disclaimer
        case inquiry
        case reset
    }

    /// Description: アプリ情報のインデックス
    /// - Note: 2018/09/01 - Ver.1.0.1
    ///              項目[リセット]を追加
    /// - Author: sawatch
    /// - Date: 2018/08/16
    /// - Version: 1.0.0
    let items:[String] = ["バージョン", "利用規約および免責事項", "開発者に問い合わせ", "リセット"]


    /// Description: [情報]画面がインスタンス化された直後のイベント(初回に1回のみ実行される)
    /// - Note: 2018/09/06 - Ver.1.0.1
    ///              インジケータの設定処理を追加
    /// - Author: sawatch
    /// - Date: 2018/08/17
    /// - Version: 1.0.0
    override func viewDidLoad() {
        super.viewDidLoad()

        // インジケータの設定
        settingActivityIndicatorView()

        // テーブルビュー作成
        //informationTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        //// テーブルビューのデリゲートを設定する
        informationTableView.delegate = self
        
        // テーブルビューのデータソースを設定する
        informationTableView.dataSource = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /// Description: UIActivityIndicatorViewの設定
    /// - Author: sawatch
    /// - Date: 2018/09/06
    /// - Version: 1.0.1
    func settingActivityIndicatorView(){
        self.view.addSubview(activityIndicatorView)
        self.view.bringSubview(toFront: activityIndicatorView)
        activityIndicatorView.frame = self.view.bounds
    }

    // セクション数を返す(初期値は1)
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }

    // セクションタイトルを返す
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " アプリ情報"
     }

    // セクションごとの行数を返す(必須な関数)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    /// Description:    (必須な関数)各1行のセルごとに表示する文字列を設定する
    /// - Note:         2018/09/01 - Ver.1.0.1
    ///                 アクセサリの種類を detailButton から デフォルト に変更
    /// - Author:       sawatch
    /// - Date:         2018/08/16
    /// - Version:      1.0.0
    /// - Parameters:
    ///   - paramA: パラメータAの説明
    ///   - paramB: パラメータBの説明
    /// - Returns:cell 1行のセル
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell:UITableViewCell = informationTableView.dequeueReusableCell(withIdentifier: "InformationCell", for: indexPath)
        cell.textLabel!.text = items[indexPath.row]
        return cell
    }

    /// Description: セルを押した時の処理セル
    /// - Note: 2018/09/01 - Ver.1.0.1
    ///              1. アクセサリーボタンのイベント関数[tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath)]を削除
    ///                 代わりにセル押下のイベントに変更
    ///              2. 項目[リセット]を追加
    /// - Author: sawatch
    /// - Date: 2018/09/01
    /// - Version: 1.0.1
    /// - Parameters:
    ///   - tableView:UITableView                  : テーブルビュー
    ///   - didSelectRowAt indexPath:IndexPath     : 選択された行
    /// - Returns:cell 1行のセル
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch(indexPath.row)
        {
        case kindItem.version.rawValue:
            selectItem = kindItem.version.rawValue
            self.performSegue(withIdentifier: "toInformationDetail", sender: nil)
        case kindItem.disclaimer.rawValue:
            selectItem = kindItem.disclaimer.rawValue
            self.performSegue(withIdentifier: "toInformationDetail", sender: nil)
        case kindItem.inquiry.rawValue:
            sendMail()
        case kindItem.reset.rawValue:
            selectItem = kindItem.reset.rawValue
            // 確認のダイアログを作らないといけない
            resetMain()
        default:
            print("Error")
        }
        
        return
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController:ViewControllerInformationDetail = segue.destination as! ViewControllerInformationDetail
        viewController.showPage = selectItem
    }
    
    
    /// Description: Mailerの画面設定
    /// - Author: sawatch
    /// - Date: 2018/08/17
    /// - Version: 1.0.0
    /// - Warning: この関数は実機のみ動作する
    ///            シミュレータでは未動作となる
    /// - Parameters:
    ///   - tableView:UITableView                                   : テーブルビュー
    ///   - accessoryButtonTappedForRowWith indexPath:IndexPath     : 選択された行
    /// - Returns:cell 1行のセル
    func sendMail(){
        if MFMailComposeViewController.canSendMail(){
            let mailConfig = MFMailComposeViewController()
            mailConfig.mailComposeDelegate = self
            mailConfig.setToRecipients(["sawatch.fisherman@gmail.com"])
            mailConfig.setSubject("オモポチ:お問い合わせ")
            mailConfig.setMessageBody("", isHTML: false)
            present(mailConfig, animated: true, completion: nil)
        } else {
            print("Send Error")
        }

        return
    }

    
    /// Description: Mailer画面のボタン押下の操作
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result{
        case .cancelled:
            print("cansel")
        case .saved:
            print("save the draft")
        case .sent:
            print("send succeed")
        default:
            print("send fail")
        }
        dismiss(animated: true, completion: nil)
        return
    }

    /// Storyboadで ViewControllerInformationDetail から ViewControllerInformation へ戻るために必要
    @IBAction func unwindToViewControllerResult(segue: UIStoryboardSegue) {
        // 戻る際の処理が必要な場合は記述
    }


    /// Description: リセット有無の確認ダイアログを表示
    ///              初期化する: 全ての設定値を初期化する
    ///              戻る:リセットをキャンセル
    /// - Author: sawatch
    /// - Date: 2018/09/06
    /// - Version: 1.0.1
    func resetMain(){

        // インジケーター start
        activityIndicatorView.startAnimating()
        
        // アラートを表示
        let title = "リセット確認"
        let message = "全ての設定値を初期化してよろしいですか？ \n※編集した内容が全て初期状態に戻ります。"

        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "戻る", style: UIAlertActionStyle.default, handler: {
            (action: UIAlertAction!) -> Void in
            // ボタン押下後の処理
            // インジケーター finish
            if (true == self.activityIndicatorView.isAnimating) {
                self.activityIndicatorView.stopAnimating()
            }
        })
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "初期化する", style: UIAlertActionStyle.cancel, handler: {
            (action: UIAlertAction!) -> Void in
            // ボタン押下後の処理
            self.resetDefaultsValues()
            
            // インジケーター finish
            if (true == self.activityIndicatorView.isAnimating) {
                self.activityIndicatorView.stopAnimating()
            }

            // "編集中の内容を破棄しました"
            let alert2 = UIAlertController(title: "", message: "全ての設定値を初期化しました", preferredStyle: UIAlertControllerStyle.alert)
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

        return
    }

    /// Description: 設定値を初期化する
    ///              1.AppleDelegeteを初期化
    ///              2.UserDefaultを初期化
    /// - Note:
    /// - Author: sawatch
    /// - Date: 2018/09/12
    /// - Version: 1.0.1
    func resetDefaultsValues(){
        #if DEBUG
        print("Func -resetDefaultsValues-")
        #endif
        appDelegate.resetFlag.viewCalculation = true
        appDelegate.resetFlag.viewWeight = true

        appDelegate.db_CaluInterface.usingFloatSelect = "B3"

        appDelegate.db_CaluInterface.theNumberOfSinkers = 2

        appDelegate.db_CaluInterface.extraWeightSinker = 0.00

        // [設定]画面の設定値 ウキ
        appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g8] = 0.07
        appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g7] = 0.09
        appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g6] = 0.12
        appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g5] = 0.17
        appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g4] = 0.20
        appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g3] = 0.25
        appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g2] = 0.33
        appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.g1] = 0.45
        appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.b1] = 0.55
        appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.b2] = 0.80
        appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.b3] = 1.00
        appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.b4] = 1.25
        appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.b5] = 1.75
        appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.b6] = 2.20
        appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.n1] = 3.75
        
        // [設定]画面の設定値 オモリ
        appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g8] = 0.07
        appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g7] = 0.09
        appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g6] = 0.12
        appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g5] = 0.17
        appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g4] = 0.20
        appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g3] = 0.25
        appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g2] = 0.33
        appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.g1] = 0.45
        appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.b1] = 0.55
        appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.b2] = 0.80
        appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.b3] = 1.00
        appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.b4] = 1.25
        appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.b5] = 1.75
        appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.b6] = 2.20
        appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.n1] = 3.75

        // 初回起動時はデフォルト値を設定する
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


}
