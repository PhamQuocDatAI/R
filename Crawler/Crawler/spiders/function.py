from selenium import webdriver
from selenium.common.exceptions import NoSuchElementException
from selenium.webdriver.common.keys import Keys
import time 
import sys


driver = webdriver.Chrome()

def get_name_brand():
    brand = driver.find_element_by_class_name('txt').text()
    return brand
def get_link_brand():

    pass



def get_name_model():
    pass

def get_link_model():
    pass