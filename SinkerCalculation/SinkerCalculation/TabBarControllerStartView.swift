//
//  TabBarControllerStartView.swift
//  SinkerCalculation
//
//  Created by さわっち on 2018/08/19.
//  Copyright © 2018年 sawatch. All rights reserved.
//

import UIKit

class TabBarControllerStartView: UITabBarController, UITabBarControllerDelegate {

    @IBOutlet weak var tabBarMenu: UITabBar!

    override func viewDidLoad() {
        super.viewDidLoad()

        settingTabBar()
        // Do any additional setup after loading the view.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func settingTabBar(){
        tabBarMenu.barTintColor = UIColor.rgb(r: 0, g: 112, b: 192, alpha: 1)       // 見やすい白
        tabBarMenu.tintColor = UIColor.rgb(r: 244, g: 245, b: 247, alpha: 1)        // 円熟した青
        //tabBarMenu.unselectedItemTintColor = UIColor.white
    }

}

extension UIColor{
    class func rgb(r: Int, g: Int, b: Int, alpha: CGFloat) -> UIColor{
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha:alpha)
    }
}
