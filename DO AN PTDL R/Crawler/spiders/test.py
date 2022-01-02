from selenium import webdriver
from selenium.common.exceptions import NoSuchElementException
from selenium.webdriver.common.keys import Keys
import time 
import sys


driver = webdriver.Chrome()
url = 'https://oto.com.vn/mua-ban-xe'
driver.get(url)
search_box = driver.find_element_by_xpath('//div[@tabtype="2"]/div/div/div/input[@placeholder="Tìm hãng"]')
search_box.send_keys("Mercedes-Benz")
time.sleep(5)
