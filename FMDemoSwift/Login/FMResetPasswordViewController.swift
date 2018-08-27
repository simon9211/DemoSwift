//
//  FMResetPasswordViewController.swift
//  FMDemoSwift
//
//  Created by xiwang wang on 2018/8/27.
//  Copyright © 2018年 com.simon. All rights reserved.
//

import UIKit



class FMResetPasswordViewController: FMBaseViewController {

    lazy var titleLable: UILabel = {
        let label: UILabel = UILabel()
        label.text = "重置密码"
        return label
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
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

class FMNaviView: UIView {
    var title: String? {
        get {
            return self.title
        }
        set(value) {
            self.titleLabel.text = value
        }
    }
    var leftBtnIcon: String?
    var rightBtnIcon: String?
    var clickLeftClosure: (()->())?
    var clickRightClosure: (()->())?
    
    lazy var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = ""
        return label
    }()
    
    lazy var leftBtn: UIButton = {
        let btn: UIButton = UIButton()
        btn.setImage(UIImage(named: leftBtnIcon!), for: .normal)
        return btn
    }()
    
    lazy var rightBtn: UIButton = {
        let btn: UIButton = UIButton()
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

protocol FMNaviViewProtocol: NSObjectProtocol{
    var naviView: FMNaviView { get set }
}

