//
//  HomeViewController.swift
//  Runner
//
//  Created by dujianjie on 2023/2/17.
//
import Flutter
import level_channel
import Foundation

class HomeViewController: FlutterViewController {
    private var channel: LevelChannelManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customInit()
        
        setFlutterViewDidRenderCallback { [weak self] in
            self?.flutterInitDone()
        }
    }
    
    func flutterInitDone() {
        channel?.post("/flutter/show", parameters: ["hello": "world", "boll": true, "num": 123, "double":123.87])
        channel?.get("/flutter/get", parameters: ["get": "shau"], callback: { paras in
            print(paras ?? "null")
        })
    }
    
    func customInit() {
        channel = valuePublished(byPlugin: "LevelChannelPlugin") as? LevelChannelManager
        
        channel?.addPostObserver("/navtive/show", callback: { paras in
            print(paras ?? "null")
        })
        
        channel?.addGetObserver("/navtive/get", callback: { paras, result in
            print(paras ?? "null")
            result(["Navite get Observet": true])
        })
    }
    
    deinit {
        channel?.removePostObserver("/navtive/show")
        channel?.removeGetObserver("/navtive/get")
    }
}
