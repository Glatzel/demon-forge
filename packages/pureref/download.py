import logging
import time
from pathlib import Path

import clerk
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import Select, WebDriverWait

from lucifer import download_waiter, find_button, find_element, init_driver

logging.basicConfig(level=logging.INFO, handlers=[clerk.rich_handler()])
log = logging.getLogger(__name__)
# config driver
download_dir = Path(__file__).parents[2] / "temp" / "pureref"
driver = init_driver(download_dir, windows_size=(2160, 4096))

# open web
driver.get("https://www.pureref.com/download.php")
element = find_element(driver, By.ID, "personalSelector")
driver.execute_script("arguments[0].scrollIntoView();", element)
time.sleep(5)

# choose win portable
element = find_element(driver, By.XPATH, "//div[@id='buildSelect']/label/div/span/select")
log.info("click drop down menu")
select_element = Select(element)
select_element.select_by_index(1)
log.info("select windows portable")

# set price
element = find_element(driver, By.ID, "customAmount")
element.click()
log.info("click custom amount")
element = find_element(driver, By.NAME, "amount")
element.clear()
element.send_keys("0")
log.info("set amount to zero")
driver.execute_script("arguments[0].dispatchEvent(new Event('change'))", element)

# download
element = find_button(driver, By.XPATH, """//*[@id="freeDownload"]/button""")
element.click()
download_waiter(download_dir, "*.zip")
