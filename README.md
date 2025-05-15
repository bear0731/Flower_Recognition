# Flower Classifier
使用 CoreML、Vision 和 Wikipedia API 的 iOS APP，用來辨識花的種類，並顯示其介紹。
## 檔案分類
ModelConvert：模型轉換腳本  
Whatflower：iOS 主程式
## 功能簡介
- 使用相機拍攝花朵
- 使用 Python coremltools 將 Caffe Model 轉換成 CoreML Model 辨識花種
- 向 Wikipedia API 查詢該花的介紹並顯示在畫面上
- 顯示使用者拍攝的花朵圖片和相關文字資訊

## 技術與框架
- Swift（Storyboard）
- UIKit：UI 元件與事件處理
- CoreML：載入並使用訓練好的機器學習模型
- Vision：進行圖片辨識與 CoreML 模型的接合
- Alamofire：網路請求框架，簡化 HTTP API 操作
- SwiftyJSON：輕鬆解析 JSON 格式資料
- Wikipedia API：獲取花朵相關文字介紹與縮圖

## 流程
1. 使用者點選拍照按鈕，開啟相機。
2. 顯示照片
3. 將圖片轉換為 CIImage 格式
4. 呼叫 CoreML 模型辨識花種
5. 模型辨識出花名後，發送請求到 Wikipedia API 抓取該花的資訊與縮圖。

## 挑戰與解方
1. Python Coremltoolts 已不支援 Caffe 轉換：退回 python 3.6 版本使用套件。
2. 模型預測不準確：Vision 的自動處理有限，不會 resize 或 normalize 圖片，需要自己處理。
3. 起初模型將紅色花預測成藍色花，後來發現原因是 Caffe 默認照片為 BGR 通道，而不是一般照片的 RGB。因此後來在 Coremltools 將 Caffe 轉換成 mlmodel 的參數設定 is_bgr = True。
4. 模型將花貼標時，使用的是通俗名稱，會導致少部分 wiki 抓不到資料，因此在模型輸出後使用 switch 將名稱轉換。

## demo
![demo1](Demo/demo.gif)
![demo2](Demo/tiger_lily.jpg)
![demo3](Demo/Rose.jpg)

