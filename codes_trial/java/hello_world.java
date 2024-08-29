import java.util.HashMap;

class hello_world {
    public static HashMap myObject(Object... parameters) {
        HashMap<String, Object> newObject = new HashMap<>();
        try {
            if ((parameters.length % 2) != 0) {
                throw new Exception("Arguments must be even.");
            }
            for (int i = 0; i <= ((parameters.length / 2) + 1); i += 2) {
                newObject.put(parameters[i].toString(), parameters[i + 1]);
            }
        } catch (Exception ex) {
            System.out.println("Exception occurred: " + ex.getMessage());
        }
        return newObject;
    }
    public static void main(String[] args) {
        System.out.println("Hello, World!");
        Object something = myObject(
            "name", "Alisa",
            "country", "Finland",
            "age", 25
        );
        System.out.println("something: " + something);
    }
}
