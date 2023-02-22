//
//  ViewController4.swift
//  GroupF
//
//  Created by 津覇　翔也 on 2019/12/05.
//  Copyright © 2019 津覇　翔也. All rights reserved.
//
import UIKit
import FLAnimatedImage

class field4: UIViewController {
    
    //会話画面
    @IBOutlet weak var talk: UIImageView!
    //会話ラベル
    @IBOutlet weak var label_1: UILabel!
    //選択肢ボタン
    @IBOutlet weak var select_1: UIButton!
    //会話開始ボタン
    @IBOutlet weak var talk_start: UIButton!
    //会話終了ボタン
    @IBOutlet weak var talk_finish: UIButton!
    //gif画像view
    @IBOutlet weak var sakuramochi: FLAnimatedImageView!
    
    // セリフ
    var charsA: Array = ["","こんにちは", "何かご用ですか？"]
    //タップ加算用変数
    var tapCount: Int = 0
    
    
    override func viewDidLoad() {
        
        //初手talk_finishボタンと会話画面非表示
        Tap_On_Off(index: true)
        Select_label_On_Off(index: true)
        
        
        super.viewDidLoad()
        
        initImageView()
        Gif_road()

        // Do any additional setup after loading the view.
    }
    
    func Gif_road(){
        //gif表示のための文
        let path1 : String = Bundle.main.path(forResource: "sakuramochi", ofType: "gif")!
        let url = URL(fileURLWithPath: path1)
        let gifData = try? Data(contentsOf: url)
        let imageData1 = try? FLAnimatedImage(animatedGIFData: gifData)
        sakuramochi.animatedImage = imageData1
    }
    
    /*
     タップされたら会話を始める
     */
    @IBAction func Talk_Start(_ sender: Any) {
        // タップ回数を加算
        tapCount+=1
        
        if(tapCount > 0){
            // タップ回数に応じた文字に更新
            updateCharacters(index: tapCount)
            label_1.isHidden = false
            talk.isHidden = false
        //選択肢ボタンの表示
        if (tapCount == 2){
            //select on
            Select_ON_Off(index: false)
            //finish表示
            Tap_On_Off (index: false)
            }
        }
    }
    
    /*
     会話が限界になったら現れる
     タップされたら会話画面をしまう
     */
    @IBAction func Talk_finish(_ sender: Any) {
        Tap_On_Off (index: true)
        tapCount = 0
        Select_label_On_Off(index: true)
    }
    
    // 文字のアップデート
    func updateCharacters(index: Int) {
      label_1.text = charsA[index]
    }
    
    /*
     選択肢文のOnOff切り替え
     */
    func Select_ON_Off (index: Bool){
        //trueが非表示
        if (index == true){
            select_1.isHidden = true
        }else{
            select_1.isHidden = false
        }
    }
    
    /*
     talk_startボタンとtalk_finishボタンを切り替える
     */
    func Tap_On_Off (index: Bool){
        //trueでfinishが非表示
        if (index == true){
            talk_start.isHidden = false
            talk_finish.isHidden = true
        }else{
            talk_start.isHidden = true
            talk_finish.isHidden = false
        }
    }
    
    /*
     選択肢文、会話文、会話画面の表示非表示切り替え
     */
    func Select_label_On_Off (index:Bool){
        if(index == true){
            Select_ON_Off(index: true)
            label_1.isHidden = true
            talk.isHidden = true
        }else{
            Select_ON_Off(index: false)
            label_1.isHidden = false
            talk.isHidden = false
        }
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
