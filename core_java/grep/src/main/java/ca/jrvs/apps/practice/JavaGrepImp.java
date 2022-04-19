package ca.jrvs.apps.practice;

import com.sun.org.slf4j.internal.Logger;
import com.sun.org.slf4j.internal.LoggerFactory;
import org.apache.log4j.BasicConfigurator;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

public class JavaGrepImp implements JavaGrep{

    final Logger logger = LoggerFactory.getLogger(JavaGrep.class);

    private String regex;
    private String rootPath;
    private String outFile;


    public static void main(String[] args) throws IOException {
        if (args.length != 3) {
            throw new IllegalArgumentException("USAGE: JavaGrep regex rootPath outFile");
        }

        /*List<String> test = new ArrayList<String>();
        test.add("Does");
        test.add("this");
        test.add("work");*/

        //Use default loffer config
        //ORBConfiguratorImpl BasicConfigurator;
        BasicConfigurator.configure();

        JavaGrepImp javaGrepImp = new JavaGrepImp();
        javaGrepImp.setRegex(args[0]);
        javaGrepImp.setRootPath(args[1]);
        javaGrepImp.setOutFile(args[2]);


        /* THIS SECTION WAS USED TO TEST EVERY METHOD
        try {
            javaGrepImp.process();
        } catch (Exception ex) {
            javaGrepImp.logger.error("Error: Unable to process", ex);
        }
        //lists all file in the root directory
        javaGrepImp.listFiles(javaGrepImp.getRootPath());
        //Prints out the full shakespeare txt file and assigns it to variable book

        String book = null;
        try {
            book = String.valueOf(javaGrepImp.readLines(new File("/home/centos/dev/jarvis_data_eng_Francois/core_java/grep/data/txt/shakespeare.txt")));
        } catch (IOException e) {
            e.printStackTrace();
        }
        javaGrepImp.containsPattern(book);

        javaGrepImp.writeToFile(test);*/

        javaGrepImp.process();


    }

    @Override
    public void process() throws IOException {

        List<String> matchedLines = new ArrayList<String>();
        for(File file: listFiles(getRootPath())){
            for (String line : readLines(file)){
                if(containsPattern(line)){
                    matchedLines.add(line);
                }
            }
        } writeToFile(matchedLines);
    }
    @Override
    public List<File> listFiles(String rootDir) {
        List<File> listOfFiles = new ArrayList<File>();
        File dir = new File(rootDir);
        for ( File file: Objects.requireNonNull(dir.listFiles())){
            if(file.isFile()) {
                listOfFiles.add(file);
                System.out.println(file);
            }else{
                listOfFiles.addAll(listFiles(file.getPath()));

            }
        }
        return listOfFiles;
    }

    @Override
    public List<String> readLines(File inputFile) throws IOException {
        //Path path = Paths.get(String.valueOf(inputFile));
        List<String> lines = Files.readAllLines(Paths.get(inputFile.getPath()), StandardCharsets.UTF_8);
        //System.out.println(lines);
        return lines;
    }

    @Override
    public boolean containsPattern(String line) {
        if(line.matches(".*Romeo.*Juliet.*")){
            //System.out.println("true");
            return true;
        }else{
            return false;
        }
    }

    @Override
    public void writeToFile(List<String> lines) throws IOException {
        try {
            File outFile = new File(getOutFile());
                System.out.println("File Created: " + outFile.getName());
                FileWriter myWriter = new FileWriter(getOutFile());
                for (String line :lines) {
                    myWriter.write(line);
                } myWriter.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    @Override
    public String getRegex() {
        return regex;
    }

    @Override
    public void setRegex(String regex) {
        this.regex = regex;
    }

    @Override
    public String getRootPath() {
        return rootPath;
    }

    @Override
    public void setRootPath(String rootPath) {
        this.rootPath = rootPath;
    }

    @Override
    public String getOutFile() {
        return outFile;
    }

    @Override
    public void setOutFile(String outFile) {
        this.outFile = outFile;
    }
}
    

   