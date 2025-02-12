@SuppressWarnings("unchecked")
public class Program {
    public static <T> T[] createVariable(T anything) {
        return new T[]{(T) anything};
    }
    public static void main(String[] args) {
        int[] something = createVariable(0);
        System.out.println(something[0]);
    }
}
