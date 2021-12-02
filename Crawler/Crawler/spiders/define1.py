from selenium import webdriver
from selenium.common.exceptions import NoSuchElementException
from selenium.webdriver.common.keys import Keys
import time 
import sys


driver = webdriver.Chrome()
# Lấy link hãng xe -> list 
def get_link_trademark(start_url):
    driver.get(start_url)
    link_trademark = []
    # sub-menu col mgt_30
    col_mgt_30 = driver.find_elements_by_xpath('//ul[@class="sub-menu col mgt_30"]/li/a')
    for i in col_mgt_30[:-1]:
        link_trademark.append(i.get_attribute('href'))
    # sub-menu col
    col = driver.find_elements_by_xpath('//ul[@class="sub-menu col"]/li/a')
    for j in col[10:]:
        link_trademark.append(j.get_attribute('href'))
    return link_trademark    

# Lấy tên hãng xe -> value
def get_name_trademark(url):
    driver.get(url)
    try:
    # //*[@id="filtermodel"]/p/b
        name = driver.find_element_by_xpath('//div[@id="filtermodel"]/p/b').text
    except NoSuchElementException:
        name = ""
    return name

# Lấy link các loại xe trong hãng -> list
def get_link_style_car(url):
    driver.get(url = url)
    # //*[@id="filtermodel"]/ul/li[1]/a[1]
    style_cars = driver.find_elements_by_xpath('//ul[@class="inner-type-brand"]/li/a')
    link_style_car = []
    for i in style_cars:
        link_style_car.append(i.get_attribute('href'))
    return link_style_car

# Lấy tên style car -> list
def get_name_style_car(url):
    driver.get(url)
    name_style = []
    for i in driver.find_elements_by_xpath('//ul[@class="inner-type-brand"]/li/a'):
        name_style.append(i.text)
    return name_style

# Lấy toàn bộ link hãng xe -> list
def full_link_style_car(url):
    list_link = []
    for i in get_link_trademark(url):
        for j in get_link_style_car(i):
            list_link.append(j)
    return list_link

# Link product -> multi list in list
def link_product(url):
    driver.get(url)
    body = driver.find_element_by_css_selector('body')
    count = int(driver.find_element_by_class_name('cl-bl').text)
    if count > 15:
        if count%15 != 0:
            click = count//15
        else:
            click = count//15 - 1
    else:
        click = 0
    for j in range(0, click):
        driver.find_element_by_id('btnloadmore').click()
        driver.implicitly_wait(2)  
    body.send_keys(Keys.END)
    time.sleep(5)    
    list_product = []
    href = driver.find_elements_by_xpath('//div[@class="info"]/h3/a')
    for k in href:
        list_product.append(k.get_attribute('href'))   
    return list_product 