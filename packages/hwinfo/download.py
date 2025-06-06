import logging
from pathlib import Path

from selenium.webdriver.common.by import By
from toolbox import clerk

from lucifer import download_waiter, find_element, init_driver

logging.basicConfig(level=logging.INFO, handlers=[clerk.rich_handler()])
log = logging.getLogger(__name__)
# config driver
download_dir = Path(__file__).parents[2] / "temp" / "hwinfo"
driver = init_driver(download_dir)

# open web
driver.get("https://www.hwinfo.com/download/")

# find download

element = find_element(driver, By.XPATH, "//a[contains(.,'SAC ftp')and contains(@href,'zip')]")
url = element.get_attribute("href")
driver.get(url)  # type: ignore
download_waiter(download_dir, "*.zip")
