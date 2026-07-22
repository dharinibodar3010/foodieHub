import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;
import java.nio.file.attribute.BasicFileAttributes;

public class FixColors {
    public static void main(String[] args) throws IOException {
        Path startPath = Paths.get("src/main/webapp/WEB-INF/views");
        
        Files.walkFileTree(startPath, new SimpleFileVisitor<Path>() {
            @Override
            public FileVisitResult visitFile(Path file, BasicFileAttributes attrs) throws IOException {
                if (file.toString().endsWith(".jsp")) {
                    String content = new String(Files.readAllBytes(file), StandardCharsets.UTF_8);
                    
                    String replaced = content.replace("#ff4500", "#FF5E00")
                                             .replace("255,69,0", "255,94,0")
                                             .replace("255, 69, 0", "255, 94, 0")
                                             .replace("#ff8c00", "#FFD700"); 
                    
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
