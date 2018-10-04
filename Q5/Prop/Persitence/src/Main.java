import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;



public class Main {
    public static void main(String[] args) throws UnsupportedEncodingException{
        File DataDir = new File("./Data");
        DataDir.mkdir();

        if(DataDir.exists()) {
            String[] files = DataDir.list();
            for(String s : files) {
                new File(DataDir.getPath(), s).delete();
            }
            DataDir.delete();
        }
        try {
            PrintWriter writer = new PrintWriter("./Data/test.txt", "UTF-8");
            writer.println("Hello World!");
            writer.close();
        }
        catch (FileNotFoundException e) {
            System.out.println("File Not Found");
        }
    }
}
