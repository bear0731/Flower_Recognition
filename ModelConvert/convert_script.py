import coremltools as ct

# 指定模型結構與權重
core_model = ct.converters.caffe.convert(
    ('oxford102.caffemodel', 'deploy.prototxt'),
    class_labels='flower-labels.txt',  # 類別標籤檔案
    image_input_names='data',  # 這個名稱要對應 prototxt 裡面的 input blob 名稱
    is_bgr=True
)

# 儲存轉換好的模型
core_model.save('FlowerClassifier_convert_Colore.mlmodel')
