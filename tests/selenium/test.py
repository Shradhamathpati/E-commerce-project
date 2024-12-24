from selenium import webdriver

driver = webdriver.Chrome()
driver.get("http://localhost:8080")
assert "My App" in driver.title
driver.quit()

