import sys
from pathlib import Path

from lucifer import download_waiter, init_driver

# config driver
download_dir = Path(__file__).parents[2] / "temp" / "sony-camera-remote-sdk"


# open web
match sys.platform:
    case "win32":
        print("win")
        driver = init_driver(download_dir)
        driver.get("https://support.d-imaging.sony.co.jp/disoft_DL/SDK_DL/win?fm=en-us")
        download_waiter(download_dir, "*.zip")
    case "darwin":
        print("macos")
        driver = init_driver(download_dir)
        driver.get("https://support.d-imaging.sony.co.jp/disoft_DL/SDK_DL/mac?fm=en-us")
        download_waiter(download_dir, "*.zip")
    case "linux":
        print("linux")
        driver = init_driver(download_dir)
        driver.get("https://support.d-imaging.sony.co.jp/disoft_DL/SDK_DL/linux_32?fm=en-us")
        download_waiter(download_dir, "*.zip")
        driver.close()
        driver.get("https://support.d-imaging.sony.co.jp/disoft_DL/SDK_DL/linux_64?fm=en-us")
        download_waiter(download_dir, "*.zip")
        driver.close()
        driver.get("https://support.d-imaging.sony.co.jp/disoft_DL/SDK_DL/linux_x86?fm=en-us")
        download_waiter(download_dir, "*.zip")
        driver.close()
