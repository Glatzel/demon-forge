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
download_dir = Path(__file__).parents[2] / "temp" / "filezilla"
driver = init_driver(download_dir)

# open web
driver.get("https://filezilla-project.org/download.php?show_all=1")

# find download
WebDriverWait(driver, 10).until(EC.presence_of_element_located((By.XPATH, "//a[contains(.,'win64.zip')]")))
element = driver.find_element(By.XPATH, "//a[contains(.,'win64.zip')]")
log.info("click download")
element.click()
download_waiter(download_dir, "*.zip")
