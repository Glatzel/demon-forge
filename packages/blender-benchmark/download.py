import logging

from selenium.webdriver.common.by import By
from toolbox import clerk

from lucifer import download_waiter, find_element, init_driver

logging.basicConfig(level=logging.INFO, handlers=[clerk.rich_handler()])
log = logging.getLogger(__name__)
driver = init_driver()

# open web
driver.get("https://opendata.blender.org/")

# find download
element = find_element(driver, By.XPATH, "//a[contains(@title,'Windows') and span='Windows CLI']")
url = element.get_attribute("href")
log.info(f"download url: {url}")
driver.get(url)  # type: ignore
download_waiter("*.zip")
