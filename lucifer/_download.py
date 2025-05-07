import logging
import time
from pathlib import Path

from selenium.webdriver import Edge
from selenium.webdriver.edge.options import Options as EdgeOptions

log = logging.getLogger()


def init_driver(download_dir: str | Path, windows_size: tuple[int, int] = (1920, 1080), headless: bool = True) -> Edge:
    download_dir = Path(download_dir)
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
    options.add_argument("--headless=new") if headless else None
    options.add_argument(f"--window-size={windows_size[0]},{windows_size[1]}")
    options.add_argument(
        "user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"  # noqa: E501
    )
    options.add_argument("--disable-blink-features=AutomationControlled")
    options.add_experimental_option("excludeSwitches", ["enable-automation"])
    options.add_experimental_option("useAutomationExtension", False)
    driver = Edge(options=options)
    return driver


















def download_waiter           (download_dir: str         | Path, pattern: str, timeout=100):
    log.info("Start download.")

    download_dir = Path(download_dir)
    # Wait for file to appear
    waited = 0
    while waited < timeout:
        if len(list(download_dir.glob(pattern))):
            file = next(iter(download_dir.glob(pattern))).absolute()
            log.info(f"Download to: {file}")
            break
        time.sleep(1)
        waited += 1
    else:
        msg = "File didn't download in time"
        log.error(msg)
        raise TimeoutError(msg)
    log.info("Finish download.")
