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
import GoogleMobileAds

class ViewControllerCalculation: FormViewController, GADBannerViewDelegate {
    
    // AppDelegateのインスタンスを取得
    let defaults: UserDefaults = UserDefaults.standard
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    let activityIndicatorView = UIActivityIndicatorView(style: .large)

    /// Description: 使用するオモリの個数を表現する画像
    let sinkerImageView = UIImageView();

    // AdMobバナー
    var bannerAdmobView: GADBannerView!

    /// Description: 起動時の処理
    /// - Note: 2018/09/14 - Ver.1.0.1
    ///              インジケータの設定を追加
    /// - Note: 2021/07/04 - Ver.1.0.3
    ///                 使用するオモリの個数を表現する画像の設定 を追加
    /// - Author:    sawatch
    /// - Date:      2018/08/17
    /// - Version:   1.0.0
    override func viewDidLoad() {
        super.viewDidLoad()

        setUserDefaultsToAppDelegate()

        setSinkerImageViewControl();

        setEurekaControl()

        setAdMob()

        // インジケータの設定
        settingActivityIndicatorView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /// Description: [計算]画面に切り替わった際のイベント
    ///              もしリセットボタンが押されていた場合、各ボタンをリセットする
    /// - Author: sawatch
    /// - Date: 2018/09/06
    /// - Version: 1.0.1
    override func viewDidAppear(_ animated: Bool) {
        if(true == appDelegate.resetFlag.viewCalculation){
            resetValues()
            appDelegate.resetFlag.viewCalculation = false
        }
        return
    }

    /// Description: [計算結果]画面に遷移した直後 のイベント
    ///              インジケータを非表示にする
    /// - Author: sawatch
    /// - Date: 2018/09/14
    /// - Version: 1.0.1
    override func viewDidDisappear(_ animated: Bool) {
        // インジケーター finish
        if (true == self.activityIndicatorView.isAnimating) {
            self.activityIndicatorView.stopAnimating()
        }
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

    
    /// Description:    sinkerImageViewの設定
    /// - Note: 2021/07/04 - Ver.1.0.3
    ///                 使用するオモリの個数を表現する画像の設定
    /// - Author:       sawatch
    /// - Date:         2021/07/14
    /// - Version:      1.0.3
    func setSinkerImageViewControl() {

        let screenW:CGFloat = view.frame.size.width
        let screenH:CGFloat = view.frame.size.height
        
        var multiple:Double = 0.9
        if(screenW < 340){
            multiple = 0.65
        }
        let frameW:CGFloat = screenW * CGFloat(multiple)
        // 16:9 の比率を算出する
        let frameH:CGFloat = (frameW/16) * 9
        sinkerImageView.frame = CGRect(x:0, y:0, width: frameW, height: frameH)
        sinkerImageView.center = CGPoint(x:screenW/2, y:screenH * 0.7)
        
        sinkerImageView.backgroundColor = UIColor.white
        
        sinkerImageView.image = UIImage(named:"useSinkerTwo")

        self.view.addSubview(sinkerImageView)
        
        return;
    }
    
    /// Description: 使用するオモリの個数を表現する画像 の変更
    /// - Note: 2021/07/04 - Ver.1.0.3
    ///                 使用するオモリの個数を表現する画像の変更する
    /// - Author:       sawatch
    /// - Date:         2021/07/14
    /// - Version:      1.0.3
    func changeSinkerImage(argHowManySinker:Int ) {
        switch(argHowManySinker){
        case 2:
            sinkerImageView.image = UIImage(named:"useSinkerTwo")
            break;
        case 3:
            sinkerImageView.image = UIImage(named:"useSinkerThree")
            break;
        case 4:
            sinkerImageView.image = UIImage(named:"useSinkerFour")
            break;
        default:
            sinkerImageView.image = UIImage(named:"useSinkerTwo")
        }

        self.view.addSubview(sinkerImageView)

        return;
    }
    
    /// Description:    Eurekaの設定
    /// - Note: 2018/09/14 - Ver.1.0.1
    ///                 使用するウキの個数のエラー(範囲値)チェックを追加
    ///                 >>余幅
    ///                 - 余幅のチェックを追加
    ///                 >>計算開始
    ///                 - インジケータの表示を追加
    /// - Note: 2021/07/04 - Ver.1.0.3
    ///                 使用するオモリの個数の画像を表示する処理を追加した
    ///
    /// - Author:       sawatch
    /// - Date:         2018/08/17
    /// - Version:      1.0.0
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
            <<< PickerInputRow<String>(DataBaseTable.UserDefaultsTag.using_float_select.rawValue){
                $0.title = "使用するウキ"
                $0.options = [DataBaseTable.WeightShow.g8.rawValue, DataBaseTable.WeightShow.g7.rawValue, DataBaseTable.WeightShow.g6.rawValue, DataBaseTable.WeightShow.g5.rawValue,
                              DataBaseTable.WeightShow.g4.rawValue, DataBaseTable.WeightShow.g3.rawValue, DataBaseTable.WeightShow.g2.rawValue, DataBaseTable.WeightShow.g1.rawValue,
                              DataBaseTable.WeightShow.b1.rawValue, DataBaseTable.WeightShow.b2.rawValue, DataBaseTable.WeightShow.b3.rawValue,
                              DataBaseTable.WeightShow.b4.rawValue, DataBaseTable.WeightShow.b5.rawValue, DataBaseTable.WeightShow.b6.rawValue,
                              DataBaseTable.WeightShow.n1.rawValue ]
                $0.value = self.appDelegate.db_CaluInterface.usingFloatSelect
                }.onChange{ row in
                    self.appDelegate.db_CaluInterface.usingFloatSelect = row.value!
                    self.defaults.set(self.appDelegate.db_CaluInterface.usingFloatSelect, forKey: DataBaseTable.UserDefaultsTag.using_float_select.rawValue)
            }
            <<< PickerInputRow<Int>(DataBaseTable.UserDefaultsTag.the_number_of_sinkers.rawValue){
                $0.title = "使用するオモリの個数"
                $0.options = [2,3,4]
                var number:Int = self.appDelegate.db_CaluInterface.theNumberOfSinkers
                if ( (2>number) || (4<number) ) {
                    // 範囲外の値の場合,"2"を設定する
                    number = 2
                }
                $0.value = number

                // 画像の切替
                changeSinkerImage(argHowManySinker: number)
                
                // イベント
                }.onChange{ row in
                    self.appDelegate.db_CaluInterface.theNumberOfSinkers = row.value!
                    self.defaults.set(self.appDelegate.db_CaluInterface.theNumberOfSinkers, forKey: DataBaseTable.UserDefaultsTag.the_number_of_sinkers.rawValue)
                    // 画像の切替
                    self.changeSinkerImage(argHowManySinker: row.value!)
            }
            <<< DecimalRow(DataBaseTable.UserDefaultsTag.extra_weight_sinker.rawValue) {
                $0.title = "余幅 重さ"
                $0.value = self.appDelegate.db_CaluInterface.extraWeightSinker
                $0.formatter = wrapFormatter          // これをこのクラスように作らないといけない
                }.onChange{ row in
                    self.alertDelay(argCheckValue: row.value!)
                    self.appDelegate.db_CaluInterface.extraWeightSinker = row.value!
                    self.defaults.set(self.appDelegate.db_CaluInterface.extraWeightSinker, forKey: DataBaseTable.UserDefaultsTag.extra_weight_sinker.rawValue)
            }

            // Section_2
            +++ Section()       // ""を入れると微妙に空行が入る
            
            <<< ButtonRow() {
                $0.title = "計算開始"
                }.onCellSelection{ cell, row in
                    // インジケーター start
                    // このタイミングで呼び出さなければ、画面切り替え前にインジケータを表示できない
                    self.activityIndicatorView.startAnimating()

                    // move View Controller of "ID:toResult".
                    self.performSegue(withIdentifier: "toResultViewController", sender: nil)
                    
                    // インジケーター finish
                    if (true == self.activityIndicatorView.isAnimating) {
                        self.activityIndicatorView.stopAnimating()
                    }
        }
    }

    /// Description: 余幅が1.00以上の場合、警告メッセージを表示する
    ///              初回起動時 : デフォルト値を設定する
    /// - Author: sawatch
    /// - Date: 2018/09/13
    /// - Version: 1.0.1
    func alertDelay(argCheckValue:Double){
        if(argCheckValue < 1.00){
            return
        }
        // "保存しました"
        let alert = UIAlertController(title: "", message: "余幅が1.00以上の場合、計算に時間がかかる場合があります。\n0.99以下の値を推奨します。", preferredStyle: UIAlertController.Style.alert)
        present(alert, animated: true, completion: {
            // アラートを閉じる
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                alert.dismiss(animated: true, completion: nil)
            })
            
        })
        return
    }

    /// Storyboadで ViewControllerResult から ViewControllerCalculation へ戻るために必要
    @IBAction func unwindToViewControllerResult(segue: UIStoryboardSegue) {
        // 戻る際の処理が必要な場合は記述
    }

    /// Description: 起動時にUserDefaultsのデータをAppDelegateに格納する
    ///              初回起動時 : デフォルト値を設定する
    ///              ２回目以降 : UserDefaultsに設定された値を使用する
    /// - Note: 2018/08/25 - Ver.1.0.1
    ///              初回起動時にAppDelegateの値が全て"0"の不具合を修正
    ///              UserDefaultsを初期化する処理を別関数に置き換え
    /// - Author: sawatch
    /// - Date: 2018/08/17
    /// - Version: 1.0.0
    func setUserDefaultsToAppDelegate(){
        #if DEBUG
        print("Func -setUserDefaultsToAppDelegate-")
        #endif
        var firstBoot:Bool = false

        if (defaults.object(forKey: DataBaseTable.UserDefaultsTag.first_boot.rawValue) == nil) {
            firstBoot = true
        }
        
        let CManageUD = ManagementUserDefaults()
        if(true == firstBoot){
            // 初回起動時はデフォルト値を設定する
            CManageUD.formatAllUserDefaults()
        }
        // [計算]画面の設定値
        let value:String? = defaults.string(forKey: DataBaseTable.UserDefaultsTag.using_float_select.rawValue)
        if(value != nil){
            appDelegate.db_CaluInterface.usingFloatSelect = value!
        }else{
            appDelegate.db_CaluInterface.usingFloatSelect = DataBaseTable.WeightShow.b3.rawValue
        }
        appDelegate.db_CaluInterface.usingFloatWeight = defaults.double(forKey: DataBaseTable.UserDefaultsTag.using_float_weight.rawValue)
        appDelegate.db_CaluInterface.theNumberOfSinkers = defaults.integer(forKey: DataBaseTable.UserDefaultsTag.the_number_of_sinkers.rawValue)
        appDelegate.db_CaluInterface.extraWeightSinker = defaults.double(forKey: DataBaseTable.UserDefaultsTag.extra_weight_sinker.rawValue)

        // [設定]画面の設定値
        for index in 0..<DataBaseTable.WeightNumber.WeightNumbers.count{
            appDelegate.db_Weights.db_Float.weights[DataBaseTable.WeightIndex.WeightIndexs[index]]! = defaults.double(forKey: DataBaseTable.UserDefaultsTag.FloatTags[index].rawValue)
            appDelegate.db_Weights.db_Sinker.weights[DataBaseTable.WeightIndex.WeightIndexs[index]]! = defaults.double(forKey: DataBaseTable.UserDefaultsTag.SinkerTags[index].rawValue)

            #if DEBUG
            print("Keys:", DataBaseTable.WeightIndex.WeightIndexs[index])
            let debugFloat:Double = defaults.double(forKey: DataBaseTable.UserDefaultsTag.FloatTags[index].rawValue)
            print("Float:", debugFloat)
            let debugSinker:Double = defaults.double(forKey: DataBaseTable.UserDefaultsTag.SinkerTags[index].rawValue)
            print("Sinker:", debugSinker)
            #endif
        }
        if(true == firstBoot){
            // 初回起動時は設定した値を保存する
            // この処理を実行しないと、何も操作せずにアプリを起動した場合、
            // 全ての値が "0" になってしまう。
            CManageUD.setAllAppDelegateToDefaults()
            defaults.set(true, forKey: DataBaseTable.UserDefaultsTag.first_boot.rawValue)
        }
        return
    }

    /// Description: [情報]画面でリセットがONになった場合、各値をリセットする
    /// - Author: sawatch
    /// - Date: 2018/09/06
    /// - Version: 1.0.1
    /// - Parameters:
    /// - Returns:
    func resetValues(){
        // 使用するウキ
        form.rowBy(tag: DataBaseTable.UserDefaultsTag.using_float_select.rawValue)?.baseValue = self.appDelegate.db_CaluInterface.usingFloatSelect
        form.rowBy(tag: DataBaseTable.UserDefaultsTag.using_float_select.rawValue)?.reload()
        
        // 使用するオモリの個数
        form.rowBy(tag: DataBaseTable.UserDefaultsTag.the_number_of_sinkers.rawValue)?.baseValue = self.appDelegate.db_CaluInterface.theNumberOfSinkers
        form.rowBy(tag: DataBaseTable.UserDefaultsTag.the_number_of_sinkers.rawValue)?.reload()

        // 余幅 重さ
        form.rowBy(tag: DataBaseTable.UserDefaultsTag.extra_weight_sinker.rawValue)?.baseValue = self.appDelegate.db_CaluInterface.extraWeightSinker
        form.rowBy(tag: DataBaseTable.UserDefaultsTag.extra_weight_sinker.rawValue)?.reload()

        return
    }

    //////////////////////
    // AdMob設定 --Start--
    //////////////////////
    /// Description:    GADBannerViewの設定値を設定する
    /// - Author:       sawatch
    /// - Date:         2018/08/17
    /// - Version:      1.0.0
    func setAdMob(){
        bannerAdmobView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerAdmobView.adUnitID = "ca-app-pub-2499860722935748/3456863002"
        bannerAdmobView.rootViewController = self
        bannerAdmobView.load(GADRequest())
        bannerAdmobView.delegate = self
        settingBannerViewToView(bannerAdmobView)
    }

    func settingBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                // Rep Str 2021.06.08
                                //toItem: bottomLayoutGuide,
                                //attribute: .top,
                                toItem: view.safeAreaLayoutGuide,
                                attribute: .bottom,
                                // Rep End
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }

    /// Delegate処理 start
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
    }

    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
    }

    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }

    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }

    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
    }
    /// Delegate処理 finish
    //////////////////////
    // AdMob設定 --Finish--
    //////////////////////


}
