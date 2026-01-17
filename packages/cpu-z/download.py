import logging

from selenium.webdriver.common.by import By
from toolbox import clerk

from lucifer import download_waiter, find_element, init_driver

logging.basicConfig(level=logging.INFO, handlers=[clerk.rich_handler()])
log = logging.getLogger(__name__)
driver = init_driver()

# open web
driver.get("https://www.cpuid.com/softwares/cpu-z.html")

# find download
element = find_element(
    driver,
    By.XPATH,
    "//a[@class='button icon-zip' and contains(./span/text(),'english') and contains(./span/em/text(),'64-bit')]",
)
url = element.get_attribute("href")
url = url.replace("downloads/", "")  # type: ignore
url = url.replace("www", "download")
log.info(f"download page: {url}")
driver.get(url)

download_waiter("*.zip")
