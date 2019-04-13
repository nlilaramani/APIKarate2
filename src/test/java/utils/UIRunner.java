/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;
import com.intuit.karate.ui.App;
import org.junit.Test;

/**
 *
 * @author 212616565
 */
public class UIRunner {
    @Test
    public void testApp() {
        App.run("src/test/java/features/BlogPosts.feature", "dev");
    } 
    
}
