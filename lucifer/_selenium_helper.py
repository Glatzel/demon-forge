from selenium.webdriver import Edge
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import WebDriverWait


def find_element(driver: Edge, by: str, value: str, timeout: float = 10):
    WebDriverWait(driver, timeout).until(EC.presence_of_element_located((by, value)))
    element = driver.find_element(by, value)
    return element


def find_button(driver: Edge, by: str, value: str, timeout: float = 10):
    WebDriverWait(driver, timeout).until(EC.element_to_be_clickable((by, value)))
    element = driver.find_element(by, value)
    return element
