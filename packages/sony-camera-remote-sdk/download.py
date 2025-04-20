import logging
import sys
from pathlib import Path

import clerk

from lucifer import download_waiter, init_driver

logging.basicConfig(level=logging.INFO, handlers=[clerk.rich_handler()])
log = logging.getLogger(__name__)
# config driver
download_dir = Path(__file__).parents[2] / "temp" / "sony-camera-remote-sdk"
driver = init_driver(download_dir)

# open web
match sys.platform:
    case "win32":
        log.info("win")
        driver.get("https://support.d-imaging.sony.co.jp/disoft_DL/SDK_DL/win?fm=en-us")
    case "darwin":
        log.info("macos")
        driver.get("https://support.d-imaging.sony.co.jp/disoft_DL/SDK_DL/win?fm=en-us")
    case "linux":
        log.info("linux")
        driver.get("https://support.d-imaging.sony.co.jp/disoft_DL/SDK_DL/win?fm=en-us")
download_waiter(download_dir, "*.zip")
