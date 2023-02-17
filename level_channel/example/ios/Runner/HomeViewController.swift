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
        channel = valuePublished(byPlugin: "LevelChannelPlugin") as? LevelChannelManager
        
        channel?.addPostObserver("test", callback: { paras in
            debugPrint(paras ?? "null")
        })
    }
}
