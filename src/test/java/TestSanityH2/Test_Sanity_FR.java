package TestSanityH2;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;
import java.util.Properties;
import java.util.concurrent.TimeUnit;

import org.openqa.selenium.Alert;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.firefox.FirefoxOptions;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.testng.Assert;
import org.testng.annotations.AfterClass;
import org.testng.annotations.AfterTest;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.BeforeTest;
import org.testng.annotations.Test;

public class Test_Sanity_FR {
	public WebDriver driver;
	Properties config1;
	FileInputStream fis;

	@Test(priority=0)
	public void chkTitle() {
		String Expected_Title = "Student Data";
		String Actual_Title = driver.findElement(By.xpath("//h2[contains(text(),'Student Data')]")).getText();
		System.out.println(Actual_Title);
		Assert.assertEquals(Actual_Title, Expected_Title);
	}

    @Test(priority=1)
    public void insertData(){
		driver.findElement(By.id("id")).clear();
		driver.findElement(By.id("id")).sendKeys("987654321");
	    
		driver.findElement(By.id("name")).clear();
		driver.findElement(By.id("name")).sendKeys("TechTejendra");
		
		driver.findElement(By.id("age")).clear();
		driver.findElement(By.id("age")).sendKeys("31");
		
		driver.findElement(By.id("email")).clear();
		driver.findElement(By.id("email")).sendKeys("thecloudteacher@gmail.com");

	    driver.findElement(By.id("addst")).click();
		driver.manage().timeouts().implicitlyWait(50, TimeUnit.SECONDS);
		
		String Expected_id = "987654321";
		String Actual_id = driver.findElement(By.id("did")).getText();
		System.out.println(Actual_id);
		Assert.assertEquals(Actual_id, Expected_id);
	}

	@BeforeClass
	public void beforeClass() {
		System.setProperty("webdriver.gecko.driver","geckodriver");
		//System.setProperty("webdriver.gecko.driver","geckodriver.exe");
        FirefoxOptions opt = new FirefoxOptions();
        opt.setHeadless(true);
        driver = new FirefoxDriver(opt);
		readProperty();
		driver.get(config1.getProperty("h2url"));
		WebDriverWait wait = new WebDriverWait(driver,500);
		wait.until(ExpectedConditions.elementToBeClickable(By.id("id"))); 
	}

	@AfterClass
	public void afterClass() {
		driver.close();
	}

	public void readProperty(){
		config1 = new Properties();
		try{
			fis = new FileInputStream(System.getProperty("user.dir")+"/config.properties");
			config1.load(fis);
		}catch(IOException io){
			io.printStackTrace();
		}
    }
}