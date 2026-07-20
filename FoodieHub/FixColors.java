import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;
import java.nio.file.attribute.BasicFileAttributes;
import java.util.regex.Pattern;

public class FixColors {
    public static void main(String[] args) throws IOException {
        Path startPath = Paths.get("src/main/webapp/WEB-INF/views");
        Pattern pattern = Pattern.compile("rgba\\(255,\\s*255,\\s*255,\\s*0\\.\\d+\\)");
        
        Files.walkFileTree(startPath, new SimpleFileVisitor<Path>() {
            @Override
            public FileVisitResult visitFile(Path file, BasicFileAttributes attrs) throws IOException {
                if (file.toString().endsWith(".jsp")) {
                    String content = new String(Files.readAllBytes(file), StandardCharsets.UTF_8);
                    String replaced = pattern.matcher(content).replaceAll("#ffffff");
                    
                    // Also replace single transparent colors like rgba(255,255,255, 0.x) 
                    // The regex above handles optional spaces.
                    
                    if (!content.equals(replaced)) {
                        Files.write(file, replaced.getBytes(StandardCharsets.UTF_8));
                        System.out.println("Fixed: " + file.toString());
                    }
                }
                return FileVisitResult.CONTINUE;
            }
        });
        System.out.println("Done fixing colors.");
    }
}
