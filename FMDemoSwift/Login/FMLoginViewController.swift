//
//  FMLoginViewController.swift
//  FMDemoSwift
//
//  Created by xiwang wang on 2018/8/23.
//  Copyright © 2018年 com.simon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire
import SwiftyJSON
import SVProgressHUD



class FMLoginViewController: FMBaseViewController {
    
    let disposeBag = DisposeBag()
    
    let logoImageView: UIImageView = UIImageView(image: #imageLiteral(resourceName: "小logo"))
    
    lazy var userNameTF: SMAnimationTextField = {
        let textField = SMAnimationTextField(frame: .zero)
        textField.placeholder = "账号名称"
        textField.delegate = self
        return textField
    }()
    
    lazy var passwordTF: SMAnimationTextField = {
        let textField = SMAnimationTextField(frame: .zero)
        textField.placeholder = "密码"
        textField.delegate = self
        return textField
    }()
    
    lazy var forgetPasswordBtn: UIButton = {
        let btn = UIButton()
        
        btn.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { () in
            print("forget password action")
            let resetPwdVC: FMResetPasswordViewController = FMResetPasswordViewController()
            self.present(resetPwdVC, animated: true, completion: nil)
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
        btn.setTitle("忘记密码", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 15)
        btn.setTitleColor(SMColor(r: 47, g:187, b:200, a: 1.0), for: .normal)
        return btn
    }()
    
    lazy var loginBtn: UIButton = {
        let btn = UIButton()
        
        btn.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { () in
            print("login action")
            self.loginAction(success: { (result) in
                if result {
                    SVProgressHUD.showSuccess(withStatus: "登录成功")
                    print("request successed")
                    let mainVC: FMMainViewController = FMMainViewController()
                    self.present(mainVC, animated: true, completion: {
                        SVProgressHUD.dismiss()
                    })
                    
                    
                } else {
                    SVProgressHUD.showError(withStatus: "登录失败")
                }
             })
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
        btn.setTitle("登录", for:.normal)
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
        
        createUI()
    }
    
    private func createUI() {
        view.addSubview(logoImageView)
        view.addSubview(userNameTF)
        view.addSubview(passwordTF)
        view.addSubview(forgetPasswordBtn)
        view.addSubview(loginBtn)
        
        userNameTF.text = "1";
        passwordTF.text = "test02";
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    override func updateViewConstraints() {
        
        logoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(64)
            make.width.height.equalTo(56)
            make.centerX.equalTo(self.view)
        }
        
        userNameTF.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.top.equalTo(logoImageView.snp.bottom).offset(30)
            make.height.equalTo(50)
        }
        
        passwordTF.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.top.equalTo(userNameTF.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        
        forgetPasswordBtn.snp.makeConstraints { (make) in
            make.width.equalTo(120)
            make.height.equalTo(44)
            make.top.equalTo(passwordTF.snp.bottom).offset(10)
            make.right.equalTo(-30)
        }
        
        loginBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(80)
            make.right.equalTo(self.view.snp.right).offset(-80)
            make.height.equalTo(40)
            make.top.equalTo(forgetPasswordBtn.snp.bottom).offset(30)
        }
 
        super.updateViewConstraints()
    }
    
    func loginAction(success: @escaping (Bool) ->()) {
        let url: String = BASE_URL + "/employees/" + userNameTF.text!
        Alamofire.request(url, method: .get, parameters: nil, encoding:URLEncoding.default, headers: nil).responseData { (response) in
            if let data = response.result.value {
                let json = JSON(data)
                print(json)
                if json["password"].string == self.passwordTF.text {
                    success(true)
                    return
                } else {
                    success(false)
                    return
                }
            } else {
                success(false)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension FMLoginViewController : SMAnimationTextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: SMAnimationTextField) -> Bool {
        return true
    }

    func textFieldDidBeginEditing(_ textField: SMAnimationTextField) {

    }
    
}
