//
//  ViewControllerResult.swift
//  SinkerCalculation
//
//  Created by さわっち on 2018/06/27.
//  Copyright © 2018年 sawatch. All rights reserved.
//

/// Description: [画面4] 計算の結果を出力する画面
/// - Note: [その1] ViewControllerResult から ViewControllerCalculation へ戻る処理は、
///                ViewControllerCalculation に記述している。

import UIKit

class ViewControllerResult: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var resultTableView: UITableView!

    var resultCombination = CalculationCombination.resultTable()

    override func viewDidLoad() {
        super.viewDidLoad()

        // 試しに関数のテスト
        resultCombination = CreateResultTable()
        
        // テーブルビュー作成
        resultTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        //// テーブルビューのデリゲートを設定する
        resultTableView.delegate = self
        
        // テーブルビューのデータソースを設定する
        resultTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // セクション数を返す(初期値は1)
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }

    // ヘッダーの高さ
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    /// Description: (必須メソッド)ヘッダー(セクション)に表示する文字列を設定する
    ///
    ///              header(section)
    ///              - 例 : [オモリ3個: 3B(1.00g)+余重(0.01g)]\nパターン 7個]
    /// - Author: sawatch
    /// - Date: 2018/08/15
    /// - Version: 1.0.0
    /// - Parameters:
    ///   - paramA: パラメータAの説明
    ///   - paramB: パラメータBの説明
    /// - Returns:CalculationCombination.resultTable    [計算結果]画面に出力する文字列
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50)
        //view.backgroundColor = UIColor.rgb(r: 83, g: 141, b: 213, alpha: 1)
        view.backgroundColor = UIColor.rgb(r: 0, g: 102, b: 204, alpha: 1)



        let headerLabel = UILabel()
        // "パターン 7個\nオモリ3個: 3B(1.00g)+余重(0.01g)"
        headerLabel.text = resultCombination.header
        headerLabel.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50)
        headerLabel.textColor = UIColor.rgb(r: 244, g: 245, b: 247, alpha: 1)
        headerLabel.textAlignment = NSTextAlignment.center
        headerLabel.numberOfLines = 0
        headerLabel.lineBreakMode = NSLineBreakMode.byCharWrapping
        view.addSubview(headerLabel)
        
        return view
    }

    // セクションごとの行数を返す(必須メソッド)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultCombination.cells.count
    }

    /// Description: (必須メソッド)各1行のセルごとに表示する文字列を設定する
    ///
    ///              cell(summary)
    ///              - 例 : [G4 + G3 + B]
    ///              cell(detail)
    ///              - 例 : [合計 : 1.00g,    余り : 0.01g \nG8(0.07g) G7(0.09g) G7(0.09g) G6(0.12g)]
    /// - Author: sawatch
    /// - Date: 2018/08/15
    /// - Version: 1.0.0
    /// - Parameters:
    ///   - paramA: パラメータAの説明
    ///   - paramB: パラメータBの説明
    /// - Returns:cell 1行のセル
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel!.text = resultCombination.cells[indexPath.row].summary
        cell.textLabel!.numberOfLines = 0
        cell.textLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.detailTextLabel!.text = resultCombination.cells[indexPath.row].detail
        cell.detailTextLabel!.numberOfLines = 0
        cell.detailTextLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping
        return cell
    }

    /// Description: 計算結果の表に設定する値を算出する
    ///
    /// - Author: sawatch
    /// - Date: 2018/08/14
    /// - Version: 1.0.0
    /// - Returns:CalculationCombination.resultTable    [計算結果]画面に出力する文字列
    func CreateResultTable()->CalculationCombination.resultTable{
        let CCalcCombo = CalculationCombination()

        // 選択したウキに合った、オモリの組合せパターンを表示
        var returnCombination = CalculationCombination.resultTable()
        returnCombination = CCalcCombo.mainCalculation()

        return returnCombination
    }



}
