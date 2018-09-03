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

    override func viewDidLoad() {
        super.viewDidLoad()

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


    // セクション数を返す(初期値は1)
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }

    // セクションタイトルを返す
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " アプリ情報"
     }

    // セクションごとの行数を返す(必須メソッド)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    /// Description: (必須メソッド)各1行のセルごとに表示する文字列を設定する
    /// - Note: 2018/09/01 - Ver.1.0.1
    ///              アクセサリの種類を detailButton から デフォルト に変更
    /// - Author: sawatch
    /// - Date: 2018/08/16
    /// - Version: 1.0.0
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
            self.performSegue(withIdentifier: "toInformationDetail", sender: nil)
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


}
