import scrapy
from scrapy.utils.project import get_project_settings
from selenium import webdriver
from selenium.common.exceptions import NoSuchElementException
from selenium.webdriver import Chrome,ChromeOptions
from scrapy_selenium import SeleniumRequest
from selenium.webdriver.common.keys import Keys
import time
from ..spiders import define1


url = 'https://oto.com.vn/mua-ban-xe'
# Get link trademark
link_trade = define1.get_link_trademark(url)
# Get name trademark, link style, name style, link product
name_trade = []
link_style = []
name_style = []
for i in link_trade:
    for j in define1.get_name_style_car(i):
        name_style.append(j)
    name_trade.append(define1.get_name_trademark(i))
    for k in define1.get_link_style_car(i):
        link_style.append(k)


class Demo1Spider(scrapy.Spider):
    name = 'demo1'

    def start_requests(self):
        settings = get_project_settings()
        driver_path = settings.get('CHROME_DRIVER_PATH')
        options = ChromeOptions()
        options.headless = True
        driver = Chrome(executable_path=driver_path, options = options)
        driver = webdriver.Chrome()
        link_product = []
        # Có 669 link style
        # 200-250 chạy lại 
        for i in link_style:
            driver.get(i)
            body = driver.find_element_by_css_selector('body')
            count1 = driver.find_element_by_class_name('cl-bl').text
            # Xử lí count > 1000 (count = 1,xxx)
            if ',' in count1:
                count = int(count1.replace(",",""))
            else:
                count = int(count1)
            # Click
            if count >= 15:
                if count%15 != 0:
                    click = count//15
                else:
                    click = count//15 - 1
            else:
                click = 0
            for j in range(0, click):
                driver.find_element_by_id('btnloadmore').click()
                driver.implicitly_wait(2) # -> duyệt nhanh hơn 
                # time.sleep(5)
            body.send_keys(Keys.END)
            time.sleep(5)
            href = driver.find_elements_by_xpath('//div[@class="info"]/h3/a')
            for k in href:
                link_product.append(k.get_attribute('href'))
        for product in link_product:
            yield SeleniumRequest(
                url = product,
                wait_time = 3,
                screenshot = True,
                callback = self.parse_product, 
                dont_filter = True)

    def parse_product(self, response):
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
        # Trademark
        for i in name_trade:
            a = name.find(i)
            if a == 0:
                trade = i
                break
        for j in name_style:
            b = name.find(j)
            if b > 0:
                brand = j
                break                
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
            'trademark': trade,
            'brand': brand,
            'time_up': time_up,
            'price': price,
            'year_product': year_product,
            'style': style,
            'status': status,
            'origin': origin,
            'KM' : KM,
            'local': local,
            'box_car': box_car,
            'fuel': fuel,
        }