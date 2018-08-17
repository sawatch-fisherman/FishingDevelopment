//
//  ViewControllerInformationDetail.swift
//  SinkerCalculation
//
//  Created by さわっち on 2018/08/16.
//  Copyright © 2018年 sawatch. All rights reserved.
//

// Description: [画面5] [設定]画面の詳細

import UIKit

class ViewControllerInformationDetail: UIViewController {

    @IBOutlet weak var textViewInfoDetail: UITextView!


    // 表示するページ
    // ViewControllerInformation画面で設定する
    var showPage:Int = ViewControllerInformation.kindItem.version.rawValue

    override func viewDidLoad() {
        super.viewDidLoad()

        setTextToUITextView(argShowPage: showPage)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /// Description: UITextViewの設定値を設定する
    ///              - 編集を無効にする
    ///              - 選択を無効にする
    /// - Author: sawatch
    /// - Date: 2018/08/17
    /// - Version: 1.0.0
    func settingUITextView(){
        // textViewInfoDetail.allowsEditingTextAttributes
        // 未作成
        return
    }

    /// Description: UITextViewに各項目の詳細を設定する
    /// - Author: sawatch
    /// - Date: 2018/08/15
    /// - Version: 1.0.0
    /// - Parameters:
    ///   - argShowPage:Int 設定する項目番号
    func setTextToUITextView(argShowPage:Int){
        switch (argShowPage) {
        case ViewControllerInformation.kindItem.version.rawValue:
            setTextVersion()
        case ViewControllerInformation.kindItem.disclaimer.rawValue:
            setTextDisclaimer()
        default:
            textViewInfoDetail.text = "Error"
        }
        return
    }

    /// Description: バージョンの内容を設定
    /// - Author: sawatch
    /// - Date: 2018/08/17
    /// - Version: 1.0.0
    /// - Parameters:
    ///   - argShowPage:Int 設定する項目番号
    func setTextVersion(){
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        textViewInfoDetail.text = "Version: \(version) -  (\(build)) "

        return
    }

    /// Description: 利用規約および免責事項の内容を設定
    /// - Author: sawatch
    /// - Date: 2018/08/17
    /// - Version: 1.0.0
    func setTextDisclaimer(){
        textViewInfoDetail.text = "本アプリケーションには、以下の利用規約および免責事項が適用されるものと致します。\n予めお読みいただき内容を十分ご理解いただいたうえで御利用をお願いいたします。同意いただけない場合は御利用はお控えください。\n\n【利用規約および免責事項】\n本アプリケーションの御利用につき、御利用者自身または第三者に何らかのトラブルや損失・損害等などが発生しても、開発者では責任を負いかねますので、ご了承ください。\n本アプリケーションを使用をしても必ずしも目的を達成できない場合もありえます、ご了承ください。\n本アプリケーションの利用に関して、御利用者に御満足いただけるよう努めてまいりますが、止むをえない事由等により開発者が必要と判断した場合には、いつでも、予告なく本アプリケーションの変更、開発の中止、サービスの停止等をすることができるものとします。\n【著作権】\n本ソフトウエアに関する著作権その他の全ての権利は該当の作者に帰属します。"

        return
    }

}
