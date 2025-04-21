import logging
from pathlib import Path

import clerk

from lucifer import download_waiter, init_driver

logging.basicConfig(level=logging.INFO, handlers=[clerk.rich_handler()])
log = logging.getLogger(__name__)
# config driver
download_dir = Path(__file__).parents[2] / "temp" / "sony-camera-remote-sdk"


# open web
log.info("download win")
driver = init_driver(download_dir)
driver.get("https://support.d-imaging.sony.co.jp/disoft_DL/SDK_DL/win?fm=en-us")
download_waiter(download_dir, "*.zip")

log.info("download mac")
driver = init_driver(download_dir)
driver.get("https://support.d-imaging.sony.co.jp/disoft_DL/SDK_DL/mac?fm=en-us")
download_waiter(download_dir, "*.zip")
driver.close()

log.info("download linux arm32")
driver = init_driver(download_dir)
driver.get("https://support.d-imaging.sony.co.jp/disoft_DL/SDK_DL/linux_32?fm=en-us")
download_waiter(download_dir, "*.zip")
driver.close()

log.info("download linux arm64")
driver = init_driver(download_dir)
driver.get("https://support.d-imaging.sony.co.jp/disoft_DL/SDK_DL/linux_64?fm=en-us")
download_waiter(download_dir, "*.zip")
driver.close()

log.info("download linux x64")
driver = init_driver(download_dir)
driver.get("https://support.d-imaging.sony.co.jp/disoft_DL/SDK_DL/linux_x86?fm=en-us")
download_waiter(download_dir, "*.zip")
driver.close()
