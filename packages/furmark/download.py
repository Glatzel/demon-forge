import logging
from pathlib import Path

from selenium.webdriver.common.by import By
from toolbox import clerk

from lucifer import download_waiter, find_button, find_element, init_driver

logging.basicConfig(level=logging.INFO, handlers=[clerk.rich_handler()])
log = logging.getLogger(__name__)
# config driver
download_dir = Path(__file__).parents[2] / "temp" / "furmark"

driver = init_driver(download_dir)

# open web
driver.get("https://geeks3d.com/furmark/downloads/")

# find download
element = find_element(driver, By.XPATH, "//a[contains(.,'- win64 - (ZIP)')]")
url = element.get_attribute("href")
log.info(f"download page: {url}")
driver.get(url)  # type: ignore
element = find_button(driver, By.XPATH, "//p[@id='dlbutton']/a")
element.click()
download_waiter(download_dir, "*.zip")
