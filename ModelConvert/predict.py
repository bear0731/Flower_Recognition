import coremltools as ct
from PIL import Image

# 載入已轉換好的 CoreML 模型
model = ct.models.MLModel("FlowerClassifier.mlmodel")

# 載入圖片並處理成模型可接受格式（224x224）
image = Image.open("rose.jpg").convert("RGB")
image = image.resize((227, 227))



# 準備輸入字典（key 名稱要與模型 input 名稱對應）
# 若你轉換模型時 image_input_names='data'，就要用 'data'
spec = model.get_spec()
print(spec)
print(spec.description.input[0].type.imageType.colorSpace)
input_name = spec.description.input[0].name  # ← 這才是輸入名稱

# input_data = {input_name: image}

# # 執行推論
# result = model.predict(input_data)

# # 顯示預測結果
# print("預測類別：", result.get("classLabel"))
# print("前幾名預測：")
# for label, prob in sorted(result["probabilities"].items(), key=lambda x: -x[1])[:5]:
#     print(f"{label}: {prob:.4f}")
