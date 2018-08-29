//
//  FMMainViewController.swift
//  FMDemoSwift
//
//  Created by xiwang wang on 2018/8/28.
//  Copyright © 2018年 com.simon. All rights reserved.
//

import UIKit

class FMMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let attrs: Dictionary<NSAttributedStringKey,NSObject> = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 12), NSAttributedStringKey.foregroundColor:UIColor.white]
        let selectAttrs: Dictionary<NSAttributedStringKey,NSObject> = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 12), NSAttributedStringKey.foregroundColor:SMColor(r: 47, g: 187, b: 200, a: 1.0)]
        let item: UITabBarItem = UITabBarItem.appearance()
        item.setTitleTextAttributes(attrs, for: .normal)
        item.setTitleTextAttributes(selectAttrs, for: .selected)
        
        let tabbarView: UIView = UIView(frame: tabBar.bounds)
        tabbarView.height = 100
        tabbarView.backgroundColor = SMColor(r: 67, g: 64, b: 77, a: 1.0)
        tabBar.addSubview(tabbarView)
        
        view.backgroundColor = .white
        
        let childVCs: Array<Dictionary<String, String>> = [
            [
                "vc":"UIViewController",
                "title":"首页",
                "image":"home",
                "selectImage":"home_selected"
            ],
            [
                "vc":"UIViewController",
                "title":"货流",
                "image":"store",
                "selectImage":"store_selected"
            ],
            [
                "vc":"UIViewController",
                "title":"会员",
                "image":"member",
                "selectImage":"member_selected"
            ],
            [
                "vc":"UIViewController",
                "title":"功能中心",
                "image":"functionalCenter",
                "selectImage":"functionalCenter_selected"
            ]
        ]
        
        for item in childVCs {
            
            self.setupChildVC(vcstr: item["vc"]!, title: item["title"]!, image: item["image"]!, selectImage: item["selectImage"]!)
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    
    func setupChildVC(vcstr: String, title: String, image: String, selectImage: String) {
        let vcClass = NSClassFromString(vcstr) as! UIViewController.Type
        let vc = vcClass.init()
        
        vc.title = title
        vc.tabBarItem.image = UIImage(named: image)?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named: selectImage)?.withRenderingMode(.alwaysOriginal)
        self.addChildViewController(UINavigationController(rootViewController: vc))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
