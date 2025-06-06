import logging
from pathlib import Path

from selenium.webdriver.common.by import By
from toolbox import clerk

from lucifer import download_waiter, find_element, init_driver

logging.basicConfig(level=logging.INFO, handlers=[clerk.rich_handler()])
log = logging.getLogger(__name__)
# config driver
download_dir = Path(__file__).parents[2] / "temp" / "everything"
driver = init_driver(download_dir)

# open web
driver.get("https://www.voidtools.com/zh-cn/downloads/")

# download
element = find_element(driver, By.LINK_TEXT, "下载便携版 64 位")
log.info("find download button")
element.click()
log.info("click download button")

download_waiter(download_dir, "*.zip")
