import logging
import sys
from pathlib import Path

from toolbox import clerk

from lucifer import download_waiter, init_driver

download_dir = Path(__file__).parents[2] / "temp" / "sony-camera-remote-sdk"
logging.basicConfig(level=logging.INFO, handlers=[clerk.rich_handler()])
log = logging.getLogger(__name__)

match sys.platform:
    case "win32":
        log.info("win")
        driver = init_driver(download_dir)
        driver.get("https://support.d-imaging.sony.co.jp/disoft_DL/SDK_DL/win?fm=en-us")
        download_waiter(download_dir, "*Win64.zip")
        driver.close()

    case "darwin":
        log.info("macos")
        driver = init_driver(download_dir)
        driver.get("https://support.d-imaging.sony.co.jp/disoft_DL/SDK_DL/mac?fm=en-us")
        download_waiter(download_dir, "*Mac.zip")
        driver.close()

    case "linux":
        import os
        match os.uname().machine:
            case "x86_64":
                log.info("linux arm64")
                driver = init_driver(download_dir)
                driver.get("https://support.d-imaging.sony.co.jp/disoft_DL/SDK_DL/linux_64?fm=en-us")
                download_waiter(download_dir, "*Linux64ARMv8.zip")
                driver.close()
            case "aarch64":
                log.info("linux x64")
                driver = init_driver(download_dir)
                driver.get("https://support.d-imaging.sony.co.jp/disoft_DL/SDK_DL/linux_x86?fm=en-us")
                download_waiter(download_dir, "*Linux64PC.zip")
                driver.close()
