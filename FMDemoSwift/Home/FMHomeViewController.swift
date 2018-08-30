//
//  FMHomeViewController.swift
//  FMDemoSwift
//
//  Created by xiwang wang on 2018/8/29.
//  Copyright © 2018年 com.simon. All rights reserved.
//

import UIKit

class FMHomeViewController: FMBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    let items: Array<String> = ["branks_banner", "member_banner", "stores_banner","cash_banner"]
    
    lazy var tableView: UITableView = {
        let tbv: UITableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height - (tabBarController?.tabBar.height)!), style: .plain)
        return tbv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(FMHomeItemCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(self.tableView)
//        view.backgroundColor = .green
        // Do any additional setup after loading the view.
    }
    
    override func updateViewConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalTo(self.view)
        }
        
        super.updateViewConstraints()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FMHomeItemCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! FMHomeItemCell
        cell.imageName = items[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return (view.height - 64 - 44) / (CGFloat)(items.count)
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
