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
download_dir = Path(__file__).parents[2] / "temp" / "imagemagick"
options = EdgeOptions()
options.add_experimental_option(
    "prefs",
    {
        "download.default_directory": str(download_dir),
        "download.directory_upgrade": True,
        "download_parallel": True,  # Enable parallel downloads
        "download_max_connections": 8,  # Number of parallel connections
    },
)
options.add_argument("--force-device-scale-factor=0.5")
options.add_argument("--headless=new")
options.add_argument("--window-size=1920,1080")
options.add_argument(
    "user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
)
options.add_argument("--disable-blink-features=AutomationControlled")
options.add_experimental_option("excludeSwitches", ["enable-automation"])
options.add_experimental_option("useAutomationExtension", False)

driver = webdriver.Edge(options=options)

# open web
driver.get("https://imagemagick.org/script/download.php")

# find download
WebDriverWait(driver, 10).until(
    EC.presence_of_element_located(
        (By.XPATH, "//a[contains(.,'-portable-Q16-HDRI-x64.zip')]")
    )
)
element = driver.find_element(By.XPATH, "//a[contains(.,'-portable-Q16-HDRI-x64.zip')]")
url = element.get_attribute("href")
log.info(f"download url: {url}")
driver.get(url)  # type: ignore
log.info("start download")
# Wait for file to appear
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
