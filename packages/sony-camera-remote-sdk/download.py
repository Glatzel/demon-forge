import logging
from pathlib import Path

from toolbox import clerk

from lucifer import download_waiter, init_driver

download_dir = Path(__file__).parents[2] / "temp" / "sony-camera-remote-sdk"
logging.basicConfig(level=logging.INFO, handlers=[clerk.rich_handler()])
log = logging.getLogger(__name__)

# open web
log.info("win")
driver = init_driver(download_dir)
driver.get("https://support.d-imaging.sony.co.jp/disoft_DL/SDK_DL/win?fm=en-us")
download_waiter(download_dir, "*Win64.zip")
driver.close()


log.info("macos")
driver = init_driver(download_dir)
driver.get("https://support.d-imaging.sony.co.jp/disoft_DL/SDK_DL/mac?fm=en-us")
download_waiter(download_dir, "*Mac.zip")
driver.close()

log.info("linux x64")
driver = init_driver(download_dir)
driver.get("https://support.d-imaging.sony.co.jp/disoft_DL/SDK_DL/linux_x86?fm=en-us")
download_waiter(download_dir, "*Linux64PC.zip")
driver.close()
