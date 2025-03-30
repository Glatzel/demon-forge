import logging
from pathlib import Path

import clerk
from selenium.webdriver.common.by import By

from lucifer import download_waiter, find_element, init_driver

logging.basicConfig(level=logging.INFO, handlers=[clerk.rich_handler()])
log = logging.getLogger(__name__)
# config driver
download_dir = Path(__file__).parents[2] / "temp" / "imagemagick"
driver = init_driver(download_dir)

# open web
driver.get("https://imagemagick.org/script/download.php")

# find download

element = find_element(driver, By.XPATH, "//a[contains(.,'-portable-Q16-HDRI-x64.zip')]")
url = element.get_attribute("href")
log.info(f"download url: {url}")
driver.get(url)  # type: ignore
download_waiter(download_dir, "*.zip")
