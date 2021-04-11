# -*- coding: utf-8 -*-
# Copyright 2016 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# [START app]
import logging

# [START imports]
from flask import Flask, render_template, request, jsonify
# [END imports]
# 
from bs4 import BeautifulSoup
import urllib
import re 
from flask_cors import CORS, cross_origin

# [START create_app]
app = Flask(__name__)
cors = CORS(app)
app.config['CORS_HEADERS'] = 'Content-Type'
# [END create_app]
# 
def getsoup (address):
    getRequest = urllib.request.Request(address, None, {'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:54.0) Gecko/20100101 Firefox/54.0'})

    urlfile = urllib.request.urlopen(getRequest)
    htmlResult = urlfile.read(20000000)
    urlfile.close()
    
    return BeautifulSoup(htmlResult)

def getmenu(addr):
    soup = getsoup(addr)
    
    isweird = False

    names = soup.findAll('td', class_="column-1")
    
    prices = soup.findAll('td', class_="column-3")
    
    if len(prices)==0:
        
        isweird = True
        prices = soup.findAll('td', class_="column-2")


    menu = []

    for i in range(0,len(prices)):
        if names[i].findAll('h2') == []:
            menu.append({'item':names[i].text, 'price':prices[i].text})
        elif names[i].findAll('b') is not []:
            try:
                menu.append({'item':names[i].find('b').text, 'price':prices[i].find('span') .text})
            except:
                ""
    return menu

@app.route('/get_menu_data', methods=['GET'])
@cross_origin()
def get_menu_data():
    args = request.args
    url = args['url']
    menudata = {}
    
    menudata['items'] = getmenu(url)
    print(menudata)
    
    
    return menudata

@app.errorhandler(500)
def server_error(e):
    # Log the error and stacktrace.
    logging.exception('An error occurred during a request.')
    return 'An internal error occurred.', 500

if __name__=="__main__":
    # For local development:
    #app.run(debug=True)
    # For public web serving:
    app.run(host='0.0.0.0', port=8080, debug=True)
# [END app]

