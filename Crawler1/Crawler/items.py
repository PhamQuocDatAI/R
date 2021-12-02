# Define here the models for your scraped items
#
# See documentation in:
# https://docs.scrapy.org/en/latest/topics/items.html

import scrapy


class CrawlerItem(scrapy.Item):
    # define the fields for your item here like:
    # name = scrapy.Field()
    name = scrapy.Field()
    url = scrapy.Field()
    like = scrapy.Field()
    dislike = scrapy.Field()
    view = scrapy.Field()
    time_up = scrapy.Field()
    count_response_vid =scrapy.Field()
    pass
