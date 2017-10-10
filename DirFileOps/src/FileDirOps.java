import java.io.File;


public class FileDirOps {

	public static void main(String[] args) {
		File saveDir = new File("C:\\PMS_PDF\\Backup");
		if (!saveDir.exists()){
			saveDir.mkdirs();
			System.out.println("Directories MADE");
		} else{
			System.out.println("Directories Exists");
		}

	}

}
