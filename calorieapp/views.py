from django.shortcuts import render,redirect
from django.contrib.auth import authenticate,login,logout
from django.contrib.auth.decorators import login_required
from calorieapp.models import *
from django.contrib import messages


import os
from PIL import Image
import numpy as np

from tensorflow.keras.preprocessing.image import load_img, img_to_array
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


import requests

def fetch_calories(food_item):
    app_id = 'ec84d4c5'     # Replace with your actual App ID
    app_key = '9592a47489959bff2ef847263629aa92'   # Replace with your actual App Key

    url = "https://trackapi.nutritionix.com/v2/natural/nutrients"
    headers = {
        "x-app-id": app_id,
        "x-app-key": app_key,
        "Content-Type": "application/json"
    }

    data = {
        "query": food_item,
        "timezone": "US/Eastern"  # or just keep it default
    }

    response = requests.post(url, headers=headers, json=data)

    if response.status_code == 200:
        result = response.json()
        calories = result['foods'][0]['nf_calories']
        return f"{calories} calories"
    else:
        print("Error:", response.status_code)
        print(response.text)
        return "Error fetching calories"



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


def home(request):
    return render(request,'index.html')


def about(request):
    return render(request,'about.html')

def user_login(request):
    if request.method == 'POST':

        email = request.POST.get('email')
        password = request.POST.get('password')
        user = authenticate(request,email=email,password=password)
        if user is not None:
            login(request,user)
            messages.success(request,'Login Successfull')
            
            return redirect('dashboard')
        else:
            messages.error(request,'Invalid Credentials')

            print('invalid credentials')
            return redirect('home')
        

def user_register(request):
    if request.method == 'POST':
        email = request.POST.get('email')
        passord = request.POST.get('password')
        name = request.POST.get('name')
        contact = request.POST.get('contact')
        pic = request.FILES.get('pic')
        user = MyUser.objects.create_user(email=email,password=passord)
        user.name = name
        user.contact = contact
        user.pic = pic
        user.save()
        messages.success(request,'Registration Successfull')

        print('registration successfull login')
        return redirect('home')


def contact(request):
    return render(request,'contact.html')

@login_required(login_url='home')
def dashboard(request):
    if request.method == 'POST':
        img = request.FILES.get('img')
        p = prediction.objects.create(img=img, user=request.user)

        upload_path = f"media/{p.img}"
        print("Image uploaded successfully!", upload_path)

        result = processed_img(upload_path)
        cal = fetch_calories(result)

        output = {"prediction": result}
        if cal:
            output["calories"] = cal  # Add calories info to output

        print("Output:", output)
        messages.success(request, 'Prediction Successful')

        return redirect('predict', p.pk)

    return render(request, 'dashboard.html')

@login_required(login_url='home')
def predict(request, id):
    p = prediction.objects.get(pid=id)
    upload_path = f"media/{p.img}"

    print("Image uploaded successfully!", upload_path)

    result = processed_img(upload_path)
    cal = fetch_calories(result)

    output = {"prediction": result}
    if cal:
        output["calories"] = cal  # Pass calories info to template

    print("Output:", output)
    return render(request, 'predict.html', {'pimg': p, 'result': output})
    

@login_required(login_url='home')
def myprofile(request):
    user = MyUser.objects.get(email = request.user)
    
    if request.method == 'POST':
        name = request.POST.get('name')
        contact = request.POST.get('contact')
        pic = request.FILES.get('pic')
        user.name = name
        user.contact = contact
        if pic:
            user.pic = pic
        user.save()
        messages.success(request,'Profile Updated!!!')

    return render(request,'myprofile.html',{'use':user})

