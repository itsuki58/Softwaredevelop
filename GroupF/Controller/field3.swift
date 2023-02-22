//
//  ViewController3.swift
//  GroupF
//
//  Created by 津覇　翔也 on 2019/12/05.
//  Copyright © 2019 津覇　翔也. All rights reserved.
//

import UIKit

class field3: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initImageView()
        // Do any additional setup after loading the view.
    }
    
    private func initImageView(){
        let image1:UIImage = UIImage(named:"草")!
        
        // UIImageView 初期化
        let imageView = UIImageView(image:image1)
        
        // スクリーンの縦横サイズを取得
        let screenWidth:CGFloat = view.frame.size.width
        let screenHeight:CGFloat = view.frame.size.height
        
        // 画像の縦横サイズを取得
        let imgWidth:CGFloat = image1.size.width
        let imgHeight:CGFloat = image1.size.height
        
        // 画像サイズをスクリーン幅に合わせる
        let scale:CGFloat = screenWidth / imgWidth
        let rect:CGRect =
            CGRect(x:0, y:0, width:imgWidth*scale, height:imgHeight*scale)
        
        // ImageView frame をCGRectで作った矩形に合わせる
        imageView.frame = rect;
        
        // 画像の中心を画面の中心に設定
        imageView.center = CGPoint(x:screenWidth/2, y:screenHeight/2)
        
        // UIImageViewのインスタンスをビューに追加
        self.view.addSubview(imageView)
        
        self.view.sendSubviewToBack(imageView)
        
        
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
