import logging
import sys

from toolbox import clerk

from lucifer import download_waiter, init_driver

logging.basicConfig(level=logging.INFO, handlers=[clerk.rich_handler()])
log = logging.getLogger(__name__)

match sys.platform:
    case "win32":
        log.info("win")
        driver = init_driver()
        driver.get("https://support.d-imaging.sony.co.jp/disoft_DL/SDK_DL/win?fm=en-us")
        download_waiter("*Win64.zip")
        driver.close()

    case "darwin":
        log.info("macos")
        driver = init_driver()
        driver.get("https://support.d-imaging.sony.co.jp/disoft_DL/SDK_DL/mac?fm=en-us")
        download_waiter("*Mac.zip")
        driver.close()

    case "linux":
        import os

        match os.uname().machine:
            case "x86_64":
                log.info("linux arm64")
                driver = init_driver()
                driver.get("https://support.d-imaging.sony.co.jp/disoft_DL/SDK_DL/linux_64?fm=en-us")
                download_waiter("*Linux64ARMv8.zip")
                driver.close()
            case "aarch64":
                log.info("linux x64")
                driver = init_driver()
                driver.get("https://support.d-imaging.sony.co.jp/disoft_DL/SDK_DL/linux_x86?fm=en-us")
                download_waiter("*Linux64PC.zip")
                driver.close()
