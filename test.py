
import os
from PIL import Image
import numpy as np

from tensorflow.keras.preprocessing.image import load_img
from tensorflow.keras.preprocessing.image import img_to_array
from keras.models import load_model
import requests
from bs4 import BeautifulSoup
from IPython.display import display
import ipywidgets as widgets
import uuid

model = load_model("FV.h5")
labels = {0: 'apple', 1: 'banana', 2: 'beetroot', 3: 'bell pepper', 4: 'cabbage', 5: 'capsicum', 6: 'carrot',
          7: 'cauliflower', 8: 'chilli pepper', 9: 'corn', 10: 'cucumber', 11: 'eggplant', 12: 'garlic', 13: 'ginger',
          14: 'grapes', 15: 'jalepeno', 16: 'kiwi', 17: 'lemon', 18: 'lettuce',
          19: 'mango', 20: 'onion', 21: 'orange', 22: 'paprika', 23: 'pear', 24: 'peas', 25: 'pineapple',
          26: 'pomegranate', 27: 'potato', 28: 'raddish', 29: 'soy beans', 30: 'spinach', 31: 'sweetcorn',
          32: 'sweetpotato', 33: 'tomato', 34: 'turnip', 35: 'watermelon'}

fruits = ['Apple', 'Banana', 'Bello Pepper', 'Chilli Pepper', 'Grapes', 'Jalepeno', 'Kiwi', 'Lemon', 'Mango', 'Orange',
          'Paprika', 'Pear', 'Pineapple', 'Pomegranate', 'Watermelon']
vegetables = ['Beetroot', 'Cabbage', 'Capsicum', 'Carrot', 'Cauliflower', 'Corn', 'Cucumber', 'Eggplant', 'Ginger',
              'Lettuce', 'Onion', 'Peas', 'Potato', 'Raddish', 'Soy Beans', 'Spinach', 'Sweetcorn', 'Sweetpotato',
              'Tomato', 'Turnip']


def fetch_calories(prediction):
    try:
        url = 'https://www.google.com/search?&q=calories in ' + prediction
        req = requests.get(url).text
        scrap = BeautifulSoup(req, 'html.parser')
        calories = scrap.find("div", class_="BNeawe iBp4i AP7Wnd")
        if calories:
            return calories.text
        else:
            return "Calories not found"
    except Exception as e:
        print("Can't able to fetch the Calories")
        print(e)


def processed_img(img_path):
    img = load_img(img_path, target_size=(224, 224, 3))
    img = img_to_array(img)
    img = img / 255
    img = np.expand_dims(img, [0])
    answer = model.predict(img)
    y_class = answer.argmax(axis=-1)
    print(y_class)
    y = " ".join(str(x) for x in y_class)
    y = int(y)
    res = labels[y]
    print(res)
    return res.capitalize()


def on_upload_button_clicked(b):
    # upload_path = os.path.join('upload_images', str(uuid.uuid4()) + '.png')
    # os.makedirs(os.path.dirname(upload_path), exist_ok=True)  # Create the directory if it doesn't exist
    # with open(upload_path, 'wb') as f:
    #     f.write(upload_widget.data[-1])
    upload_path = "image_3.jpg"
    print("Image uploaded successfully!")

    result = processed_img(upload_path)
    print(result)
    if result in vegetables:
        print('Category: Vegetables')
    else:
        print('Category: Fruit')
    print("Predicted: " + result)
    cal = fetch_calories(result)

    output = {"prediction": result}
    if cal:
        output["calories"] = cal

    print("Output:", output)
    return 'working'


# upload_widget = widgets.FileUpload(accept='image/*')
# upload_button = widgets.Button(description='Upload Image')
# upload_button.on_click(on_upload_button_clicked)

# display(upload_widget, upload_button)
print(on_upload_button_clicked(1))