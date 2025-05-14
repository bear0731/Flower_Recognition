# Flower Classifier
使用 CoreML、Vision 和 Wikipedia API 的 iOS APP，用來辨識花的種類，並顯示其介紹。

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

