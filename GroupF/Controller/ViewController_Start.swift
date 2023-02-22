//
//  ViewController_Start.swift
//  GroupF
//
//  Created by 小川　花凜 on 2019/12/06.
//  Copyright © 2019 津覇　翔也. All rights reserved.
//

import UIKit
import FLAnimatedImage

class ViewController_Start: UIViewController {
    
    //背景gif
    @IBOutlet weak var top_gif: FLAnimatedImageView!
    @IBOutlet weak var clk: FLAnimatedImageView!
    //始める背景付きボタン
    @IBOutlet weak var start: UIButton!
    //初手tapでstartボタン
    @IBOutlet weak var tap_start: UIButton!
    //始めるボタン背景
    @IBOutlet weak var img_start: UIImageView!
    
    
    /*
     最初のtapボタンが押された時の処理
     */
    @IBAction func Tap_Start(_ sender: Any) {
        Start_On_Off(index: true)
    }

    
    /*
     tapボタンと始めるボタン、始めるボタン背景を切り替える
     trueでTapOff
     */
    func Start_On_Off(index:Bool){
        if(index == true){
            start.isHidden = false
            img_start.isHidden = false
            tap_start.isHidden = true
        }else{
            start.isHidden = true
            img_start.isHidden = true
            tap_start.isHidden = false
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //初手始める画面非表示
        Start_On_Off(index: false)
        Gif_img(index: "only_main", gif: top_gif)
        Gif_img(index: "clk", gif: clk)

    }

    func Gif_img(index: String, gif:FLAnimatedImageView){
        //gif関連
        let path1 : String = Bundle.main.path(forResource: index, ofType: "gif")!
        let url = URL(fileURLWithPath: path1)
        let gifData = try? Data(contentsOf: url)
        let imageData1 = try? FLAnimatedImage(animatedGIFData: gifData)
        gif.animatedImage = imageData1
    }
}
