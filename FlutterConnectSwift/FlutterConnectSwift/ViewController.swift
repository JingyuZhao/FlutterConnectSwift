//
//  ViewController.swift
//  FlutterConnectSwift
//
//  Created by zhaojingyu on 2019/11/27.
//  Copyright © 2019 zhaojingyu. All rights reserved.
//

import UIKit
import SnapKit
import Flutter

class ViewController: UIViewController {

    var eventSkin : FlutterEventSink?
    var click = 0
    
    lazy var callFlutter : UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("调用Flutter", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(callFlutterAction), for: .touchUpInside)
        return button;
    }()
    
    let flutterVC = FlutterViewController.init()

    
    let flutterMethodChannelKey = "com.flutterConnectApp.method"
    let flutterEventChannelKey = "com.flutterConnectApp.event"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        conficUI()
    }
    func conficUI() {
        self.view.addSubview(callFlutter)
        callFlutter.snp.makeConstraints {
            $0.size.equalTo(CGSize.init(width: 100, height: 30))
            $0.center.equalToSuperview()
        }
        
        let rightNav = UIBarButtonItem.init(title: "点击", style: .done, target: self, action: #selector(swiftCallFlutter));
        flutterVC.navigationItem.rightBarButtonItem = rightNav
        
    }

    @objc func callFlutterAction(){
        print("callFultter")
        flutterVC.navigationItem.title = "Flutter Page"
        flutterVC.setInitialRoute("/")
        let eventChannel = FlutterEventChannel.init(name: flutterEventChannelKey, binaryMessenger: flutterVC.binaryMessenger)
        eventChannel.setStreamHandler(self)
        
        let methodChannel = FlutterMethodChannel.init(name: flutterMethodChannelKey, binaryMessenger: flutterVC.binaryMessenger)
        methodChannel.setMethodCallHandler {[weak self](call, result) in
            print("callMethod:\(call.method) paramter:\(call.arguments ?? "null")")
            switch call.method {
            case "goTestVC":
                result("I come from Swfit!")
            case "callFlutter":
                let test1 = Test1ViewController.init()
                self?.navigationController?.pushViewController(test1, animated: true)
                result("I come from Swfit! \(call.method)")
            default:
                print("null")
            }
        }
        self.navigationController?.pushViewController(flutterVC, animated: true)
    }
    
   @objc func swiftCallFlutter() {
        self.eventSkin?("点击啦\(click)")
        click += 1
    }
}
extension ViewController : FlutterStreamHandler{
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        print(arguments ?? "null")
        self.eventSkin = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        return nil
    }
    
}
