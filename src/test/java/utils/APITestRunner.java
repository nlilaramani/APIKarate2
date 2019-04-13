/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;
import com.intuit.karate.junit4.Karate;
import cucumber.api.CucumberOptions;
import org.junit.runner.RunWith;


/**
 *
 * @author Owner
 */
@RunWith(Karate.class)
@CucumberOptions(features="./src/test/java/features",
  plugin = {"pretty", "html:target/cucumber","json:target/cucumber/cucumber.json"})
public class APITestRunner {

}
