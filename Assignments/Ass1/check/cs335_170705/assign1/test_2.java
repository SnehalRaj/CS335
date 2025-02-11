void run() throws Exception {
    String PS = File.pathSeparator;
    writeFile("src1/p/A.java",
            "package p; public class A { }");
    compile("-d", "classes1", "src1/p/A.java");

    writeFile("src2/q/B.java",
            "package q; public class B extends p.A { }");
    compile("-d", "classes2", "-classpath", "classes1", "src2/q/B.java");

    writeFile("src/Test.java",
            "/** &0; */ class Test extends q.B { }");

    test("src/Test.java", "-sourcepath", "src1" + PS + "src2");
    test("src/Test.java", "-classpath", "classes1" + PS + "classes2");

    File testJar = createJar();
    test("src/Test.java", "-bootclasspath",
            testJar + PS + "classes1" + PS + "classes2");

    if (errors > 0)
        throw new Exception(errors + " errors found");
}
public static void main(String[] args)
        throws Throwable {

    String baseDir = System.getProperty("user.dir") + File.separator;
    String javac = JDKToolFinder.getTestJDKTool("javac");
    String java = JDKToolFinder.getTestJDKTool("java");

    setup(baseDir);
    String srcDir = System.getProperty("test.src");
    String cp = srcDir + File.separator + "a" + File.pathSeparator
            + srcDir + File.separator + "b.jar" + File.pathSeparator
            + ".";
    List<String[]> allCMDs = List.of(
            // Compile command
            new String[]{
                    javac, "-cp", cp, "-d", ".",
                    srcDir + File.separator + TEST_NAME + ".java"
            },
            // Run test the first time
            new String[]{
                    java, "-cp", cp, TEST_NAME, "1"
            },
            // Run test the second time
            new String[]{
                    java, "-cp", cp, TEST_NAME, "2"
            }
    );

    for (String[] cmd : allCMDs) {
        ProcessTools.executeCommand(cmd)
                    .outputTo(System.out)
                    .errorTo(System.out)
                    .shouldHaveExitValue(0);
    }
}