import logging
from pathlib import Path

import clerk
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import WebDriverWait

from lucifer import download_waiter, init_driver

logging.basicConfig(level=logging.INFO, handlers=[clerk.rich_handler()])
log = logging.getLogger(__name__)
# config driver
download_dir = Path(__file__).parents[2] / "temp" / "hwinfo"
driver = init_driver(download_dir)

# open web
driver.get("https://www.hwinfo.com/download/")

# find download
WebDriverWait(driver, 10).until(
    EC.presence_of_element_located((By.XPATH, "//a[contains(.,'SAC ftp')and contains(@href,'zip')]"))
)
element = driver.find_element(By.XPATH, "//a[contains(.,'SAC ftp')and contains(@href,'zip')]")
url = element.get_attribute("href")
driver.get(url)  # type: ignore
download_waiter(download_dir, "*.zip")
