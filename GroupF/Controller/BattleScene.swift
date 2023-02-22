//
// ViewController.swift
// Software_exp
//
// Created by Shinto Higa on 2019/11/21.
// Copyright © 2019 Shinto Higa. All rights reserved.
//
import UIKit
import AVFoundation
import Foundation
import SwiftyJSON
class BattleScene: UIViewController,AVAudioPlayerDelegate{
   
  let url = URL(string: "https://ie.u-ryukyu.ac.jp/~e185715/quiz_data.json")
   
  var audioPlayer = player() //まるバツのSEのプレイヤー
  var bgm = player() //BGMのプレイヤー
   
  //選択肢をランダム配置するための変数と配列
  var swap_num:Int = 0
  var space:Int = 0
  var four:[Int] = [1,2,3,4]
  var choose_question = 0 //どの問題を出すかランダムで選ぶための変数
  var correct:Int = 0 //正解のボタンを判別するための変数
  var numQuestion:Int = 0 //今何問めか数えてくれる。
  var numClear:Int = 0 //何問正解したか数えてくれる。
  var before:Int = 100 //、同じ問題を連続して出さないために、問題文インデックス番号を保存し比較
   
  //[n]番目の問題文とその選択肢。正解は各選択肢配列の先頭に置いているとうまくいく。
  var question_sentences:[String] = []
  var choices_sentences:[[String]] = [[]]
   
  //選択肢をランダムに配置するためのInt:four[]をシャッフル
  func shuffle(){
    for i in 1...20{
      swap_num = Int.random(in: 0..<3)
      space=four[swap_num+1]
      four[swap_num+1]=four[swap_num]
      four[swap_num]=space
    }
  }
   
  //シャッフルした番号をも選択肢のインデックス番号とし、1番目のボタンから選択肢を配置
  func setting(){
    choose_question = Int.random(in:0..<4)
    if before == choose_question{
      setting()
    } else {
      question_text.text = question_sentences[choose_question]
      first.text = choices_sentences[choose_question+1][four[0]-1]
      second.text = choices_sentences[choose_question+1][four[1]-1]
      third.text = choices_sentences[choose_question+1][four[2]-1]
      fourth.text = choices_sentences[choose_question+1][four[3]-1]
    correct = four.firstIndex(of: 1)! //正解はfour[]の1が入っている場所を正解を判別する番号として保存
    before = choose_question //現在の問題のインデックス番号を保存し、連続で同じ問題を出させない
    }
  }
   
  //◯、×を表示している間、ボタンを押しても何もしないようにする
  func dont_touch(){
    ONE.isEnabled = false
    TWO.isEnabled = false
    THREE.isEnabled = false
    FOUR.isEnabled = false
  }
   
  //dont_touch()のあと、ボタンを押せるようにする
  func please_touch(){
    ONE.isEnabled = true
    TWO.isEnabled = true
    THREE.isEnabled = true
    FOUR.isEnabled = true
  }
   
  //答えた後にまるバツとそのSEを再生、正解数のカウント
  func judgement(intValue:Int){
    if (correct == intValue){
      audioPlayer.playSound(name:"Quiz-Buzzer01-1")
      print(String(intValue+1)+":正解")
      let judgement = UIImage(named: "Circle")
      QuizJudge.image=judgement
      numClear += 1
    } else {
      audioPlayer.playSound(name:"Quiz-Wrong_Buzzer02-2")
        print("Not",String(intValue+1),",correct is", String(correct+1),":",String(choices_sentences[choose_question][0]))
      let judgement = UIImage(named: "Cross")
      QuizJudge.image=judgement
    }
    self.dont_touch()
    DispatchQueue.main.asyncAfter(deadline : DispatchTime.now() + 2.0){
      self.please_touch()
      self.next_question()
    }
  }
   
  func next_question(){
    self.QuizJudge.image=nil //丸ばつを表示した次の問題に遷移するとき、丸ばつ画像を消す
    if (numQuestion<=4){
      shuffle()
      setting()
      numQuestion += 1
      print(numQuestion)
        numQuest.text = "問題"+String(numQuestion)
    } else{
      numQuest.text = nil
      self.dont_touch()
        question_text.text = "正解数 "+String(numClear)
      DispatchQueue.main.asyncAfter(deadline : DispatchTime.now() + 2.0){
        if (self.numClear >= 3){
          self.question_text.text = ("ノルマクリアだ！")
           
        } else {
          self.question_text.text = ("ノルマクリア失敗")
        }
      DispatchQueue.main.asyncAfter(deadline : DispatchTime.now() + 2.0){
        self.bgm.stopBGM()
        self.performSegue(withIdentifier:"finish",sender:nil)
        }
      }
    }
  }
   
  @IBOutlet weak var enemy: UIImageView! //敵の画像を貼る場所アウトレット
  @IBOutlet weak var question_text: UITextView! //問題文を貼るアウトレット
   
  //ボタン番号は左上、右上、左下、右下の順に1,2,3,4とする。
  //ボタンを押した後、そのボタン番号とcorrectが一致すれば◯を表示、そうでないなら×
  //回答の2秒後に次の問題に移る
   
  //左上ボタン
  @IBOutlet weak var ONE: UIButton!
  @IBAction func button_one(_ sender: Any) {
    self.judgement(intValue: 0)
  }
  @IBOutlet weak var first: UILabel!
   
  //右上ボタン
  @IBOutlet weak var TWO: UIButton!
  @IBAction func button_two(_ sender: Any) {
    self.judgement(intValue: 1)
}
  @IBOutlet weak var second: UILabel!
   
  //左下ボタン
  @IBOutlet weak var THREE: UIButton!
  @IBAction func button_three(_ sender: Any) {
    self.judgement(intValue: 2)
}
  @IBOutlet weak var third: UILabel!
   
  //右下ボタン
  @IBOutlet weak var FOUR: UIButton!
  @IBAction func button_four(_ sender: Any) {
    self.judgement(intValue: 3)
  }
  @IBOutlet weak var fourth: UILabel!
   
  @IBOutlet weak var QuizJudge: UIImageView! //丸ばつ画像のアウトレット
   
  @IBOutlet weak var numQuest: UILabel! //問題数を数えているアウトレット
   
  func json(){
    URLSession.shared.dataTask(with: url!) { (data, response, error) in
    guard let data = data else {return}
      for i in 0..<4{
    do {
      let json = try? JSON(data: data)
      let jsonData = json!
      var quiz = jsonData["0_python"]["sentence"][i].description
      self.question_sentences.append(quiz)
      var new_choices:String = jsonData["0_python"]["choices"][i].description
      new_choices = new_choices.replacingOccurrences(of: "\n", with: "")
      new_choices = new_choices.replacingOccurrences(of: "[", with: "")
      new_choices = new_choices.replacingOccurrences(of: "]", with: "")
      var Array = [new_choices.components(separatedBy:",")]
      self.choices_sentences += Array
    } catch let jsonError{
      print("jsonError", jsonError)
    }
    }
    }.resume()
     
  }
   
   
  override func viewDidLoad() {
    super.viewDidLoad()
    
    json()
    
    
//    self.choices_sentences.swapAt(0,1)
//    self.choices_sentences.swapAt(1,2)
//    self.choices_sentences.swapAt(2,3)
//    self.choices_sentences.swapAt(3,4)
    
    bgm.playBGM(name:"battlesound")
    question_text.isUserInteractionEnabled = false //問題文の編集禁止
    question_text.isEditable = false
    let image = UIImage(named: "Enemy_image") //敵画像の挿入
    enemy.image=image
    self.next_question()
  }
}
class player{
  var audioPlayer: AVAudioPlayer!
  var BGM: AVAudioPlayer!
  func playSound(name: String) {
    guard let path = Bundle.main.path(forResource: name, ofType: "mp3") else {
        print("音源ファイルが見つかりません")
      return
    }
    do {
      // AVAudioPlayerのインスタンス化
      audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
      // AVAudioPlayerのデリゲートをセット
      audioPlayer.delegate = self as? AVAudioPlayerDelegate
      // 音声の再生
      audioPlayer.play()
    } catch {
    }
  }
  func playBGM(name: String) {
    guard let path = Bundle.main.path(forResource: name, ofType: "mp3") else {
        print("音源ファイルが見つかりません")
      return
    }
    do {
      // AVAudioPlayerのインスタンス化
      BGM = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
      // AVAudioPlayerのデリゲートをセット
      BGM.delegate = self as? AVAudioPlayerDelegate
      BGM.numberOfLoops = -1
      // 音声の再生
      BGM.play()
    } catch {
    }
  }
  func stopBGM(){
    self.BGM.stop()
  }
}
