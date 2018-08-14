//
//  ViewControllerResult.swift
//  SinkerCalculation
//
//  Created by さわっち on 2018/06/27.
//  Copyright © 2018年 sawatch. All rights reserved.
//

// Description: [画面4] 計算の結果を出力する画面

// memo: [その1] ViewControllerResult から ViewControllerCalculation へ戻る処理は、
//              ViewControllerCalculation に記述している。

import UIKit

class ViewControllerResult: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var resultTableView: UITableView!

    var resultCombination = CalculationCombination.resultTable()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 試しに関数のテスト
        CreateResultTable()
        
        // テーブルビュー作成
        resultTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        //// テーブルビューのデリゲートを設定する
        resultTableView.delegate = self
        
        // テーブルビューのデータソースを設定する
        resultTableView.dataSource = self
        
        /*
        // テーブルビューを作成する
        let resultTableView = UITableView(frame: view.frame, style: .grouped)
        
        // テーブルビューのデリゲートを設定する
        resultTableView.delegate = self
        
        // テーブルビューのデータソースを設定する
        resultTableView.dataSource = self
        
        // テーブルビューを表示する
        view.addSubview(resultTableView)
        */
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
    /*
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
     // 例: 3B(1.00g)+0.01g の組合せパターン 2個
     //tableView.rowHeight = UITableViewAutomaticDimension
     return "オモリ3個: 3B(1.00g)+余重(0.01g1)あああああああああああああああああああああああああああああああああああ"
     }
     */
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50)
        //view.backgroundColor = UIColor.cyan
        
        let headerLabel = UILabel()
        // "パターン 7個\nオモリ3個: 3B(1.00g)+余重(0.01g)"
        headerLabel.text = resultCombination.header
        headerLabel.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50)
        //headerLabel.textColor = UIColor.white
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
    
    // 各行に表示するセルを返す(必須メソッド)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        //tableView.rowHeight = UITableViewAutomaticDimension
        cell.textLabel!.text = resultCombination.cells[indexPath.row].summary
        cell.textLabel!.numberOfLines = 0
        cell.textLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.detailTextLabel!.text = resultCombination.cells[indexPath.row].detail
        cell.detailTextLabel!.numberOfLines = 0
        cell.detailTextLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping
        return cell
    }
    
    
    
    
    
    // 表を作成する処理を記述する
    //  ----------------------------- Start -----------------------------
    func CreateResultTable(){
        // クラスのオブジェクトを生成
        let CCalcCombi = CalculationCombination()
        
        // 選択したウキに合った、オモリの組合せパターンを表示
        resultCombination = CCalcCombi.MainCalculation()

    }
    


}
