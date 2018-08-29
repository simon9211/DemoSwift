//
//  FMResetPasswordViewController.swift
//  FMDemoSwift
//
//  Created by xiwang wang on 2018/8/27.
//  Copyright © 2018年 com.simon. All rights reserved.
//

import UIKit



class FMResetPasswordViewController: FMBaseViewController {

    lazy private var _naviView: FMNaviView = {
        let navi: FMNaviView = FMNaviView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 84))
        navi.leftBtnIcon = "back"
        navi.title = "重置密码"
        return navi
    }()
    
    lazy private var emailField: SMAnimationTextField = {
        let textField = SMAnimationTextField(frame: .zero)
        textField.placeholder = "E-mail"
        return textField
    }()
    
    lazy private var verifyCodeField: SMAnimationTextField = {
        let textField = SMAnimationTextField(frame: .zero)
        textField.placeholder = "验证码"
        return textField
    }()
    
    lazy private var newPWDField: SMAnimationTextField = {
        let textField = SMAnimationTextField(frame: .zero)
        textField.placeholder = "新密码"
        return textField
    }()
    
    lazy private var makesurePWDField: SMAnimationTextField = {
        let textField = SMAnimationTextField(frame: .zero)
        textField.placeholder = "确认密码"
        return textField
    }()
    
    lazy var resetPWDBtn: UIButton = {
        let btn = UIButton()
        
        btn.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { () in
            print("reset password action")
            
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
        btn.setTitle("确认重置", for:.normal)
        btn.titleLabel?.font = .systemFont(ofSize: 15)
        btn.setTitleColor(.white, for:.normal)
        btn.backgroundColor = SMColor(r:47, g:187, b: 200, a: 1.0)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 20
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    
        self.createUI()
    }
    
    private func createUI() {
        view.addSubview(naviView)
        view.addSubview(emailField)
        view.addSubview(verifyCodeField)
        view.addSubview(newPWDField)
        view.addSubview(makesurePWDField)
        view.addSubview(resetPWDBtn)
        
        naviView.clickClosure = { (index) in
            print("closure done")
            if index == 1 {
                self.dismiss(animated: true, completion: {})
            } else if index == 2 {
                
            }
        }
    }

    override func updateViewConstraints() {
        
        emailField.snp.makeConstraints { (make) in
            make.top.equalTo(naviView.snp.bottom).offset(50)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(50)
        }
        
        verifyCodeField.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.top.equalTo(emailField.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        
        newPWDField.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.top.equalTo(verifyCodeField.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        
        makesurePWDField.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.top.equalTo(newPWDField.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        
        resetPWDBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(80)
            make.right.equalTo(self.view.snp.right).offset(-80)
            make.height.equalTo(40)
            make.bottom.greaterThanOrEqualToSuperview().priority(750)
            make.top.equalTo(makesurePWDField.snp.bottom).offset(50).priority(1000)
        }
        super.updateViewConstraints()
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

extension FMResetPasswordViewController: FMNaviViewProtocol {
    
    var naviView: FMNaviView {
        get {
            return _naviView
        }
    }
    
    
    
}

class FMNaviView: UIView {
    private var _title: String?
    var title: String? {
        get {
            return _title!
        }
        set(value) {
            _title = value
            self.titleLabel.text = value
        }
    }
    private var _leftBtnIcon: String? = ""
    var leftBtnIcon: String? {
        get{
            return _leftBtnIcon!
        }
        set(value) {
            _leftBtnIcon = value
            self.leftBtn.setImage(UIImage(named: value!), for: .normal)
        }
    }
    var rightBtnIcon: String?
    var clickClosure: ((_ index: NSInteger)->())?
    
    lazy var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textAlignment = .center
        label.text = "title"
        return label
    }()
    
    lazy var leftBtn: UIButton = {
        let btn: UIButton = UIButton()
        btn.setImage(UIImage(named: leftBtnIcon ?? ""), for: .normal)
        btn.rx.tap.subscribe(onNext: { () in
            print("click left item")
            self.clickClosure?(1)
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        return btn
    }()
    
    lazy var rightBtn: UIButton = {
        let btn: UIButton = UIButton()
        btn.setImage(UIImage(named: rightBtnIcon ?? ""), for: .normal)
        btn.rx.tap.subscribe(onNext: { () in
            print("click right item")
            self.clickClosure?(2)
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .lightGray
        self.addSubview(titleLabel)
        self.addSubview(leftBtn)
        self.addSubview(rightBtn)
    }
    
    override func updateConstraints() {
        leftBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.bottom.equalTo(self).offset(-10)
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
        
        rightBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-10)
            make.bottom.equalTo(self).offset(-10)
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(leftBtn.snp.right).offset(10)
            make.right.equalTo(rightBtn.snp.left).offset(-10)
            make.bottom.equalTo(self).offset(-10)
            make.height.equalTo(30)
        }
        
        
        super.updateConstraints()
    }
    
    override open class var requiresConstraintBasedLayout: Bool {
        get{
            return true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

protocol FMNaviViewProtocol: NSObjectProtocol{
    var naviView: FMNaviView { get }
    
}

