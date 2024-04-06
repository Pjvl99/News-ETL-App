import scrapy
from datetime import datetime
class ElSigloSpider(scrapy.Spider):
    
    name = "elsiglo"
    start_urls = ["https://elsiglo.com.gt/"]
    
    def parse(self, response):
        try:
            print("\n\nStarting project: elsiglo\n\n")
            if response.status == 200:
                nav_items = response.css(".menu > li > a")
                for item_level_one in nav_items:
                    href = item_level_one.xpath("@href").get()
                    category = item_level_one.css("a::text").get(default="not-found")
                    if not "elsiglo.com" in href:
                        break
                    if category != "Inicio":
                        meta = {"category": category}
                        if href:
                            yield response.follow(href, callback=self.get_news_items, meta=meta)
            else:
                print("Error in connection:", response.url)
        except Exception as e:
            print(str(e))
    
    def get_news_items(self, response):
        try:
            print(f"In category: {response.meta['category']} url: {response.url}\n\n")
            if response.status == 200:
                posts = response.css("article[class^=' post-']")
                for post in posts:
                    img_url = post.css(".cm-featured-image > a > img").xpath("@src").get(default="not-found")
                    post_url = post.css(".cm-featured-image > a").xpath("@href").get()
                    title = post.css(".cm-entry-title > a").xpath("@title").get(default="not-found")
                    datetime_data = post.css("time[class^='entry-date published']").xpath("@datetime").get(default="1999-01-01T07:40:01-06:00")
                    datetime_object = datetime.fromisoformat(datetime_data)
                    author = post.css("a[class^='url fn n']").xpath("@title").get(default="not-found")
                    tags = post.css(".cm-post-categories")
                    subcategory = ""
                    for tag in tags:
                        subcategory = tag.css("a::text").get()
                        break
                    if post_url:
                        meta = {
                            "category": response.meta["category"],
                            "img_url": img_url,
                            "title": title,
                            "datetime_data": datetime_object.date(),
                            "author": author,
                            "subcategory": subcategory
                            }
                        yield response.follow(post_url, callback=self.get_description, meta=meta)
                page_url = response.css(".previous > a").xpath("@href").get()
                if page_url:
                    meta = {"category": response.meta["category"]}
                    yield response.follow(page_url, callback=self.get_news_items, meta=meta)
            else:
                print("Error in connection:", response.url)
        except Exception as e:
            print(str(e))

    def get_description(self, response):
        try:
            if response.status == 200:
                description = response.css(".cm-entry-summary p, h2, ol")
                final_description = ""
                for item in description:
                    final_description += item.get()
                yield {
                    "category": response.meta["category"],
                    "img_url": response.meta["img_url"],
                    "title": response.meta["title"],
                    "date": response.meta["datetime_data"],
                    "author": response.meta["author"],
                    "subcategory": response.meta["subcategory"],
                    "description": final_description,
                    "news_site": "elsiglo"
                }
            else:
                print("Error in connection:", response.url)
        except Exception as e:
            print(str(e))

        