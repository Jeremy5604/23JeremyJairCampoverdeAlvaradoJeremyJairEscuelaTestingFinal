package examples.store;

import com.intuit.karate.junit5.Karate;

public class StoreRunner {

    @Karate.Test
    Karate testUsers() {
        return Karate.run("store").relativeTo(getClass());
    }

}
