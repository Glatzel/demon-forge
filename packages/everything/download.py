import logging
import time
from pathlib import Path

import clerk
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.edge.options import Options as EdgeOptions
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import WebDriverWait

logging.basicConfig(level=logging.INFO, handlers=[clerk.rich_handler()])
log = logging.getLogger(__name__)
# config driver
download_dir = Path(__file__).parents[2] / "temp" / "everything"
options = EdgeOptions()
options.add_experimental_option(
    "prefs",
    {
        "download.default_directory": str(download_dir),
        "download.directory_upgrade": True,
    },
)
options.add_argument("--force-device-scale-factor=0.5")
options.add_argument("--headless=new")
driver = webdriver.Edge(options=options)
driver.set_window_size(2160, 4096)

# open web
driver.get("https://www.voidtools.com/zh-cn/downloads/")

# download
WebDriverWait(driver, 10).until(
    EC.presence_of_element_located((By.LINK_TEXT, "下载便携版 64 位"))
)
element = driver.find_element(By.LINK_TEXT, "下载便携版 64 位")
log.info("find download button")
element.click()
log.info("click download button")


# Wait for file to appear
log.info("start download")
max_wait = 100  # seconds
waited = 0
while waited < max_wait:
    if len(list(download_dir.glob("*.zip"))):
        break
    time.sleep(1)
    waited += 1
else:
    raise TimeoutError("File didn't download in time")
log.info("finish download")
