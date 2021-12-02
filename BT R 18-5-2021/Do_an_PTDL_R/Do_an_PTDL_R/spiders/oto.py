import scrapy
from scrapy.utils.project import get_project_settings
from selenium import webdriver
from selenium.webdriver import Chrome,ChromeOptions
from scrapy_selenium import SeleniumRequest
from selenium.webdriver.common.keys import Keys
import time
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By


class OtoSpider(scrapy.Spider):
    name = 'oto'
    
    # Lấy url 
    def start_requests(self):
        settings = get_project_settings()
        driver_path = settings.get('CHROME_DRIVER_PATH')
        options = ChromeOptions()
        options.headless = True
        driver = Chrome(executable_path=driver_path, options = options)
        driver = webdriver.Chrome()
        driver.get('https://oto.com.vn/mua-ban-xe')
        driver.maximize_window()
        body = driver.find_element_by_css_selector('body')
        # Tìm hết các sản phẩm trong page 
        for i in range(0, 180):
            driver.find_element_by_id('btnloadmore').click()
            time.sleep(2)
        body.send_keys(Keys.END)
        time.sleep(2)
        links = driver.find_elements_by_xpath('//div[@class="info"]/h3/a')
        print(len(links))
        for link in links:
            yield SeleniumRequest(
                url = link.get_attribute('href'),
                wait_time = 3,
                screenshot = True,
                callback = self.parse_products, 
                dont_filter = True)
            

    def parse_products(self, response):
        # Xử lí giá 
        def convert_price(string):  
            t = string.replace(" ","")
            t1 = t.find("tỉ")
            t2 = t.find("triệu")
            t3 = t.find("tr")
            if t1 == -1:
                if t2 == -1:
                    price = int(t[0:t3])*1000000
                else:
                    price = int(t[0:t2])*1000000
            else:
                if t2 == -1:
                    price = int(t[0:t1])*1000000000 + int(t[t1+2:t3])*1000000
                else:
                    price = int(t[0:t1])*1000000000 + int(t[t1+2:t2])*1000000
            return price
        # Xử lí km 
        def convert_km(km):
            string = km.replace(" km","")
            value = int(float(string)*1000)
            return value        
        # Cạo dữ liệu     
        name = response.xpath('//div/h1[@class="title-detail"]/text()').get().strip()
        time_up = response.xpath('//div/span[@class="date"]/text()').get()
        price1 = response.css('span.price-big ::text')[2].get().strip()
        price = convert_price(price1)
        year_product = response.xpath('//ul[@class="list-info"]/li[1]/text()').get().strip()
        style = response.xpath('//ul[@class="list-info"]/li[2]/text()').get().strip()
        status = response.xpath('//ul/li[3]/div/text()').get().strip()
        origin = response.xpath('//ul[@class="list-info"]/li[4]/text()').get().strip()
        # Xử lí xe đã qua sử dụng 
        if status == "Mới":
            KM = 0
            local = response.xpath('//ul/li[5]/div/text()').get().strip()
            box_car = response.xpath('//ul[@class="list-info"]/li[6]/text()').get().strip()
            fuel = response.xpath('//ul[@class="list-info"]/li[7]/text()').get().strip()
        elif status == "Đã qua sử dụng":
            KM1 = response.xpath('//ul[@class="list-info"]/li[5]/text()').get().strip()
            KM = convert_km(KM1)
            local = response.xpath('//ul[@class="list-info"]/li[6]/div/text()').get()
            box_car = response.xpath('//ul[@class="list-info"]/li[7]/text()').get().strip()
            fuel = response.xpath('//ul[@class="list-info"]/li[8]/text()').get().strip()
        # Lưu file
        yield {
            'name': name,
            'time_up': time_up,
            'price': price,
            'year_product': year_product,
            'style': style,
            'status': status,
            'origin': origin,
            'KM' : KM,
            'local': local,
            'box_car': box_car,
            'fuel': fuel}