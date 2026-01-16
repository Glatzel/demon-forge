import logging

from selenium.webdriver.common.by import By
from toolbox import clerk

from lucifer import download_waiter, find_element, init_driver

logging.basicConfig(level=logging.INFO, handlers=[clerk.rich_handler()])
log = logging.getLogger(__name__)
# config driver
driver = init_driver()

# open web
driver.get("https://filezilla-project.org/download.php?show_all=1")

# find download
element = find_element(driver, By.XPATH, "//a[contains(.,'win64.zip')]")
log.info("click download")
element.click()
download_waiter("*.zip")
