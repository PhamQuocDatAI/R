import scrapy
from scrapy.utils.project import get_project_settings
from selenium import webdriver
from selenium.webdriver import Chrome,ChromeOptions
from ..items import CrawlerItem
from scrapy_selenium import SeleniumRequest
from selenium.webdriver.common.keys import Keys
import time


class YoutubeSpider(scrapy.Spider):
    name = 'youtube'

    def start_requests(self):
        settings = get_project_settings()
        driver_path = settings.get('CHROME_DRIVER_PATH')
        options = ChromeOptions()
        options.headless = True
        driver = Chrome(executable_path=driver_path, options = options)
        driver = webdriver.Chrome()
        driver.get('https://www.youtube.com/channel/UC5UlfEOSpZ3ArUkNrlA8pQg/videos')
        driver.maximize_window()
        # Cuộn trang xuống để lấy nhiều video hơn 
        body = driver.find_element_by_css_selector('body')
        for x in range(0, 10):
            body.send_keys(Keys.PAGE_DOWN)
        time.sleep(5)
        list_links = driver.find_elements_by_xpath('//h3/a[@class = "yt-simple-endpoint style-scope ytd-grid-video-renderer"]')
        for links in list_links:
            yield SeleniumRequest(
                url = links.get_attribute('href'),
                wait_time = 3,
                screenshot = True,
                callback = self.parse, 
                dont_filter = True    
        )
    def parse(self, response):
        # name
        # <yt-formatted-string force-default-style="" class="style-scope ytd-video-primary-info-renderer">Khuyến mại SỐC, đi mua xe máy Honda, nhận ngay 5 triệu tiền mặt |Autodaily.vn|</yt-formatted-string>
        name = response.xpath('//h1/yt-formatted-string/text()').get()
        # url
        # <a id="video-title" class="yt-simple-endpoint style-scope ytd-grid-video-renderer" aria-label="Trải nghiệm chi tiết Land Rover Discovery 2022 - Những thay đổi hấp dẫn |Autodaily.vn| của Autodaily.vn 1 ngày trước 23 phút 16.081 lượt xem" title="Trải nghiệm chi tiết Land Rover Discovery 2022 - Những thay đổi hấp dẫn |Autodaily.vn|" href="/watch?v=L5OxBY2Z9QY">Trải nghiệm chi tiết Land Rover Discovery 2022 - Những thay đổi hấp dẫn |Autodaily.vn|</a>
        url = response.xpath('//h3/a[@href]').get()
        # like
        # <yt-formatted-string id="text" class="style-scope ytd-toggle-button-renderer style-text" aria-label="306 lượt thích">306</yt-formatted-string>
        like = response.xpath('//a/yt-formatted-string/yt-formatted-string/text()').get()
        # dislike
        # <yt-formatted-string id="text" class="style-scope ytd-toggle-button-renderer style-text" aria-label="10 lượt không thích">10</yt-formatted-string>
        dislike = response.xpath('//a/yt-formatted-string/yt-formatted-string/text()').get()
        # view
        # <span class="view-count style-scope ytd-video-view-count-renderer">16.081 lượt xem</span>
        view = response.xpath('//ytd-video-view-count-renderer/span/text()').get()
        # time_up
        # <yt-formatted-string class="style-scope ytd-video-primary-info-renderer">8 thg 11, 2021</yt-formatted-string>
        time_up = response.xpath('//span[@id="dot"]/yt-formatted-string/text()').get()
        # count_response_vid
        # <span dir="auto" class="style-scope yt-formatted-string">23</span>
        count_response_vid = response.xpath('//h2/yt-formatted-string/span[@dir="auto"]/text()').get()

        item = CrawlerItem()
        item['name'] = name
        item['url'] = url
        item['like'] = like
        item['dislike'] = dislike
        item['view'] = view
        item['time_up'] = time_up
        item['count_response_vid'] = count_response_vid
        yield item        
        pass 